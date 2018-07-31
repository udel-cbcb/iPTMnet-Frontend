module Model.Alignment exposing (..)

import Model.Source exposing (..)
import Array exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

type alias Alignment = 
    {
        id: String,
        sequence: Array AlignmentItem
    }

type alias AlignmentItem = 
    {
        site: String,
        position: Int,
        decorations: List Decoration
    }

type alias Decoration = 
    {
        ptm_type: String,
        source: List Source,
        pmids: List String,
        is_conserved: Bool
    }

alignmentArrayDecoder: Decoder (Array Alignment)
alignmentArrayDecoder = 
    array alignmentDecoder

alignmentDecoder: Decoder Alignment
alignmentDecoder =
    decode Alignment
    |> required "id" string
    |> required "sequence" (array alignmentItemDecoder)

alignmentItemDecoder: Decoder AlignmentItem
alignmentItemDecoder = 
    decode AlignmentItem
    |> required "site" string
    |> required "position" int
    |> required "decorations" (list decorationDecoder)

decorationDecoder: Decoder Decoration
decorationDecoder =
    decode Decoration
    |> required "ptm_type" string
    |> required "source" (list sourceDecoder)
    |> required "pmids" (list string)
    |> required "is_conserved" bool