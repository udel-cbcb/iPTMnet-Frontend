module Model.Proteoform exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model.Source exposing (..)
import Model.Enzyme exposing (..)
import Model.Misc exposing (..)

type alias Proteoform = 
    {
       pro_id: String,
       label : String,
       sites : List String,
       ptm_enzyme: Enzyme,
       source: Source,
       pmids: List String 
    }

proteoformDecoder: Decoder Proteoform
proteoformDecoder =
    decode Proteoform
        |> required "pro_id" string
        |> required "label" string
        |> required "sites" (list string)
        |> required "ptm_enzyme" enzymeDecoder
        |> required "source" sourceDecoder
        |> required "pmids" (list string)

proteoformListDecoder: Decoder (List Proteoform)
proteoformListDecoder = 
    list proteoformDecoder


type alias ProteoformsData = 
    {
        status: RequestState,
        error: String,
        data: List Proteoform,
        filterTerm: String
    }

setProteoforms : ProteoformsData -> List Proteoform -> ProteoformsData
setProteoforms proteoformsData newProteoforms =
    { proteoformsData | data = newProteoforms, status = Success }

setProteoformsFilterTerm : ProteoformsData -> String -> ProteoformsData
setProteoformsFilterTerm proteoformsData newFilterTerm =
    { proteoformsData | filterTerm = newFilterTerm, status = Success }

initialData : ProteoformsData
initialData = 
    {
        status = NotAsked,
        error = "",
        data = [],
        filterTerm = ""
    }

