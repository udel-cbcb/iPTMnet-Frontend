module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Model exposing (Info)
import RemoteData
import Routing
import Model
import Navigation
import String.Interpolate exposing(interpolate)
fetchInfo: String -> Cmd Msg
fetchInfo id = 
    Http.get (fetchInfoUrl id) infoDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchInfo

fetchInfoUrl : String -> String
fetchInfoUrl id =
    interpolate "http://aws3.proteininformationresource.org/{0}/info" [id]

infoDecoder: Decode.Decoder Info
infoDecoder =
    decode Info
        |> required "uniprot_ac" Decode.string


handleRoute : Model.Model -> Navigation.Location -> (Model.Model, Cmd Msg)
handleRoute model location =
        -- parse to location to get the route and update the model       
        let
            currentRoute =
                Routing.parseLocation location
        in
        case currentRoute of 
            Routing.HomeRoute -> 
                (Model.initialModel currentRoute, Cmd.none )
            Routing.EntryRoute id ->
                (Model.initialModel currentRoute, fetchInfo id)
            Routing.NotFoundRoute ->
                (Model.initialModel currentRoute, Cmd.none )