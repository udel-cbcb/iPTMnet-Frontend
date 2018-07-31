module Model.Organism exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


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