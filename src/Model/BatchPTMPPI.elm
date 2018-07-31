module Model.BatchPTMPPI exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model.Entity exposing (..)
import Model.Source exposing (..)
import Model.Misc exposing (..)
import Model.Kinase exposing (..)

-- Batch Result PTMPPI
type alias BatchPTMPPI = 
    {
        ptm_type: String,
        substrate: Entity,
        site: String,
        site_position: Int,
        interactant: Entity,
        association_type: String,
        source: Source,
        pmid: List String
    }

batchPTMPPIDecoder: Decoder BatchPTMPPI
batchPTMPPIDecoder =
    decode BatchPTMPPI
    |> required "ptm_type" string
    |> required "substrate" entityDecoder
    |> required "site" string
    |> required "site_position" int
    |> required "interactant" entityDecoder
    |> required "association_type" string
    |> required "source" sourceDecoder
    |> required "pmids" (list string)

batchPTMPPIListDecoder: Decoder (List BatchPTMPPI)
batchPTMPPIListDecoder = 
    list batchPTMPPIDecoder

type alias BatchPTMPPIData = 
    {
        status: RequestState,
        error: String,
        data: {
            ptm_ppi : List BatchPTMPPI,
            sites_without_interactants: List Kinase,
            not_found: List Kinase
        }    
    }

