module Model.BrowsePage exposing (..)
import Model.BrowseResult as BrowseResult exposing (..)

type alias BrowsePage = 
    {
        queryString : String,
        selectedIndex : Int,
        browseData: BrowseData,
        showErrorMsg: Bool
    }

initialModel : BrowsePage
initialModel = 
    {
        queryString = "",
        selectedIndex = 0,
        browseData = BrowseResult.initialBrowseData,
        showErrorMsg = False
    }

setBrowseData : BrowseData -> BrowsePage -> BrowsePage
setBrowseData newData browsePage =
    { browsePage | browseData = newData }

setQueryString : String -> BrowsePage -> BrowsePage
setQueryString newQueryString browsePage =
    { browsePage | queryString = newQueryString }

setSelectedIndex : Int -> BrowsePage -> BrowsePage
setSelectedIndex newIndex browsePage =
    if newIndex < 0 then
        { browsePage | selectedIndex = 0 }
    else
        { browsePage | selectedIndex = newIndex }

setBrowseShowErrorMsg: Bool -> BrowsePage -> BrowsePage
setBrowseShowErrorMsg newValue browsePage =
    { browsePage | showErrorMsg = newValue }

entriesPerPage : Int
entriesPerPage =
    20

