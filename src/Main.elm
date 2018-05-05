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
import Views.Info
import Views.Proteoforms
import Views.PTMDependentPPI
import Views.ProteoformPPI
import Views.Substrate

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
        Msgs.OnFetchInfo response ->
            let
                newModel = Views.Info.decodeResponse response
                        |> Model.setInfo model.entryPage
                        |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.OnFetchProteoform response -> 
            let
                newModel = Views.Proteoforms.decodeResponse response
                |> Model.setProteoformsData model.entryPage
                |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.OnFetchPTMDependentPPI response -> 
            let
                newModel = Views.PTMDependentPPI.decodeResponse response
                |> Model.setPTMDependentPPIData model.entryPage
                |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.OnFetchProteoformPPI response -> 
            let
                newModel = Views.ProteoformPPI.decodeResponse response
                |> Model.setProteoformPPIData model.entryPage
                |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.OnFetchSubstrates response -> 
            let
                newModel = Views.Substrate.decodeResponse response
                |> Model.setSubstrateData model.entryPage
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