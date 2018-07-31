module Model.BatchEnzyme exposing (..)
import Model.Source exposing (..)
import Model.Entity exposing (..)
import Model.Kinase exposing (..)
import Model.Misc exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


-- Batch Result Enzymes
type alias BatchEnzyme = 
    {
        ptm_type : String,
        substrate : Entity,
        site: String,
        site_position: Int,
        enzyme: Entity,
        score: Int,
        source: (List Source),
        pmids: (List String)
    }

batchEnzymeDecoder: Decoder BatchEnzyme
batchEnzymeDecoder =
    decode BatchEnzyme 
    |> required "ptm_type" string
    |> required "substrate" entityDecoder
    |> required "site" string
    |> required "site_position" int
    |> required "enzyme" entityDecoder
    |> required "score" int
    |> required "source" (list sourceDecoder)
    |> required "pmids" (list string)

batchEnzymeListDecoder: Decoder (List BatchEnzyme)
batchEnzymeListDecoder = 
    list batchEnzymeDecoder

type alias BatchEnzymeData = 
    {
        status: RequestState,
        error: String,
        data: {
            list_found : {
                count: Int,
                with_enzyme : List BatchEnzyme,
                without_enzyme: List BatchEnzyme
            },
            list_not_found : List Kinase  
        }    
    }