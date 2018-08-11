module Model.ProteoformPPI exposing (..)

import Model.Protein exposing (..)
import Model.Source exposing (..)
import Model.Misc exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

type alias ProteoformPPI =
    {
        protein_1: Protein,
        relation: String,
        protein_2: Protein,
        source: Source,
        pmids: List String
    }

proteoformPPIDecoder: Decoder ProteoformPPI
proteoformPPIDecoder =
    decode ProteoformPPI
    |> required "protein_1" proteinDecoder
    |> required "relation" string
    |> required "protein_2" proteinDecoder
    |> required "source" sourceDecoder
    |> required "pmids" (list string)

proteoformPPIListDecoder: Decoder (List ProteoformPPI)
proteoformPPIListDecoder = 
    list proteoformPPIDecoder

type alias ProteoformPPIData = 
    {
        status: RequestState,
        error: String,
        data: List ProteoformPPI,
        filterTerm: String
    }

setProteoformPPIFilterTerm : ProteoformPPIData -> String -> ProteoformPPIData
setProteoformPPIFilterTerm proteoformPPIData newFilterTerm =
    { proteoformPPIData | filterTerm = newFilterTerm, status = Success }

initialData : ProteoformPPIData
initialData = 
    {
        status = NotAsked,
        error = "",
        data = [],
        filterTerm = ""
    }