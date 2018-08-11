module Model.Source exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

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