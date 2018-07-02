module Model exposing (..)
import Routing
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Dict exposing (..)
import Json.Encode
import Csv
import Array
import Css exposing (property)

type RequestState = 
    NotAsked
    | Loading
    | Error
    | Success

url : String
url = 
    -- "https://research.bioinformatics.udel.edu/iptmnet/api"
    "http://localhost:8088"



type alias Model =
    {
        route: Routing.Route,
        navbar: Navbar,
        searchPage: SearchPage,
        homePage: HomePage,
        entryPage: EntryPage,
        batchPage: BatchPage        
    }

setRoute: Model -> Routing.Route -> Model
setRoute model new_route = 
    {model | route = new_route }

initialModel : Routing.Route -> Model
initialModel route = 
    { 
        route = route,
        navbar = {
            searchOptions = {
                searchTerm = "",
                searchTermType = "",
                ptm_types = [],
                role = "Enzyme or Substrate",
                organisms_defaults = [],
                organisms_user = ""
            },
            isSearchVisible = False,
            advancedSearchVisibility = False
        },
        homePage = {
            searchOptions = {
                searchTerm = "",
                searchTermType = "All",
                ptm_types = [],
                role = "Enzyme or Substrate",
                organisms_defaults = [],
                organisms_user = ""
            },
            advancedSearchVisibility = False
        },

        searchPage = {
            query_params = "",
            searchData = {
                status = NotAsked,
                error = "",
                data = []
            },
            showErrorMsg = False
        },

        entryPage = {
            cytoscapeItems = [],
            infoData = {
                status = NotAsked,
                error = "",
                data = emptyInfo
            },
            showInfoErrorMsg = False,
            proteoformsData = {
                status = NotAsked,
                error = "",
                data = [],
                filterTerm = ""
            },
            showProteoformsErrorMsg = False,
            ptmDependentPPIData = {
                status = NotAsked,
                error = "",
                data = [],
                filterTerm = ""
            },
            showPTMDepPPIErrorMsg = False,
            proteoformPPIData = {
                status = NotAsked,
                error = "",
                data = [],
                filterTerm = ""
            },
            showProteoformsPPIErrorMsg = False,
            substrateData = {
                status = NotAsked,
                error = "",
                data = Dict.empty,
                tabData = {
                    tabs = [],
                    selectedTab = ""
                },
                filterTerm = ""
            },
            showSubstrateErrorMsg = False

        },

        batchPage = {
            kinases = [],
            outputType = Enzymes,
            batchEnzymeData = {
                status = NotAsked,
                error = "",
                data = {
                    list_found = {
                        count = 0,
                        with_enzyme = [],
                        without_enzyme = []
                    },
                    list_not_found = []
                }
            },
            selectedTab = "Input sites found in iPTMnet",
            batchPTMPPIData = {
                status = NotAsked,
                error = "",
                data = {
                    ptm_ppi = [],
                    sites_without_interactants = [],
                    not_found = []
                }
            },
            inputText = ""
        }
    }

-- Nav bar
type alias Navbar = 
    {
        searchOptions: SearchOptions,
        isSearchVisible: Bool,
        advancedSearchVisibility: Bool
    }

-- Home page
type alias HomePage = 
    {
        searchOptions: SearchOptions,
        advancedSearchVisibility: Bool
    }

setHomePage : Model -> HomePage -> Model
setHomePage model newHomePage = 
    { model | homePage = newHomePage}

setSearchOptions : HomePage -> SearchOptions -> HomePage
setSearchOptions homePage newSearchOptions = 
    { homePage | searchOptions = newSearchOptions }

setSelectedPTMTypes : SearchOptions -> (List String) -> SearchOptions
setSelectedPTMTypes searchOptions selected_ptms = 
    {searchOptions | ptm_types = selected_ptms}

setSelectedTaxons : SearchOptions -> (List String) -> SearchOptions
setSelectedTaxons searchOptions selected_taxons = 
    {searchOptions | organisms_defaults = selected_taxons}

setSearchRole : SearchOptions -> String -> SearchOptions
setSearchRole searchOptions new_role =
    {searchOptions | role = new_role}

setSearchTermType : SearchOptions -> String -> SearchOptions
setSearchTermType searchOptions new_term_type =
    {searchOptions | searchTermType = new_term_type}

setOrganismsUser : SearchOptions -> String -> SearchOptions
setOrganismsUser searchOptions new_taxons =
    {searchOptions | organisms_user = new_taxons}

setSearchInput: SearchOptions -> String -> SearchOptions
setSearchInput searchOptions newInput =
    { searchOptions | searchTerm = newInput }

setHomePageAdvancedSearchVisibility: Bool -> HomePage -> HomePage
setHomePageAdvancedSearchVisibility is_visible homePage =
    {homePage | advancedSearchVisibility = is_visible}


type alias SearchOptions = 
    {
        searchTerm : String,
        searchTermType : String,
        ptm_types : (List String),
        role : String,
        organisms_defaults: (List String),
        organisms_user: String
    }

-- Search page
type alias SearchPage = 
    {
        query_params : String,
        searchData: SearchData,
        showErrorMsg: Bool
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

setSearchShowErrorMsg: Bool -> SearchPage -> SearchPage
setSearchShowErrorMsg newValue searchPage =
    { searchPage | showErrorMsg = newValue }


-- Entry page
type alias EntryPage = 
    {
        cytoscapeItems: List CytoscapeItem,
        infoData: InfoData,
        showInfoErrorMsg: Bool,
        proteoformsData: ProteoformsData,
        showProteoformsErrorMsg: Bool,
        ptmDependentPPIData: PTMDependentPPIData,
        showPTMDepPPIErrorMsg: Bool,
        proteoformPPIData: ProteoformPPIData,
        showProteoformsPPIErrorMsg: Bool,
        substrateData: SubstrateData,
        showSubstrateErrorMsg: Bool
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
        data: List (Proteoform Enzyme Source),
        filterTerm: String
    }

type alias PTMDependentPPIData = 
    {
        status: RequestState,
        error: String,
        data: List (PTMDependentPPI Entity Source),
        filterTerm : String
    }
    
type alias ProteoformPPIData = 
    {
        status: RequestState,
        error: String,
        data: List(ProteoformPPI Protein Source),
        filterTerm: String
    }

type alias SubstrateData = 
    {
        status: RequestState,
        error: String,
        data: Dict String (List (Substrate Source SubstrateEnzyme)),
        tabData: TabData,
        filterTerm: String
    }

type alias Tab  = 
    {
        title : String,
        count : Int
    }

type alias TabData =
    {
        tabs: List Tab,
        selectedTab: String
    }

setEntryPage : Model -> EntryPage -> Model
setEntryPage model newEntryPage = 
    { model | entryPage = newEntryPage}

setInfo : EntryPage -> InfoData -> EntryPage
setInfo entryPage newInfo =
    { entryPage | infoData = newInfo }

setCytoscapeItems: EntryPage -> List (CytoscapeItem) -> EntryPage 
setCytoscapeItems entryPage newCytoscapeItems =
   {entryPage | cytoscapeItems= newCytoscapeItems}

setProteoforms : ProteoformsData -> List (Proteoform Enzyme Source) -> ProteoformsData
setProteoforms proteoformsData newProteoforms =
    { proteoformsData | data = newProteoforms, status = Success }

setProteoformsFilterTerm : ProteoformsData -> String -> ProteoformsData
setProteoformsFilterTerm proteoformsData newFilterTerm =
    { proteoformsData | filterTerm = newFilterTerm, status = Success }

setPTMDependentPPIFilterTerm : PTMDependentPPIData -> String -> PTMDependentPPIData
setPTMDependentPPIFilterTerm ptmDependentPPIData newFilterTerm =
    { ptmDependentPPIData | filterTerm = newFilterTerm, status = Success }

setProteoformPPIFilterTerm : ProteoformPPIData -> String -> ProteoformPPIData
setProteoformPPIFilterTerm proteoformPPIData newFilterTerm =
    { proteoformPPIData | filterTerm = newFilterTerm, status = Success }

setProteoformsData: EntryPage -> ProteoformsData -> EntryPage
setProteoformsData entryPage newProteoformsData = 
    { entryPage | proteoformsData = newProteoformsData}

setPTMDependentPPIData: EntryPage -> PTMDependentPPIData -> EntryPage
setPTMDependentPPIData entryPage newData = 
    { entryPage | ptmDependentPPIData = newData}

setProteoformPPIData: EntryPage -> ProteoformPPIData -> EntryPage
setProteoformPPIData entryPage newData = 
    { entryPage | proteoformPPIData = newData}

setShowInfoErrorMsg: Bool -> EntryPage -> EntryPage
setShowInfoErrorMsg newValue entryPage = 
    { entryPage | showInfoErrorMsg = newValue}

setShowSubstrateErrorMsg: Bool -> EntryPage -> EntryPage
setShowSubstrateErrorMsg newValue entryPage = 
    { entryPage | showSubstrateErrorMsg = newValue}

setShowProteoformsErrorMsg: Bool -> EntryPage -> EntryPage
setShowProteoformsErrorMsg newValue entryPage = 
    { entryPage | showProteoformsErrorMsg = newValue}

setShowPTMDepPPIErrorMsg: Bool -> EntryPage -> EntryPage
setShowPTMDepPPIErrorMsg newValue entryPage = 
    { entryPage | showPTMDepPPIErrorMsg = newValue}

setShowProteoformsPPIErrorMsg: Bool -> EntryPage -> EntryPage
setShowProteoformsPPIErrorMsg newValue entryPage = 
    { entryPage | showProteoformsPPIErrorMsg = newValue}

setSubstrateData: EntryPage -> SubstrateData -> EntryPage
setSubstrateData entryPage newData = 
    { entryPage | substrateData = newData }

setSelectedSubstrateTab: String -> TabData -> TabData
setSelectedSubstrateTab newSelectedTab tabData =
    { tabData | selectedTab = newSelectedTab}

setSubstrateTabData: SubstrateData -> TabData -> SubstrateData
setSubstrateTabData substrateData newTabData =
    { substrateData | tabData = newTabData}

setSubstrateFilterTerm : SubstrateData -> String -> SubstrateData
setSubstrateFilterTerm substrateData newFilterTerm =
    { substrateData | filterTerm = newFilterTerm, status = Success }


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
        |> optional "taxon_code" string ""
        |> optional "species" string ""
        |> optional "common_name" string ""

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
       source: sourceDecoder,
       pmids: List String 
    }

proteoformDecoder: Decoder (Proteoform Enzyme Source)
proteoformDecoder =
    decode Proteoform
        |> required "pro_id" string
        |> required "label" string
        |> required "sites" (list string)
        |> required "ptm_enzyme" enzymeDecoder
        |> required "source" sourceDecoder
        |> required "pmids" (list string)

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
     batchPTMPPIData : BatchPTMPPIData,
     selectedTab : String,
     inputText : String 
 }

type alias BatchEnzymeData = 
    {
        status: RequestState,
        error: String,
        data: {
            list_found : {
                count: Int,
                with_enzyme : List BatchEnzyme,
                without_enzyme: List BatchEnzyme
            },
            list_not_found : List Kinase  
        }    
    }

type alias BatchPTMPPIData = 
    {
        status: RequestState,
        error: String,
        data: {
            ptm_ppi : List BatchPTMPPI,
            sites_without_interactants: List Kinase,
            not_found: List Kinase
        }    
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

setKinases: (List Kinase) -> BatchPage -> BatchPage
setKinases newKinases batchPage =
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

setBatchInputText: String -> BatchPage -> BatchPage
setBatchInputText newText batchPage = 
    { batchPage | inputText = newText }

setSelectedBatchTab: BatchPage -> String -> BatchPage
setSelectedBatchTab batchPage newTab =
    {batchPage | selectedTab = newTab }   

-- Batch Result Enzymes
type alias BatchEnzyme = 
    {
        ptm_type : String,
        substrate : Entity,
        site: String,
        site_position: Int,
        enzyme: Entity,
        score: Int,
        source: (List Source),
        pmids: (List String)
    }

batchEnzymeDecoder: Decoder BatchEnzyme
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

batchEnzymeListDecoder: Decoder (List BatchEnzyme)
batchEnzymeListDecoder = 
    list batchEnzymeDecoder


-- Batch Result PTMPPI
type alias BatchPTMPPI = 
    {
        ptm_type: String,
        substrate: Entity,
        site: String,
        site_position: Int,
        interactant: Entity,
        association_type: String,
        source: Source,
        pmid: List String
    }

batchPTMPPIDecoder: Decoder BatchPTMPPI
batchPTMPPIDecoder =
    decode BatchPTMPPI
    |> required "ptm_type" string
    |> required "substrate" entityDecoder
    |> required "site" string
    |> required "site_position" int
    |> required "interactant" entityDecoder
    |> required "association_type" string
    |> required "source" sourceDecoder
    |> required "pmids" (list string)

batchPTMPPIListDecoder: Decoder (List BatchPTMPPI)
batchPTMPPIListDecoder = 
    list batchPTMPPIDecoder

isVisible : Bool -> List Css.Style
isVisible is_visible =
    case is_visible of
    True -> [
              Css.property "visibility" "visible"   
            ]
    False -> [
              Css.property "visibility" "visible",   
              Css.property "display" "none"  
            ]


type alias CytoscapeItem = 
    {
        id_1: String,
        id_2: String,
        item_type: String   
    }