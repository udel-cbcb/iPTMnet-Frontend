module Model.Enzyme exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

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