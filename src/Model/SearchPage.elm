module Model.SearchPage exposing (..)
import Model.Misc exposing (..)
import Model.SearchResult exposing (..)

type alias SearchPage = 
    {
        query_params : String,
        searchData: SearchData,
        showErrorMsg: Bool
    }

setSearchData : SearchPage -> SearchData -> SearchPage
setSearchData searchPage newData =
    { searchPage | searchData = newData }

setSearchShowErrorMsg: Bool -> SearchPage -> SearchPage
setSearchShowErrorMsg newValue searchPage =
    { searchPage | showErrorMsg = newValue }


initialModel : SearchPage
initialModel =
    {
        query_params = "",
        searchData = {
            status = NotAsked,
            error = "",
            data = []
        },
        showErrorMsg = False
    }
