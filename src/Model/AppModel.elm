module Model.AppModel exposing (..)
import Model.Navbar as Navbar exposing (..)
import Model.HomePage as HomePage exposing (..)
import Model.SearchPage as SearchPage exposing (..)
import Model.EntryPage as EntryPage exposing (..) 
import Model.BatchPage as BatchPage exposing (..)
import Model.StatisticsPage as StatisticsPage exposing (..)
import Model.AlignmentViewer as AlignmentViewer exposing (..)
import Model.Misc exposing (..)
import Model.BrowsePage as BrowsePage exposing (..)

import Routing

type alias Model =
    {
        route: Routing.Route,
        navbar: Navbar,
        searchPage: SearchPage,
        homePage: HomePage,
        entryPage: EntryPage,
        batchPage: BatchPage,
        statisticsPage: StatisticsPage,
        alignmentViewer: AlignmentViewer,
        browsePage: BrowsePage         
    }

initialModel : Routing.Route -> Model
initialModel route = 
    { 
        route = route,
        navbar = Navbar.initialModel,
        homePage = HomePage.initialModel,
        searchPage = SearchPage.initialModel,
        entryPage = EntryPage.initialModel,

        batchPage = {
            kinases = [],
            outputType = Enzymes,
            batchEnzymeData = {
                status = NotAsked,
                error = "",
                data = {
                    list_found = {
                        count = 0,
                        with_enzyme = [],
                        without_enzyme = []
                    },
                    list_not_found = []
                }
            },
            selectedTab = "Input sites found in iPTMnet",
            batchPTMPPIData = {
                status = NotAsked,
                error = "",
                data = {
                    ptm_ppi = [],
                    sites_without_interactants = [],
                    not_found = []
                }
            },
            inputText = ""
        },
        statisticsPage = StatisticsPage.initialModel,
        alignmentViewer = defaultAlignmentViewer,
        browsePage = BrowsePage.initialModel

    }

setRoute: Routing.Route -> Model -> Model
setRoute new_route model = 
    {model | route = new_route }

setNavbar: Model -> Navbar -> Model
setNavbar model newNavbar =
    {model | navbar = newNavbar}

setHomePage : Model -> HomePage -> Model
setHomePage model newHomePage = 
    { model | homePage = newHomePage}

setSearchPage : Model -> SearchPage -> Model
setSearchPage model newSearchPage = 
    { model | searchPage = newSearchPage}

setBrowsePage : Model -> BrowsePage -> Model
setBrowsePage model newBrowsePage = 
    { model | browsePage = newBrowsePage}

setEntryPage : Model -> EntryPage -> Model
setEntryPage model newEntryPage = 
    { model | entryPage = newEntryPage}

setBatchPage: Model -> BatchPage -> Model
setBatchPage model newBatchPage = 
    { model | batchPage = newBatchPage }

setStatisticsPage : Model -> StatisticsPage -> Model
setStatisticsPage model newPage = 
    { model | statisticsPage = newPage}

setAlignmentViewer : Model -> AlignmentViewer -> Model
setAlignmentViewer model newAlignmentViewer = 
    {model | alignmentViewer = newAlignmentViewer}



