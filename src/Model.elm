module Model exposing (..)
import Routing
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Dict exposing (..)
import Json.Encode
import Csv
import Array

type RequestState = 
    NotAsked
    | Loading
    | Error
    | Success


type alias Model =
    {
        route: Routing.Route,
        searchPage: SearchPage,
        homePage: HomePage,
        entryPage: EntryPage,
        batchPage: BatchPage        
    }

initialModel : Routing.Route -> Model
initialModel route = 
    { 
        route = route,

        homePage = {
            searchInput = ""
        },

        searchPage = {
            query_params = "",
            searchData = {
                status = NotAsked,
                error = "",
                data = []
            }
        },

        entryPage = {
            infoData = {
                status = NotAsked,
                error = "",
                data = emptyInfo
            },
            proteoformsData = {
                status = NotAsked,
                error = "",
                data = []
            },
            ptmDependentPPIData = {
                status = NotAsked,
                error = "",
                data = []
            },
            proteoformPPIData = {
                status = NotAsked,
                error = "",
                data = []
            },
            substrateData = {
                status = NotAsked,
                error = "",
                data = Dict.empty
            }
        },

        batchPage = {
            kinases = [],
            outputType = Enzymes,
            batchEnzymeData = {
                status = NotAsked,
                error = "",
                data = []
            },
            batchPTMPPIData = {
                status = NotAsked,
                error = "",
                data = []
            }
        }
    }

-- Home page
type alias HomePage = 
    {
        searchInput: String
    }

setHomePage : Model -> HomePage -> Model
setHomePage model newHomePage = 
    { model | homePage = newHomePage}

setSearchInput: HomePage -> String -> HomePage
setSearchInput homePage newInput =
    { homePage | searchInput = newInput }

-- Search page
type alias SearchPage = 
    {
        query_params : String,
        searchData: SearchData
    }

type alias SearchData = 
    {
        status: RequestState,
        error: String,
        data: List (SearchResult Organism)    
    }

type alias SearchResult organismDecoder = 
    {
        iptm_id:String,
        protein_name: String,
        gene_name: String,
        synonyms: (List String),
        organism: organismDecoder,
        substrate_role: Bool,
        substrate_num: Int,
        enzyme_role: Bool,
        enzyme_num: Int,
        ptm_dependent_ppi_role: Bool,
        ptm_dependent_ppi_num: Int,
        sites: Int,
        isoforms: Int   
    }

searchResultDecoder: Decoder (SearchResult Organism)
searchResultDecoder =
    decode SearchResult
        |> required "iptm_id" string
        |> required "protein_name" string
        |> optional "gene_name" string ""
        |> required "synonyms" (list string)
        |> required "organism" organismDecoder
        |> required "substrate_role" bool
        |> required "substrate_num" int
        |> required "enzyme_role" bool
        |> required "enzyme_num" int
        |> required "ptm_dependent_ppi_role" bool
        |> required "ptm_dependent_ppi_num" int
        |> required "sites" int
        |> required "isoforms" int

searchResultListDecoder: Decoder (List (SearchResult Organism))
searchResultListDecoder =
    list searchResultDecoder


setSearchPage : Model -> SearchPage -> Model
setSearchPage model newSearchPage = 
    { model | searchPage = newSearchPage}

setSearchData : SearchPage -> SearchData -> SearchPage
setSearchData searchPage newData =
    { searchPage | searchData = newData }

-- Entry page
type alias EntryPage = 
    {
        infoData: InfoData,
        proteoformsData: ProteoformsData,
        ptmDependentPPIData: PTMDependentPPIData,
        proteoformPPIData: ProteoformPPIData,
        substrateData: SubstrateData
    }

type alias InfoData = 
    {
        status: RequestState,
        error: String,
        data: Info    
    }

type alias ProteoformsData = 
    {
        status: RequestState,
        error: String,
        data: List (Proteoform Enzyme Source)
    }

type alias PTMDependentPPIData = 
    {
        status: RequestState,
        error: String,
        data: List (PTMDependentPPI Entity Source)
    }
    
type alias ProteoformPPIData = 
    {
        status: RequestState,
        error: String,
        data: List(ProteoformPPI Protein Source)
    }

type alias SubstrateData = 
    {
        status: RequestState,
        error: String,
        data: Dict String (List (Substrate Source SubstrateEnzyme))
    }

setEntryPage : Model -> EntryPage -> Model
setEntryPage model newEntryPage = 
    { model | entryPage = newEntryPage}

setInfo : EntryPage -> InfoData -> EntryPage
setInfo entryPage newInfo =
    { entryPage | infoData = newInfo }

setProteoforms : ProteoformsData -> List (Proteoform Enzyme Source) -> ProteoformsData
setProteoforms proteoformsData newProteoforms =
    { proteoformsData | data = newProteoforms, status = Success }

setProteoformsData: EntryPage -> ProteoformsData -> EntryPage
setProteoformsData entryPage newProteoformsData = 
    { entryPage | proteoformsData = newProteoformsData}

setPTMDependentPPIData: EntryPage -> PTMDependentPPIData -> EntryPage
setPTMDependentPPIData entryPage newData = 
    { entryPage | ptmDependentPPIData = newData}

setProteoformPPIData: EntryPage -> ProteoformPPIData -> EntryPage
setProteoformPPIData entryPage newData = 
    { entryPage | proteoformPPIData = newData}

setSubstrateData: EntryPage -> SubstrateData -> EntryPage
setSubstrateData entryPage newData = 
    { entryPage | substrateData = newData }


type alias Info = 
    {
       uniprot_ac : String,
       uniprot_id : String,
       gene_name : String,
       protein_name: String,
       synonymns: List String,
       organism: Organism,
       pro: PRO     
    }

infoDecoder: Decoder Info
infoDecoder =
    decode Info
        |> required "uniprot_ac" string
        |> required "uniprot_id" string
        |> required "gene_name" string
        |> required "protein_name" string
        |> required "synonyms" (list string)
        |> required "organism" organismDecoder
        |> required "pro" proDecoder


type alias Organism = 
    {
        taxon_code : String,
        species: String,
        common_name: String
    }

organismDecoder: Decoder Organism
organismDecoder = 
    decode Organism
        |> required "taxon_code" string
        |> required "species" string
        |> required "common_name" string

type alias PRO = 
    {
        id: String,
        name: String,
        definition: String,
        short_label: String,
        category: String
    }

proDecoder: Decoder PRO
proDecoder = 
    decode PRO
        |> required "id" string
        |> required "name" string
        |> required "definition" string
        |> required "short_label" string
        |> required "category" string

type alias Enzyme = 
    {
        pro_id: String,
        label: String   
    }

enzymeDecoder: Decoder Enzyme
enzymeDecoder = 
    decode Enzyme
        |> optional "pro_id" string ""
        |> optional "label" string ""

type alias SubstrateEnzyme = 
    {
        id: String,
        enz_type: String,
        name: String
    }

substrateEnzymeDecoder: Decoder SubstrateEnzyme
substrateEnzymeDecoder =
    decode SubstrateEnzyme
        |> optional "id" string ""
        |> optional "enz_type" string ""
        |> optional "name" string ""

type alias Source = 
    {
        name: String,
        label: String,
        url: String
    }

sourceDecoder: Decoder Source
sourceDecoder =
    decode Source
        |> required "name" string
        |> required "label" string
        |> required "url" string


type alias Proteoform enzymeDecoder sourceDecoder = 
    {
       pro_id: String,
       label : String,
       sites : List String,
       ptm_enzyme: enzymeDecoder,
       source: sourceDecoder 
    }

proteoformDecoder: Decoder (Proteoform Enzyme Source)
proteoformDecoder =
    decode Proteoform
        |> required "pro_id" string
        |> required "label" string
        |> required "sites" (list string)
        |> required "ptm_enzyme" enzymeDecoder
        |> required "source" sourceDecoder

proteoformListDecoder: Decoder (List (Proteoform Enzyme Source ))
proteoformListDecoder = 
    list proteoformDecoder

type alias Entity = 
    {
        uniprot_id : String,
        name: String
    }

entityDecoder: Decoder Entity
entityDecoder =
    decode Entity
    |> required "uniprot_id" string
    |> required "name" string

type alias PTMDependentPPI entityDecoder sourceDecoder= 
    {
        ptm_type: String,
        substrate: entityDecoder,
        site: String,
        interactant: entityDecoder,
        association_type: String,
        source: sourceDecoder,
        pmid: String
    }

ptmDependentPPIDecoder: Decoder (PTMDependentPPI Entity Source)
ptmDependentPPIDecoder = 
    decode PTMDependentPPI
        |> required "ptm_type" string
        |> required "substrate" entityDecoder
        |> required "site" string
        |> required "interactant" entityDecoder
        |> required "association_type" string
        |> required "source" sourceDecoder
        |> required "pmid" string

ptmDependentPPIListDecoder: Decoder (List (PTMDependentPPI Entity Source))
ptmDependentPPIListDecoder = 
    list ptmDependentPPIDecoder


type alias Protein =
    {
        pro_id: String,
        label: String
    }

proteinDecoder: Decoder Protein
proteinDecoder = 
    decode Protein
    |> optional "pro_id" string ""
    |> optional "label" string ""

type alias ProteoformPPI proteinDecoder sourceDecoder=
    {
        protein_1: proteinDecoder,
        relation: String,
        protein_2: proteinDecoder,
        source: sourceDecoder,
        pmids: List  String
    }

proteoformPPIDecoder: Decoder (ProteoformPPI Protein Source)
proteoformPPIDecoder =
    decode ProteoformPPI
    |> required "protein_1" proteinDecoder
    |> required "relation" string
    |> required "protein_2" proteinDecoder
    |> required "source" sourceDecoder
    |> required "pmids" (list string)

proteoformPPIListDecoder: Decoder (List (ProteoformPPI Protein Source))
proteoformPPIListDecoder = 
    list proteoformPPIDecoder


type alias Substrate sourceDecoder substrateEnzymeDecoder = 
    {
        residue: String,
        site: String,
        ptm_type: String,
        score: Int,
        sources: (List sourceDecoder),
        enzymes: (List substrateEnzymeDecoder),
        pmids: (List String)
    }

substrateDecoder: Decoder (Substrate Source SubstrateEnzyme)
substrateDecoder = 
    decode Substrate
        |> optional "residue" string ""
        |> optional "site" string ""
        |> optional "ptm_type" string ""
        |> required "score" int
        |> required "sources" (list sourceDecoder)
        |> required "enzymes" (list substrateEnzymeDecoder)
        |> required "pmids" (list string)

substrateListDecoder: Decoder (List (Substrate Source SubstrateEnzyme))
substrateListDecoder = 
    list substrateDecoder

substrateTableDecoder: Decoder (Dict String (List (Substrate Source SubstrateEnzyme)) )
substrateTableDecoder =
    dict substrateListDecoder

emptyInfo: Info
emptyInfo = 
                {
                    uniprot_ac = "",
                    uniprot_id = "",
                    gene_name = "",
                    protein_name = "",
                    synonymns = [],
                    organism = {
                        taxon_code = "",
                        species = "",
                        common_name = ""
                    },
                    pro = {
                        id = "",
                        name = "",
                        definition = "",
                        short_label = "",
                        category = ""
                    }  
                }


-- Batch Page
type Output = Enzymes
              | PTMPPI

type alias BatchPage = 
 {
     kinases: List (Kinase),
     outputType: Output,
     batchEnzymeData : BatchEnzymeData,
     batchPTMPPIData : BatchPTMPPIData 
 }

type alias BatchEnzymeData = 
    {
        status: RequestState,
        error: String,
        data: List (BatchEnzyme Entity Source)    
    }

type alias BatchPTMPPIData = 
    {
        status: RequestState,
        error: String,
        data: List (BatchPTMPPI Entity Source)    
    }

type alias Kinase =
 {
     substrate_ac: String,
     site_residue: String,
     site_position: String
 }

toKinaseList : String -> List Kinase
toKinaseList csv_string =
    Csv.splitWith "\t" csv_string
    |> List.map toKinase

toKinase : (List String) -> Kinase
toKinase values =
    let
        values_arr = Array.fromList values
        
        -- substrate ac
        sub_ac = case Array.get 0 values_arr of
            Just value ->
                value
            Nothing ->
                ""

        -- site residue
        residue = case Array.get 1 values_arr of
            Just value ->
                value
            Nothing ->
                ""
        
        -- site position
        position = case Array.get 2 values_arr of
            Just value ->
                value
            Nothing ->
                ""

    in 
        {
            substrate_ac = sub_ac,
            site_residue = residue,
            site_position = position
        }

kinaseToJson : Kinase -> Json.Encode.Value
kinaseToJson kinase = 
    Json.Encode.object [
        ("substrate_ac",Json.Encode.string kinase.substrate_ac),
        ("site_residue",Json.Encode.string kinase.site_residue),
        ("site_position",Json.Encode.string kinase.site_position)
    ]

setBatchPage: Model -> BatchPage -> Model
setBatchPage model newBatchPage = 
    { model | batchPage = newBatchPage }

setKinases: BatchPage -> (List Kinase) -> BatchPage
setKinases batchPage newKinases =
    { batchPage | kinases = newKinases }


setBatchOutput: BatchPage -> Output -> BatchPage
setBatchOutput batchPage newOutput =
    { batchPage | outputType = newOutput }

setBatchEnzymeData: BatchPage -> BatchEnzymeData -> BatchPage
setBatchEnzymeData batchPage newData = 
    { batchPage | batchEnzymeData = newData }

setBatchPTMPPIData: BatchPage -> BatchPTMPPIData -> BatchPage
setBatchPTMPPIData batchPage newData = 
    { batchPage | batchPTMPPIData = newData }

-- Batch Result Enzymes
type alias BatchEnzyme entityDecoder sourceDecoder= 
    {
        ptm_type : String,
        substrate : entityDecoder,
        site: String,
        site_position: Int,
        enzyme: entityDecoder,
        score: Int,
        source: (List sourceDecoder),
        pmids: (List String)
    }

batchEnzymeDecoder: Decoder (BatchEnzyme Entity Source)
batchEnzymeDecoder =
    decode BatchEnzyme 
    |> required "ptm_type" string
    |> required "substrate" entityDecoder
    |> required "site" string
    |> required "site_position" int
    |> required "enzyme" entityDecoder
    |> required "score" int
    |> required "source" (list sourceDecoder)
    |> required "pmids" (list string)

batchEnzymeListDecoder: Decoder (List (BatchEnzyme Entity Source))
batchEnzymeListDecoder = 
    list batchEnzymeDecoder


-- Batch Result PTMPPI
type alias BatchPTMPPI entityDecoder sourceDecoder = 
    {
        ptm_type: String,
        substrate: entityDecoder,
        site: String,
        site_position: Int,
        interactant: entityDecoder,
        association_type: String,
        source: (List sourceDecoder),
        pmid: String
    }

batchPTMPPIDecoder: Decoder (BatchPTMPPI Entity Source)
batchPTMPPIDecoder =
    decode BatchPTMPPI
    |> required "ptm_type" string
    |> required "substrate" entityDecoder
    |> required "site" string
    |> required "site_position" int
    |> required "interactant" entityDecoder
    |> required "association_type" string
    |> required "source" (list sourceDecoder)
    |> required "pmids" string

batchPTMPPIListDecoder: Decoder (List (BatchPTMPPI Entity Source))
batchPTMPPIListDecoder = 
    list batchPTMPPIDecoder

