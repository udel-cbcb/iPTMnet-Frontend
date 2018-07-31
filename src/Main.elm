module Main exposing (..)
import Html exposing (..)
import Html.Styled exposing (toUnstyled)
import Page.Entry
import Page.License
import Msgs exposing (Msg)
import Commands exposing (..)
import Navigation
import Routing
import Views.Info
import Views.Proteoforms
import Views.PTMDependentPPI
import Views.ProteoformPPI
import Views.Substrate
import Views.Alignment
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
import Model.AppModel as Model exposing (..)
import Model.HomePage as HomePage exposing (..)
import Model.SearchOptions as SearchOptions exposing (..)
import Model.SearchPage as SearchPage exposing (..)
import Model.EntryPage as EntryPage exposing (..)
import Model.Substrate as Substrate exposing (..)
import Model.Tab as Tab exposing (..)
import Model.Proteoform as Proteoform exposing (..)
import Model.PTMDependentPPI as PTMDependentPPI exposing (..)
import Model.ProteoformPPI as ProteoformPPI exposing (..)
import Model.Kinase as Kinase exposing (..)
import Model.BatchPage as BatchPage exposing (..)
import Model.StatisticsPage as StatisticsPage exposing (..)
import Model.AlignmentViewer as AlignmentViewer exposing (..)

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
            let newModel = SearchOptions.setSearchInput model.homePage.searchOptions newContent
                           |> HomePage.setSearchOptions model.homePage
                           |> Model.setHomePage model
            in
                (newModel, Cmd.none)
        Msgs.SetSelectedPTMTypes ptm_types -> 
            let
                newModel = SearchOptions.setSelectedPTMTypes model.homePage.searchOptions ptm_types
                           |> HomePage.setSearchOptions model.homePage
                           |> Model.setHomePage model
            in
                (newModel, Cmd.none)
        Msgs.SetSelectedTaxons taxons -> 
            let
                newModel = SearchOptions.setSelectedTaxons model.homePage.searchOptions taxons
                           |> HomePage.setSearchOptions model.homePage
                           |> Model.setHomePage model
            in
                (newModel, Cmd.none)
        Msgs.OnTermTypeSelected newTermType ->
            let
                newModel = SearchOptions.setSearchTermType model.homePage.searchOptions newTermType
                            |> HomePage.setSearchOptions model.homePage
                            |> Model.setHomePage model
            in
                (newModel,Cmd.none)    
        Msgs.OnTaxonsUserInput newTaxons -> 
            let 
                newModel = SearchOptions.setOrganismsUser model.homePage.searchOptions newTaxons
                            |> HomePage.setSearchOptions model.homePage
                            |> Model.setHomePage model        
            in
                (newModel, Cmd.none)

        Msgs.OnAdvancedSearchVisibilityChange is_visible ->
            let 
                newModel = HomePage.setHomePageAdvancedSearchVisibility is_visible model.homePage
                          |> Model.setHomePage model
            in
                (newModel, Cmd.none)
        Msgs.SearchRoleChanged new_role ->
            let 
                newModel = SearchOptions.setSearchRole model.homePage.searchOptions new_role
                           |> HomePage.setSearchOptions model.homePage
                           |> Model.setHomePage model                           
            in     
                (newModel, Cmd.none)   

        -- Search Page
        Msgs.OnFetchSearchResults response -> 
            let
                newModel = Page.Search.decodeResponse response
                |> SearchPage.setSearchData model.searchPage
                |> Model.setSearchPage model
            in
                ( newModel, Cmd.none)

        Msgs.OnSearchResultErrorButtonClicked ->
            let
                newModel = SearchPage.setSearchShowErrorMsg (not model.searchPage.showErrorMsg) model.searchPage
                           |> Model.setSearchPage model
            in
                ( newModel, Cmd.none)      

        -- Entry Page
        Msgs.OnFetchInfo response ->
            let
                newModel = Views.Info.decodeResponse response
                        |> EntryPage.setInfo model.entryPage
                        |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.OnFetchProteoform response -> 
            let
                newModel = Views.Proteoforms.decodeResponse response
                |> EntryPage.setProteoformsData model.entryPage
                |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.OnFetchPTMDependentPPI response -> 
            let
                newModel = Views.PTMDependentPPI.decodeResponse response
                |> EntryPage.setPTMDependentPPIData model.entryPage
                |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.OnFetchProteoformPPI response -> 
            let
                newModel = Views.ProteoformPPI.decodeResponse response
                |> EntryPage.setProteoformPPIData model.entryPage
                |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)
        Msgs.OnFetchSubstrates response -> 
            let
                newModel = EntryPage.setSubstrateData model.entryPage (Views.Substrate.decodeResponse response)
                           |> Model.setEntryPage model
            in
                ( newModel, Cmd.none)        
        Msgs.ChangeLocation path -> 
            ( model, Navigation.newUrl path)
        Msgs.OnLocationChange location ->
            Commands.handleRoute model location
        Msgs.OnInfoErrorButtonClicked ->
            let 
                newModel = EntryPage.setShowInfoErrorMsg (not model.entryPage.showInfoErrorMsg) model.entryPage
                          |> Model.setEntryPage model
            in
            (newModel, Cmd.none)
        Msgs.OnSubstrateErrorButtonClicked ->
            let 
                newModel = EntryPage.setShowSubstrateErrorMsg (not model.entryPage.showSubstrateErrorMsg) model.entryPage
                          |> Model.setEntryPage model
            in
            (newModel, Cmd.none)
        Msgs.OnSubstrateTabClick clickedTab -> 
            let 
                newModel = Tab.setSelectedTab clickedTab model.entryPage.substrateData.tabData
                               |> Substrate.setSubstrateTabData model.entryPage.substrateData
                               |> EntryPage.setSubstrateData model.entryPage
                               |> Model.setEntryPage model
            in
                (newModel, Cmd.none)
        Msgs.OnProteoformsErrorButtonClicked ->
            let 
                newModel = EntryPage.setShowProteoformsErrorMsg (not model.entryPage.showProteoformsErrorMsg) model.entryPage
                          |> Model.setEntryPage model
            in
            (newModel, Cmd.none)
        Msgs.OnSubstrateSearch searchTerm ->
            let 
                newModel = Substrate.setSubstrateFilterTerm model.entryPage.substrateData searchTerm
                           |> EntryPage.setSubstrateData model.entryPage
                           |> Model.setEntryPage model
            in 
            (newModel, Cmd.none)
        Msgs.OnProteoformSearch searchTerm ->
            let 
                newModel = Proteoform.setProteoformsFilterTerm model.entryPage.proteoformsData searchTerm
                           |> EntryPage.setProteoformsData model.entryPage
                           |> Model.setEntryPage model
            in 
            (newModel, Cmd.none)
        Msgs.OnPTMDepPPIErrorButtonClicked ->
            let 
                newModel = EntryPage.setShowPTMDepPPIErrorMsg (not model.entryPage.showPTMDepPPIErrorMsg) model.entryPage
                          |> Model.setEntryPage model
            in
            (newModel, Cmd.none)
        Msgs.OnPTMPPISearch searchTerm ->
            let 
                newModel = PTMDependentPPI.setPTMDependentPPIFilterTerm model.entryPage.ptmDependentPPIData searchTerm
                           |> EntryPage.setPTMDependentPPIData model.entryPage
                           |> Model.setEntryPage model
            in 
            (newModel, Cmd.none)
        Msgs.OnProteoformPPISearch searchTerm ->
            let 
                newModel = ProteoformPPI.setProteoformPPIFilterTerm model.entryPage.proteoformPPIData searchTerm
                           |> EntryPage.setProteoformPPIData model.entryPage
                           |> Model.setEntryPage model
            in 
            (newModel, Cmd.none)
        Msgs.OnProteoformsPPIErrorButtonClicked ->
            let 
                newModel = EntryPage.setShowProteoformsPPIErrorMsg (not model.entryPage.showProteoformsPPIErrorMsg) model.entryPage
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
                        newModel = EntryPage.setCytoscapeItems model.entryPage (List.filter (\ e -> e /= cytoscapeItem) model.entryPage.cytoscapeItems)
                        |> Model.setEntryPage model
                    in
                        (newModel, Cmd.none) 
                False -> 
                    let 
                        newModel = EntryPage.setCytoscapeItems model.entryPage (List.append model.entryPage.cytoscapeItems [cytoscapeItem])
                        |> Model.setEntryPage model
                    in
                        (newModel, Cmd.none)
        Msgs.RemoveCytoscapeItem cytoscapeItem -> 
            let 
                newModel = EntryPage.setCytoscapeItems model.entryPage (List.filter (\ e -> e /= cytoscapeItem) model.entryPage.cytoscapeItems)
                |> Model.setEntryPage model
            in
                (newModel, Cmd.none)
        Msgs.CytoscapeClearClicked ->
            let 
                newModel = EntryPage.setCytoscapeItems model.entryPage []
                |> Model.setEntryPage model
            in
                (newModel, Cmd.none)      
            

        -- Batch
        Msgs.OnFileChange file ->
            case file of
                -- Only handling case of a single file
                [ f ] ->
                    (model, Commands.getFileContents f)
                _ ->
                    (model, Cmd.none)

        Msgs.OnFileContent res ->
            case res of
                Ok content ->
                    let 
                        kinases = Kinase.toKinaseList content
                        newModel = BatchPage.setKinases kinases model.batchPage
                                   |> BatchPage.setBatchInputText content 
                                   |> Model.setBatchPage model  
                    in
                        ( newModel , Cmd.none )

                Err err ->
                    Debug.crash (toString err)
        
        Msgs.OnBatchInputChanged newContent ->
            let 
                kinases = Kinase.toKinaseList newContent
                newModel = BatchPage.setKinases kinases model.batchPage 
                           |> BatchPage.setBatchInputText newContent
                           |> Model.setBatchPage model  
            in
                ( newModel , Cmd.none )
        
        Msgs.OnBatchInputExampleClicked ->
            let 
                exampleInput = "Q15796\tK\t19\nQ15796\tT\t8\nP04637\tK\t120\nP04637\tS\t149\nP04637\tS\t378\nP04637\tS\t392\nP42356\tS\t199"

                newModel = BatchPage.setBatchInputText exampleInput model.batchPage
                           |> BatchPage.setKinases (Kinase.toKinaseList exampleInput)
                           |> Model.setBatchPage model
            in
                (newModel, Cmd.none) 

        Msgs.OnBatchClearClicked ->
            let 
                newModel = BatchPage.setBatchInputText " " model.batchPage
                           |> BatchPage.setKinases []
                           |> Model.setBatchPage model
            in
                (newModel, Cmd.none) 

        -- Batch Results
        Msgs.OnFetchBatchEnzymes response ->
            let 
                newModel = 
                    Page.BatchResult.decodeEnzymeResponse response model.batchPage.kinases
                    |> BatchPage.setBatchEnzymeData model.batchPage
                    |> Model.setBatchPage model
            in
                (newModel, Cmd.none)

        Msgs.OnFetchBatchPTMPPI response ->
            let 
                newModel = 
                    Page.BatchResult.decodePTMPPIResponse response model.batchPage.kinases
                    |> BatchPage.setBatchPTMPPIData model.batchPage
                    |> Model.setBatchPage model
            in
                (newModel, Cmd.none)

        Msgs.SwitchBatchOutput output ->
            let 
                newModel = BatchPage.setBatchOutput model.batchPage output
                           |> Model.setBatchPage model
                            
            in
                (newModel, Cmd.none)
        Msgs.OnBatchTabClick newTab ->
            let 
                newModel = BatchPage.setSelectedBatchTab model.batchPage newTab
                               |> Model.setBatchPage model
            in
                (newModel, Cmd.none)           

        -- Statistics
        Msgs.OnFetchStatistics response -> 
            let
                statistics = Page.Statistics.decodeResponse response
                newModel = StatisticsPage.setStatistics model.statisticsPage statistics
                          |> Model.setStatisticsPage model
            in
                (newModel, Cmd.none)       
            
        -- Alignment
        Msgs.OnFetchAlignment response -> 
            let 
                alignmentViewer = Views.Alignment.decodeResponse (Debug.log "response" response)
                newModel = Model.setAlignmentViewer model alignmentViewer
            in
                (newModel, Cmd.none)
        Msgs.OnSequenceHover rowIndex columnIndex ->
            let 
                _ = Debug.log "hover_index -> " ((toString rowIndex) ++ " : " ++ (toString columnIndex))
                newModel = AlignmentViewer.setSelectedAlignmentRowIndex rowIndex model.alignmentViewer
                          |> AlignmentViewer.setSelectedAlignmentColumnIndex columnIndex
                          |> Model.setAlignmentViewer model
            in
                (newModel,Cmd.none)


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