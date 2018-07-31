module Model.Protein exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

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