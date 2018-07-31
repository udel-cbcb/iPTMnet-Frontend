module Model.HomePage exposing (..)
import Model.SearchOptions exposing (..)

type alias HomePage = 
    {
        searchOptions: SearchOptions,
        advancedSearchVisibility: Bool
    }

setSearchOptions : HomePage -> SearchOptions -> HomePage
setSearchOptions homePage newSearchOptions = 
    { homePage | searchOptions = newSearchOptions }

setHomePageAdvancedSearchVisibility: Bool -> HomePage -> HomePage
setHomePageAdvancedSearchVisibility is_visible homePage =
    {homePage | advancedSearchVisibility = is_visible}

initialModel : HomePage
initialModel =
    {
        searchOptions = {
            searchTerm = "",
            searchTermType = "All",
            ptm_types = [],
            role = "Enzyme or Substrate",
            organisms_defaults = [],
            organisms_user = ""
        },
        advancedSearchVisibility = False
    }