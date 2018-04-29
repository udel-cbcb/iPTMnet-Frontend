module Model exposing (..)
import RemoteData exposing (WebData)

type alias Model =
    {
        info: WebData (Info)        
    }

initialModel : Model
initialModel = 
    { 
        info = RemoteData.Loading
    }

type alias Info = 
    {
       uniprot_ac : String     
    }