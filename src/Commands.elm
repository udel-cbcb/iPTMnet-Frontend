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
import Json.Encode

fetchInfo: String -> Cmd Msg
fetchInfo id = 
    Http.get (interpolate (Model.url ++ "/{0}/info") [id]) Model.infoDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchInfo

fetchProteoforms: String -> Cmd Msg
fetchProteoforms id = 
    Http.get (interpolate (Model.url ++ "/{0}/proteoforms") [id]) Model.proteoformListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchProteoform

fetchPTMDependentPPI: String -> Cmd Msg
fetchPTMDependentPPI id = 
    Http.get (interpolate (Model.url ++ "/{0}/ptmppi") [id]) Model.ptmDependentPPIListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchPTMDependentPPI

fetchProteoformsPPI: String -> Cmd Msg
fetchProteoformsPPI id = 
    Http.get (interpolate (Model.url ++ "/{0}/proteoformsppi") [id]) Model.proteoformPPIListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchProteoformPPI


fetchSubstrates: String -> Cmd Msg
fetchSubstrates id = 
    Http.get (interpolate (Model.url ++ "/{0}/substrate") [id]) Model.substrateTableDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchSubstrates

fetchSearchResults: String -> Cmd Msg
fetchSearchResults query_params = 
    Http.get (interpolate (Model.url ++ "/search?{0}") [query_params]) Model.searchResultListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchSearchResults

getFileContents : NativeFile -> Cmd Msg
getFileContents nf =
    FileReader.readAsTextFile nf.blob
    |> Task.attempt Msgs.OnFileContent

fetchBatchData : Model.Output -> (List Model.Kinase) -> Cmd Msg 
fetchBatchData output kinases =
    case output of 
    Model.Enzymes ->
        fetchBatchEnzymes kinases
    Model.PTMPPI ->
        fetchBatchPTMPPI kinases

fetchBatchEnzymes : (List Model.Kinase) -> Cmd Msg
fetchBatchEnzymes kinases =
    let 
        json_body = Json.Encode.list (List.map Model.kinaseToJson kinases)
    in
        Http.post "http://aws3.proteininformationresource.org/batch_ptm_enzymes" (Http.jsonBody json_body) Model.batchEnzymeListDecoder 
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchBatchEnzymes

fetchBatchPTMPPI : (List Model.Kinase) -> Cmd Msg
fetchBatchPTMPPI kinases =
    let 
        json_body = Json.Encode.list (List.map Model.kinaseToJson kinases)
    in
        Http.post "http://aws3.proteininformationresource.org/batch_ptm_ppi" (Http.jsonBody json_body) Model.batchPTMPPIListDecoder 
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchBatchPTMPPI 


handleRoute : Model.Model -> Navigation.Location -> (Model.Model, Cmd Msg)
handleRoute model location =
        -- parse to location to get the route and update the model       
        let
            currentRoute =
                Routing.parseLocation location
        in
        case currentRoute of 
            Routing.HomeRoute -> 
                let
                              -- hide the search bar in navigation
                    newModel = Model.setNavBarSearchVisibility model.navbar False
                              |> Model.setNavbar model
                              -- set the proper route
                              |> Model.setRoute currentRoute
                in
                    (newModel, Cmd.none )
            Routing.CitationRoute -> 
                let
                              -- hide the search bar in navigation
                    newModel = Model.setNavBarSearchVisibility model.navbar False
                              |> Model.setNavbar model
                              -- set the proper route
                              |> Model.setRoute currentRoute
                in
                    (newModel, Cmd.none )
            Routing.LicenseRoute -> 
                let
                              -- hide the search bar in navigation
                    newModel = Model.setNavBarSearchVisibility model.navbar False
                              |> Model.setNavbar model
                              -- set the proper route
                              |> Model.setRoute currentRoute
                in
                    (newModel, Cmd.none )
            Routing.EntryRoute id ->
                (Model.setRoute currentRoute model, Cmd.batch [fetchInfo id,
                                                             fetchProteoforms id,
                                                             fetchPTMDependentPPI id,
                                                             fetchProteoformsPPI id,
                                                             fetchSubstrates id
                                                             ])
            Routing.SearchRoute queryString -> 
                (Model.setRoute currentRoute model, fetchSearchResults queryString )
            Routing.BatchRoute ->
                (Model.setRoute currentRoute model, Cmd.none )
            Routing.BatchResultRoute ->
                (Model.setRoute currentRoute model, (fetchBatchData model.batchPage.outputType model.batchPage.kinases) )
            Routing.NotFoundRoute ->
                (Model.setRoute currentRoute model, Cmd.none )