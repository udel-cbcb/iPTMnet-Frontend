module Commands exposing (..)

import Http
import Msgs exposing (Msg)
import RemoteData
import Routing
import Navigation
import String.Interpolate exposing(interpolate)
import FileReader exposing (NativeFile)
import Task
import Json.Encode
import Model.Misc as Misc exposing (..)
import Model.Info as Info
import Model.Proteoform as Proteoform
import Model.PTMDependentPPI as PTMDependentPPI
import Model.ProteoformPPI as ProteoformPPI
import Model.Substrate as Substrate
import Model.Alignment
import Model.BatchPage
import Model.Kinase exposing (..)
import Model.BatchPage exposing (..)
import Model.BatchEnzyme exposing (..)
import Model.BatchPTMPPI exposing (..)
import Model.Statistics exposing (..)
import Model.AppModel as AppModel exposing (..)
import Model.Navbar as Navbar
import Ports
import Misc as ViewMisc
import Model.SearchPage as SearchPage exposing (..)
import Model.BrowsePage as BrowsePage exposing (..)

fetchInfo: String -> Cmd Msg
fetchInfo id = 
    Http.get (interpolate (Misc.url ++ "/{0}/info") [id]) Info.infoDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchInfo

fetchProteoforms: String -> Cmd Msg
fetchProteoforms id = 
    Http.get (interpolate (Misc.url ++ "/{0}/proteoforms") [id]) Proteoform.proteoformListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchProteoform

fetchPTMDependentPPI: String -> Cmd Msg
fetchPTMDependentPPI id = 
    Http.get (interpolate (Misc.url ++ "/{0}/ptmppi") [id]) PTMDependentPPI.ptmDependentPPIListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchPTMDependentPPI

fetchProteoformsPPI: String -> Cmd Msg
fetchProteoformsPPI id = 
    Http.get (interpolate (Misc.url ++ "/{0}/proteoformsppi") [id]) ProteoformPPI.proteoformPPIListDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchProteoformPPI


fetchSubstrates: String -> Cmd Msg
fetchSubstrates id = 
    Http.get (interpolate (Misc.url ++ "/{0}/substrate") [id]) Substrate.substrateTableDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchSubstrates

fetchSearchResults: String -> Int -> Int -> Cmd Msg
fetchSearchResults query_params start_index end_index= 
    let
        url = (interpolate (Misc.url ++ "/search?{0}&paginate=true&start_index={1}&end_index={2}") [query_params,toString start_index,toString end_index])
    in
        Ports.performSearch url

fetchBrowseResults: String -> Int -> Int -> Cmd Msg
fetchBrowseResults query_params start_index end_index= 
    let
        url = (interpolate (Misc.url ++ "/browse?{0}&start_index={1}&end_index={2}") [query_params,toString start_index,toString end_index])
    in
        Ports.performBrowse url     

fetchMSA: String -> Cmd Msg 
fetchMSA id =
    Http.get (interpolate (Misc.url ++ "/{0}/msa") [id]) Model.Alignment.alignmentArrayDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchAlignment


getFileContents : NativeFile -> Cmd Msg
getFileContents nf =
    FileReader.readAsTextFile nf.blob
    |> Task.attempt Msgs.OnFileContent

fetchBatchData : Model.BatchPage.Output -> (List Kinase) -> Cmd Msg 
fetchBatchData output kinases =
    case output of 
    Enzymes ->
        fetchBatchEnzymes kinases
    PTMPPI ->
        fetchBatchPTMPPI kinases

fetchBatchEnzymes : (List Kinase) -> Cmd Msg
fetchBatchEnzymes kinases =
    let 
        json_body = Json.Encode.list (List.map kinaseToJson kinases)
    in
        Http.post (Misc.url ++ "/batch_ptm_enzymes") (Http.jsonBody json_body) batchEnzymeListDecoder 
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchBatchEnzymes

fetchBatchPTMPPI : (List Kinase) -> Cmd Msg
fetchBatchPTMPPI kinases =
    let 
        json_body = Json.Encode.list (List.map kinaseToJson kinases)
    in
        Http.post (Misc.url ++ "/batch_ptm_ppi") (Http.jsonBody json_body) batchPTMPPIListDecoder 
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchBatchPTMPPI

fetchStatistics : Cmd Msg
fetchStatistics =
     Http.get (Misc.url ++ "/statistics") statisticsDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchStatistics


handleRoute : Model -> Navigation.Location -> (Model, Cmd Msg)
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
                    newModel = Navbar.setNavBarSearchVisibility model.navbar False
                              |> AppModel.setNavbar model
                              -- set the proper route
                              |> AppModel.setRoute currentRoute
                in
                    (newModel, Cmd.none )
            Routing.CitationRoute -> 
                let
                              -- hide the search bar in navigation
                    newModel = Navbar.setNavBarSearchVisibility model.navbar False
                              |> AppModel.setNavbar model
                              -- set the proper route
                              |> AppModel.setRoute currentRoute
                in
                    (newModel, Cmd.none )
            Routing.AboutRoute -> 
                let
                              -- hide the search bar in navigation
                    newModel = Navbar.setNavBarSearchVisibility model.navbar False
                              |> AppModel.setNavbar model
                              -- set the proper route
                              |> AppModel.setRoute currentRoute
                in
                    (newModel, Cmd.none )
            Routing.ApiRoute -> 
                let
                              -- hide the search bar in navigation
                    newModel = Navbar.setNavBarSearchVisibility model.navbar False
                              |> AppModel.setNavbar model
                              -- set the proper route
                              |> AppModel.setRoute currentRoute
                in
                    (newModel, Cmd.none )
            Routing.StatisticsRoute -> 
                let
                              -- hide the search bar in navigation
                    newModel = Navbar.setNavBarSearchVisibility model.navbar False
                              |> AppModel.setNavbar model
                              -- set the proper route
                              |> AppModel.setRoute currentRoute
                in
                    (newModel, fetchStatistics )
            Routing.LicenseRoute -> 
                let
                              -- hide the search bar in navigation
                    newModel = Navbar.setNavBarSearchVisibility model.navbar False
                              |> AppModel.setNavbar model
                              -- set the proper route
                              |> AppModel.setRoute currentRoute
                in
                    (newModel, Cmd.none )
            Routing.EntryRoute id ->
                (AppModel.setRoute currentRoute model, Cmd.batch [fetchInfo id,
                                                             fetchProteoforms id,
                                                             fetchPTMDependentPPI id,
                                                             fetchProteoformsPPI id,
                                                             fetchSubstrates id,
                                                             fetchMSA id
                                                             ])
            Routing.SearchRoute queryString  -> 
                let 
                    newModel = SearchPage.setSearchTerm SearchPage.initialModel (ViewMisc.extractSearchTerm queryString)
                               |> SearchPage.setSelectedIndex 0
                               |> SearchPage.setQueryString queryString
                               |> AppModel.setSearchPage model 
                               |> AppModel.setRoute currentRoute   
                in
                    (newModel, Cmd.batch[fetchSearchResults queryString 0 SearchPage.entriesPerPage])
            Routing.BatchRoute ->
                (AppModel.setRoute currentRoute model, Cmd.none )
            Routing.BatchResultRoute ->
                let
                    _ = Debug.log "batch-result" "int batch result page" 
                in
                    (AppModel.setRoute currentRoute model, (fetchBatchData model.batchPage.outputType model.batchPage.kinases) )
            Routing.BrowseRoute ->
                let
                    newModel = BrowsePage.setSelectedIndex 0 model.browsePage
                               |> BrowsePage.setQueryString  "term_type=All&role=Enzyme%20or%20Substrate"
                               |> AppModel.setBrowsePage model
                               |> AppModel.setRoute currentRoute 
                in
                    (newModel, fetchBrowseResults "term_type=All&role=Enzyme%20or%20Substrate" 0 20 )
            Routing.NotFoundRoute ->
                (AppModel.setRoute currentRoute model, Cmd.none )