module Commands exposing (..)

import Http
import Msgs exposing (Msg)
import Model exposing (Info)
import RemoteData
import Routing
import Model
import Navigation
import String.Interpolate exposing(interpolate)
import FileReader exposing (NativeFile)
import Task


fetchInfo: String -> Cmd Msg
fetchInfo id = 
    Http.get (interpolate "http://aws3.proteininformationresource.org/{0}/info" [id]) Model.infoDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchInfo

fetchProteoforms: String -> Cmd Msg
fetchProteoforms id = 
    Http.get (interpolate "http://aws3.proteininformationresource.org/{0}/proteoforms" [id]) Model.proteoformListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchProteoform

fetchPTMDependentPPI: String -> Cmd Msg
fetchPTMDependentPPI id = 
    Http.get (interpolate "http://aws3.proteininformationresource.org/{0}/ptmppi" [id]) Model.ptmDependentPPIListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchPTMDependentPPI

fetchProteoformsPPI: String -> Cmd Msg
fetchProteoformsPPI id = 
    Http.get (interpolate "http://aws3.proteininformationresource.org/{0}/proteoformsppi" [id]) Model.proteoformPPIListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchProteoformPPI


fetchSubstrates: String -> Cmd Msg
fetchSubstrates id = 
    Http.get (interpolate "http://aws3.proteininformationresource.org/{0}/substrate" [id]) Model.substrateTableDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchSubstrates

fetchSearchResults: String -> Cmd Msg
fetchSearchResults query_params = 
    Http.get (interpolate "http://aws3.proteininformationresource.org/search?{0}" [query_params]) Model.searchResultListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchSearchResults

getFileContents : NativeFile -> Cmd Msg
getFileContents nf =
    FileReader.readAsTextFile nf.blob
    |> Task.attempt Msgs.OnFileContent


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
                (Model.initialModel currentRoute, Cmd.batch [fetchInfo id,
                                                             fetchProteoforms id,
                                                             fetchPTMDependentPPI id,
                                                             fetchProteoformsPPI id,
                                                             fetchSubstrates id
                                                             ])
            Routing.SearchRoute queryString -> 
                (Model.initialModel currentRoute, fetchSearchResults queryString )
            Routing.BatchRoute ->
                (Model.initialModel currentRoute, Cmd.none )
            Routing.NotFoundRoute ->
                (Model.initialModel currentRoute, Cmd.none )