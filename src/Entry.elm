module Entry exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)

view : Model -> Html Msg
view model =  div [] []


info: WebData (Info) -> Html Msg
info response = 
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success info ->
            text info.uniprot_ac

        RemoteData.Failure error ->
            text (toString error)