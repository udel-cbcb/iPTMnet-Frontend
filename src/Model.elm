module Model exposing (..)
import RemoteData exposing (WebData)
import Routing

type alias Model =
    {
        route: Routing.Route,
        info: WebData (Info)        
    }

initialModel : Routing.Route -> Model
initialModel route = 
    { 
        route = route,
        info = RemoteData.Loading
    }

type alias Info = 
    {
       uniprot_ac : String     
    }