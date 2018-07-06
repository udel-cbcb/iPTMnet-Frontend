module Main exposing (..)
import Html exposing (..)
import Html.Styled exposing (toUnstyled)
import Page.Entry
import Page.License
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
import Page.Home
import Page.Search
import Page.Batch
import Page.BatchResult
import Page.Citation
import Page.About
import Page.Api
import Page.Statistics
import Ports
import List


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    Commands.handleRoute (Model.initialModel Routing.HomeRoute) location



-- VIEW
view : Model -> Html Msg
view model = 
    case model.route of
        Routing.HomeRoute -> 
            Page.Home.view model
            |> toUnstyled
        Routing.CitationRoute -> 
            Page.Citation.view model
            |> toUnstyled
        Routing.LicenseRoute -> 
            Page.License.view model
            |> toUnstyled
        Routing.AboutRoute -> 
            Page.About.view model
            |> toUnstyled
        Routing.StatisticsRoute -> 
            Page.Statistics.view model
            |> toUnstyled
        Routing.ApiRoute -> 
            Page.Api.view model
            |> toUnstyled
        Routing.EntryRoute id ->
            Page.Entry.view model
            |> toUnstyled
        Routing.SearchRoute queryString ->
            Page.Search.view model
            |> toUnstyled
        Routing.BatchRoute ->
            Page.Batch.view model
            |> toUnstyled
        Routing.BatchResultRoute ->
            Page.BatchResult.view model
            |> toUnstyled
        Routing.NotFoundRoute ->
            div [] []
        

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.NoOp ->
            ( model, Cmd.none )

        -- Home Page
        Msgs.OnHomePageSearchInputChange newContent ->
            let newModel = Model.setSearchInput model.homePage.searchOptions newContent
                           |> Model.setSearchOptions model.homePage
                           |> Model.setHomePage model
            in
                (newModel, Cmd.none)
        Msgs.SetSelectedPTMTypes ptm_types -> 
            let
                newModel = Model.setSelectedPTMTypes model.homePage.searchOptions ptm_types
                           |> Model.setSearchOptions model.homePage
                           |> Model.setHomePage model
            in
                (newModel, Cmd.none)
        Msgs.SetSelectedTaxons taxons -> 
            let
                newModel = Model.setSelectedTaxons model.homePage.searchOptions taxons
                           |> Model.setSearchOptions model.homePage
                           |> Model.setHomePage model
            in
                (newModel, Cmd.none)
        Msgs.OnTermTypeSelected newTermType ->
            let
                newModel = Model.setSearchTermType model.homePage.searchOptions newTermType
                            |> Model.setSearchOptions model.homePage
                            |> Model.setHomePage model
            in
                (newModel,Cmd.none)    
        Msgs.OnTaxonsUserInput newTaxons -> 
            let 
                newModel = Model.setOrganismsUser model.homePage.searchOptions newTaxons
                            |> Model.setSearchOptions model.homePage
                            |> Model.setHomePage model        
            in
                (newModel, Cmd.none)

        Msgs.OnAdvancedSearchVisibilityChange is_visible ->
            let 
                newModel = Model.setHomePageAdvancedSearchVisibility is_visible model.homePage
                          |> Model.setHomePage model
            in
                (newModel, Cmd.none)
        Msgs.SearchRoleChanged new_role ->
            let 
                newModel = Model.setSearchRole model.homePage.searchOptions new_role
                           |> Model.setSearchOptions model.homePage
                           |> Model.setHomePage model                           
            in     
                (newModel, Cmd.none)   

        -- Search Page
        Msgs.OnFetchSearchResults response -> 
            let
                newModel = Page.Search.decodeResponse response
                |> Model.setSearchData model.searchPage
                |> Model.setSearchPage model
            in
                ( newModel, Cmd.none)

        Msgs.OnSearchResultErrorButtonClicked ->
            let
                newModel = Model.setSearchShowErrorMsg (not model.searchPage.showErrorMsg) model.searchPage
                           |> Model.setSearchPage model
            in
                ( newModel, Cmd.none)      

        -- Entry Page
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
                newModel = Model.setSubstrateData model.entryPage (Views.Substrate.decodeResponse response)
                           |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)        
        Msgs.ChangeLocation path -> 
            ( model, Navigation.newUrl path)
        Msgs.OnLocationChange location ->
            Commands.handleRoute model location
        Msgs.OnInfoErrorButtonClicked ->
            let 
                newModel = Model.setShowInfoErrorMsg (not model.entryPage.showInfoErrorMsg) model.entryPage
                          |> Model.setEntryPage model
            in
            (newModel, Cmd.none)
        Msgs.OnSubstrateErrorButtonClicked ->
            let 
                newModel = Model.setShowSubstrateErrorMsg (not model.entryPage.showSubstrateErrorMsg) model.entryPage
                          |> Model.setEntryPage model
            in
            (newModel, Cmd.none)
        Msgs.OnSubstrateTabClick clickedTab -> 
            let 
                newModel = Model.setSelectedSubstrateTab clickedTab model.entryPage.substrateData.tabData
                               |> Model.setSubstrateTabData model.entryPage.substrateData
                               |> Model.setSubstrateData model.entryPage
                               |> Model.setEntryPage model
            in
                (newModel, Cmd.none)
        Msgs.OnProteoformsErrorButtonClicked ->
            let 
                newModel = Model.setShowProteoformsErrorMsg (not model.entryPage.showProteoformsErrorMsg) model.entryPage
                          |> Model.setEntryPage model
            in
            (newModel, Cmd.none)
        Msgs.OnSubstrateSearch searchTerm ->
            let 
                newModel = Model.setSubstrateFilterTerm model.entryPage.substrateData searchTerm
                           |> Model.setSubstrateData model.entryPage
                           |> Model.setEntryPage model
            in 
            (newModel, Cmd.none)
        Msgs.OnProteoformSearch searchTerm ->
            let 
                newModel = Model.setProteoformsFilterTerm model.entryPage.proteoformsData searchTerm
                           |> Model.setProteoformsData model.entryPage
                           |> Model.setEntryPage model
            in 
            (newModel, Cmd.none)
        Msgs.OnPTMDepPPIErrorButtonClicked ->
            let 
                newModel = Model.setShowPTMDepPPIErrorMsg (not model.entryPage.showPTMDepPPIErrorMsg) model.entryPage
                          |> Model.setEntryPage model
            in
            (newModel, Cmd.none)
        Msgs.OnPTMPPISearch searchTerm ->
            let 
                newModel = Model.setPTMDependentPPIFilterTerm model.entryPage.ptmDependentPPIData searchTerm
                           |> Model.setPTMDependentPPIData model.entryPage
                           |> Model.setEntryPage model
            in 
            (newModel, Cmd.none)
        Msgs.OnProteoformPPISearch searchTerm ->
            let 
                newModel = Model.setProteoformPPIFilterTerm model.entryPage.proteoformPPIData searchTerm
                           |> Model.setProteoformPPIData model.entryPage
                           |> Model.setEntryPage model
            in 
            (newModel, Cmd.none)
        Msgs.OnProteoformsPPIErrorButtonClicked ->
            let 
                newModel = Model.setShowProteoformsPPIErrorMsg (not model.entryPage.showProteoformsPPIErrorMsg) model.entryPage
                          |> Model.setEntryPage model
            in
            (newModel, Cmd.none)
        Msgs.ScrollToElement element ->
            (model, Ports.scrollToDiv element)
    

        -- Cytoscape
        Msgs.ToggleCytoscapeItem cytoscapeItem ->
            case List.member cytoscapeItem model.entryPage.cytoscapeItems of
                True -> 
                    let 
                        newModel = Model.setCytoscapeItems model.entryPage (List.filter (\ e -> e /= cytoscapeItem) model.entryPage.cytoscapeItems)
                        |> Model.setEntryPage model
                    in
                        (newModel, Cmd.none) 
                False -> 
                    let 
                        newModel = Model.setCytoscapeItems model.entryPage (List.append model.entryPage.cytoscapeItems [cytoscapeItem])
                        |> Model.setEntryPage model
                    in
                        (newModel, Cmd.none)
        Msgs.RemoveCytoscapeItem cytoscapeItem -> 
            let 
                newModel = Model.setCytoscapeItems model.entryPage (List.filter (\ e -> e /= cytoscapeItem) model.entryPage.cytoscapeItems)
                |> Model.setEntryPage model
            in
                (newModel, Cmd.none)
        Msgs.CytoscapeClearClicked ->
            let 
                newModel = Model.setCytoscapeItems model.entryPage []
                |> Model.setEntryPage model
            in
                (newModel, Cmd.none)      
            

        -- Batch
        Msgs.OnFileChange file ->
            case file of
                -- Only handling case of a single file
                [ f ] ->
                    let 
                        _ = Debug.log "msg" f
                    in
                        (model, Commands.getFileContents f)

                _ ->
                    (model, Cmd.none)

        Msgs.OnFileContent res ->
            case res of
                Ok content ->
                    let 
                        kinases = Model.toKinaseList content
                        newModel = Model.setKinases kinases model.batchPage
                                   |> Model.setBatchInputText content 
                                   |> Model.setBatchPage model  
                    in
                        ( newModel , Cmd.none )

                Err err ->
                    Debug.crash (toString err)
        
        Msgs.OnBatchInputChanged newContent ->
            let 
                kinases = Model.toKinaseList newContent
                newModel = Model.setKinases kinases model.batchPage 
                           |> Model.setBatchInputText newContent
                           |> Model.setBatchPage model  
            in
                ( newModel , Cmd.none )
        
        Msgs.OnBatchInputExampleClicked ->
            let 
                exampleInput = "Q15796\tK\t19\nQ15796\tT\t8\nP04637\tK\t120\nP04637\tS\t149\nP04637\tS\t378\nP04637\tS\t392\nP42356\tS\t199"

                newModel = Model.setBatchInputText exampleInput model.batchPage
                           |> Model.setKinases (Model.toKinaseList exampleInput)
                           |> Model.setBatchPage model
            in
                (newModel, Cmd.none) 

        Msgs.OnBatchClearClicked ->
            let 
                newModel = Model.setBatchInputText " " model.batchPage
                           |> Model.setKinases []
                           |> Model.setBatchPage model
            in
                (newModel, Cmd.none) 

        -- Batch Results
        Msgs.OnFetchBatchEnzymes response ->
            let 
                newModel = 
                    Page.BatchResult.decodeEnzymeResponse response model.batchPage.kinases
                    |> Model.setBatchEnzymeData model.batchPage
                    |> Model.setBatchPage model
            in
                (newModel, Cmd.none)

        Msgs.OnFetchBatchPTMPPI response ->
            let 
                _ = Debug.log "ptm_ppi" response
                newModel = 
                    Page.BatchResult.decodePTMPPIResponse response model.batchPage.kinases
                    |> Model.setBatchPTMPPIData model.batchPage
                    |> Model.setBatchPage model
            in
                (newModel, Cmd.none)

        Msgs.SwitchBatchOutput output ->
            let 
                newModel = Model.setBatchOutput model.batchPage output
                           |> Model.setBatchPage model
                            
            in
                (newModel, Cmd.none)
        Msgs.OnBatchTabClick newTab ->
            let 
                newModel = Model.setSelectedBatchTab model.batchPage newTab
                               |> Model.setBatchPage model
            in
                (newModel, Cmd.none)           

        -- Statistics
        Msgs.OnFetchStatistics response -> 
            let
                statistics = Page.Statistics.decodeResponse response
                _ = Debug.log "stats" statistics
                newModel = Model.setStatistics model.statisticsPage statistics
                          |> Model.setStatisticsPage model
            in
                (newModel, Cmd.none)       
            


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