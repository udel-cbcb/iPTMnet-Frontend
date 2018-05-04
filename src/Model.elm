module Model exposing (..)
import RemoteData exposing (WebData)
import Routing
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

type RequestState = 
    NotAsked
    | Loading
    | Error
    | Success


type alias Model =
    {
        route: Routing.Route,
        entryPage: EntryPage        
    }

type alias EntryPage = 
    {
        info: WebData (Info),
        proteoformsData: ProteoformsData
    }

type alias ProteoformsData = 
    {
        status: RequestState,
        error: String,
        data: List (Proteoform Entity Source)
    }

setEntryPage : Model -> EntryPage -> Model
setEntryPage model newEntryPage = 
    { model | entryPage = newEntryPage}

setInfo : EntryPage -> WebData(Info) -> EntryPage
setInfo entryPage newInfo =
    { entryPage | info = newInfo }

setProteoforms : ProteoformsData -> List (Proteoform Entity Source) -> ProteoformsData
setProteoforms proteoformsData newProteoforms =
    { proteoformsData | data = newProteoforms, status = Success }

setProteoformsData: EntryPage -> ProteoformsData -> EntryPage
setProteoformsData entryPage newProteoformsData = 
    { entryPage | proteoformsData = newProteoformsData}

initialModel : Routing.Route -> Model
initialModel route = 
    { 
        route = route,
        entryPage = {
            info = RemoteData.Loading,
            proteoformsData = {
                status = NotAsked,
                error = "",
                data = []
            }
        }
    }

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

type alias Entity = 
    {
        pro_id: String,
        label: String   
    }

entityDecoder: Decoder Entity
entityDecoder = 
    decode Entity
        |> optional "pro_id" string ""
        |> optional "label" string ""


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


type alias Proteoform entityDecoder sourceDecoder = 
    {
       pro_id: String,
       label : String,
       sites : List String,
       ptm_enzyme: entityDecoder,
       source: sourceDecoder 
    }

proteoformDecoder: Decoder (Proteoform Entity Source)
proteoformDecoder =
    decode Proteoform
        |> required "pro_id" string
        |> required "label" string
        |> required "sites" (list string)
        |> required "ptm_enzyme" entityDecoder
        |> required "source" sourceDecoder

proteoformListDecoder: Decoder (List (Proteoform Entity Source ))
proteoformListDecoder = 
    list proteoformDecoder

