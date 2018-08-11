module Model.SubstrateEnzyme exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

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