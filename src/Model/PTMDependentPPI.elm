module Model.PTMDependentPPI exposing (..)

import Model.Entity exposing (..)
import Model.Source exposing (..)
import Model.Misc exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


type alias PTMDependentPPI = 
    {
        ptm_type: String,
        substrate: Entity,
        site: String,
        interactant: Entity,
        association_type: String,
        source: Source,
        pmid: String
    }

ptmDependentPPIDecoder: Decoder PTMDependentPPI
ptmDependentPPIDecoder = 
    decode PTMDependentPPI
        |> required "ptm_type" string
        |> required "substrate" entityDecoder
        |> required "site" string
        |> required "interactant" entityDecoder
        |> required "association_type" string
        |> required "source" sourceDecoder
        |> required "pmid" string

ptmDependentPPIListDecoder: Decoder (List PTMDependentPPI)
ptmDependentPPIListDecoder = 
    list ptmDependentPPIDecoder

type alias PTMDependentPPIData = 
    {
        status: RequestState,
        error: String,
        data: List PTMDependentPPI,
        filterTerm : String
    }

setPTMDependentPPIFilterTerm : PTMDependentPPIData -> String -> PTMDependentPPIData
setPTMDependentPPIFilterTerm ptmDependentPPIData newFilterTerm =
    { ptmDependentPPIData | filterTerm = newFilterTerm, status = Success }

initialData: PTMDependentPPIData
initialData = 
    {
        status = NotAsked,
        error = "",
        data = [],
        filterTerm = ""
    }