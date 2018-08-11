module Model.Entity exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

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