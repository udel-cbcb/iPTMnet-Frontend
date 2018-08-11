module Model.Pro exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

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