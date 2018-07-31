module Model.Info exposing (..)
import Model.Misc exposing (..)
import Model.Organism exposing (..)
import Model.Pro exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

type alias Info = 
    {
       uniprot_ac : String,
       uniprot_id : String,
       gene_name : String,
       protein_name: String,
       synonymns: List String,
       organism: Organism,
       pro: Maybe PRO     
    }

infoDecoder: Decoder Info
infoDecoder =
    decode Info
        |> required "uniprot_ac" string
        |> required "uniprot_id" string
        |> required "gene_name" string
        |> required "protein_name" string
        |> required "synonyms" (list string)
        |> required "organism" organismDecoder
        |> optional "pro" (maybe proDecoder) Nothing

type alias InfoData = 
    {
        status: RequestState,
        error: String,
        data: Info    
    }

initialModel: Info
initialModel = 
    {
        uniprot_ac = "",
        uniprot_id = "",
        gene_name = "",
        protein_name = "",
        synonymns = [],
        organism = {
            taxon_code = "",
            species = "",
            common_name = ""
        },
        pro = Just {
            id = "",
            name = "",
            definition = "",
            short_label = "",
            category = ""
        }  
    }

initialData: InfoData
initialData = 
    {
        status = NotAsked,
        error = "",
        data = initialModel
    }