module Model.SearchPage exposing (..)
import Model.Misc exposing (..)
import Model.SearchResult exposing (..)

type alias SearchPage = 
    {
        query_params : String,
        searchTerm : String,
        searchData: SearchData,
        showErrorMsg: Bool
    }

setSearchData : SearchPage -> SearchData -> SearchPage
setSearchData searchPage newData =
    { searchPage | searchData = newData }

setSearchTerm : SearchPage -> String -> SearchPage
setSearchTerm searchPage newSearchTerm =
    { searchPage | searchTerm = newSearchTerm }

setSearchShowErrorMsg: Bool -> SearchPage -> SearchPage
setSearchShowErrorMsg newValue searchPage =
    { searchPage | showErrorMsg = newValue }


initialModel : SearchPage
initialModel =
    {
        query_params = "",
        searchTerm = "",
        searchData = {
            status = 0,
            error = "",
            count = 0,
            data = []
        },
        showErrorMsg = False
    }
