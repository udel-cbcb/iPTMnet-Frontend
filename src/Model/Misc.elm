module Model.Misc exposing (..)
import Css exposing (..)

type RequestState = 
    NotAsked
    | Loading
    | Error
    | Success

url : String
url = 
    "https://research.bioinformatics.udel.edu/iptmnet/api"
    -- "http://localhost:8088"

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