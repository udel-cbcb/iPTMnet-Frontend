module Model.SearchResult exposing (..)
import Model.Organism exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

type alias SearchData = 
    {
        status: Int,
        error: String,
        count: Int,
        data: List SearchResult    
    }

type alias SearchResult = 
    {
        iptm_id:String,
        uniprot_ac: String,
        protein_name: String,
        gene_name: String,
        synonyms: (List String),
        organism: Organism,
        substrate_role: Bool,
        substrate_num: Int,
        enzyme_role: Bool,
        enzyme_num: Int,
        ptm_dependent_ppi_role: Bool,
        ptm_dependent_ppi_num: Int,
        sites: Int,
        isoforms: Int   
    }

searchResultDecoder: Decoder SearchResult
searchResultDecoder =
    decode SearchResult
        |> required "iptm_id" string
        |> required "uniprot_ac" string
        |> required "protein_name" string
        |> optional "gene_name" string ""
        |> required "synonyms" (list string)
        |> required "organism" organismDecoder
        |> required "substrate_role" bool
        |> required "substrate_num" int
        |> required "enzyme_role" bool
        |> required "enzyme_num" int
        |> required "ptm_dependent_ppi_role" bool
        |> required "ptm_dependent_ppi_num" int
        |> required "sites" int
        |> required "isoforms" int

searchResultListDecoder: Decoder (List SearchResult)
searchResultListDecoder =
    list searchResultDecoder

rawSearchResultDecoder: Decoder SearchData
rawSearchResultDecoder =
    decode SearchData
        |> required "status" int
        |> required "error" string
        |> required "count" int
        |> required "data" searchResultListDecoder