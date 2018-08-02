module Model.SearchPage exposing (..)
import Model.SearchResult exposing (..)

type alias SearchPage = 
    {
        query_params : String,
        searchTerm : String,
        queryString : String,
        selectedIndex : Int,
        searchData: SearchData,
        showErrorMsg: Bool
    }

setSearchData : SearchPage -> SearchData -> SearchPage
setSearchData searchPage newData =
    { searchPage | searchData = newData }

setSearchTerm : SearchPage -> String -> SearchPage
setSearchTerm searchPage newSearchTerm =
    { searchPage | searchTerm = newSearchTerm }

setQueryString : String -> SearchPage -> SearchPage
setQueryString newQueryString searchPage =
    { searchPage | queryString = newQueryString }

setSelectedIndex : Int -> SearchPage -> SearchPage
setSelectedIndex newIndex searchPage =
    if newIndex < 0 then
        { searchPage | selectedIndex = 0 }
    else
        { searchPage | selectedIndex = newIndex }

setSearchShowErrorMsg: Bool -> SearchPage -> SearchPage
setSearchShowErrorMsg newValue searchPage =
    { searchPage | showErrorMsg = newValue }

entriesPerPage : Int
entriesPerPage =
    20


initialModel : SearchPage
initialModel =
    {
        query_params = "",
        searchTerm = "",
        queryString = "",
        selectedIndex = 0,
        searchData = initialSearchData,
        showErrorMsg = False
    }
