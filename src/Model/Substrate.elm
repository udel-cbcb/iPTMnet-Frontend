module Model.Substrate exposing (..)

import Model.Source exposing (..)
import Model.SubstrateEnzyme exposing (..)
import Model.Misc exposing (..)
import Model.Tab exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Dict exposing (..)

type alias Substrate  = 
    {
        residue: String,
        site: String,
        ptm_type: String,
        score: Int,
        sources: (List Source),
        enzymes: (List SubstrateEnzyme),
        pmids: (List String)
    }

substrateDecoder: Decoder Substrate
substrateDecoder = 
    decode Substrate
        |> optional "residue" string ""
        |> optional "site" string ""
        |> optional "ptm_type" string ""
        |> required "score" int
        |> required "sources" (list sourceDecoder)
        |> required "enzymes" (list substrateEnzymeDecoder)
        |> required "pmids" (list string)

substrateListDecoder: Decoder (List Substrate)
substrateListDecoder = 
    list substrateDecoder

substrateTableDecoder: Decoder (Dict String (List Substrate))
substrateTableDecoder =
    dict substrateListDecoder

type alias SubstrateData = 
    {
        status: RequestState,
        error: String,
        data: Dict String (List Substrate ),
        tabData: TabData,
        filterTerm: String
    }

setSubstrateFilterTerm : SubstrateData -> String -> SubstrateData
setSubstrateFilterTerm substrateData newFilterTerm =
    { substrateData | filterTerm = newFilterTerm, status = Success }

setSubstrateTabData: SubstrateData -> TabData -> SubstrateData
setSubstrateTabData substrateData newTabData =
    { substrateData | tabData = newTabData}

initialData: SubstrateData
initialData = 
    {
        status = NotAsked,
        error = "",
        data = Dict.empty,
        tabData = {
            tabs = [],
            selectedTab = ""
        },
        filterTerm = ""
    }