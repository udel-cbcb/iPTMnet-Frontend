module Main exposing (..)
import Html exposing (..)
import Html.Styled exposing (toUnstyled)
import Home
import Entry
import Model exposing (..)
import Msgs exposing (Msg)
import Commands exposing (..)
import Navigation
import Routing

init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    Commands.handleRoute (Model.initialModel Routing.HomeRoute) location


-- VIEW
view : Model -> Html Msg
view model = 
    case model.route of
        Routing.HomeRoute -> 
            Home.view model
            |> toUnstyled
        Routing.EntryRoute id ->
            Entry.view model
            |> toUnstyled
        Routing.NotFoundRoute ->
            div [] []

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.NoOp ->
            ( model, Cmd.none )
        Msgs.OnFetchInfo newInfo ->
            let
                newModel = 
                    newInfo
                        |> Model.setInfo model.entryPage
                        |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.OnFetchProteoform newProteoforms -> 
            let
                newModel = 
                    newProteoforms
                        |> Model.setProteoforms model.entryPage
                        |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.ChangeLocation path -> 
            ( model, Navigation.newUrl path)
        Msgs.OnLocationChange location ->
            Commands.handleRoute model location
        


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MAIN
main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }