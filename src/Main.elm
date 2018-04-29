module Main exposing (..)
import Html.Styled exposing (..)
-- import Home
import Entry
import Model exposing (..)
import Msgs exposing (Msg)
import Commands exposing (..)

init : ( Model, Cmd Msg )
init =
    ( Model.initialModel, fetchInfo)

-- VIEW
view : Model -> Html Msg
view model = Entry.view model   


-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.NoOp ->
            ( model, Cmd.none )
        Msgs.OnFetchInfo response -> 
            ( { model | info = response}, Cmd.none)
        


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }