module Model.Kinase exposing (..)
import Csv exposing (..)
import Array exposing (..)
import Json.Encode exposing (..)

type alias Kinase =
 {
     substrate_ac: String,
     site_residue: String,
     site_position: String
 }

toKinaseList : String -> List Kinase
toKinaseList csv_string =
    Csv.splitWith "\t" csv_string
    |> List.map toKinase

toKinase : (List String) -> Kinase
toKinase values =
    let
        values_arr = Array.fromList values
        
        -- substrate ac
        sub_ac = case Array.get 0 values_arr of
            Just value ->
                value
            Nothing ->
                ""

        -- site residue
        residue = case Array.get 1 values_arr of
            Just value ->
                value
            Nothing ->
                ""
        
        -- site position
        position = case Array.get 2 values_arr of
            Just value ->
                value
            Nothing ->
                ""

    in 
        {
            substrate_ac = sub_ac,
            site_residue = residue,
            site_position = position
        }

kinaseToJson : Kinase -> Json.Encode.Value
kinaseToJson kinase = 
    Json.Encode.object [
        ("substrate_ac",Json.Encode.string kinase.substrate_ac),
        ("site_residue",Json.Encode.string kinase.site_residue),
        ("site_position",Json.Encode.string kinase.site_position)
    ]