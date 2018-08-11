module Model.Misc exposing (..)
import Css exposing (..)

type RequestState = 
    NotAsked
    | Loading
    | Error
    | Success

url : String
url = 
    --"https://research.bioinformatics.udel.edu/iptmnet/api"
    "http://localhost:8088"

pathname : String
pathname =
    let
        definedPath = "#CUSTOM_PATH#"
    in
        if (String.contains "CUSTOM_PATH" definedPath) then
            "/"
        else 
            definedPath


isVisible : Bool -> List Css.Style
isVisible is_visible =
    case is_visible of
    True -> [
              Css.property "visibility" "visible"   
            ]
    False -> [
              Css.property "visibility" "visible",   
              Css.property "display" "none"  
            ]