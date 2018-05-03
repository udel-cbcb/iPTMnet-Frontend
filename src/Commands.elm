module Commands exposing (..)

import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
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

infoDecoder: Decoder Info
infoDecoder =
    decode Info
        |> required "uniprot_ac" string
        |> required "uniprot_id" string
        |> required "gene_name" string
        |> required "protein_name" string
        |> required "synonyms" (list string)


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