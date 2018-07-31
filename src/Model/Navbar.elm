module Model.Navbar exposing (..)
import Model.SearchOptions exposing (..)

-- Nav bar
type alias Navbar = 
    {
        searchOptions: SearchOptions,
        isSearchVisible: Bool,
        advancedSearchVisibility: Bool
    }

setNavBarSearchVisibility: Navbar -> Bool -> Navbar
setNavBarSearchVisibility navBar isSearchVisible =
    {navBar | isSearchVisible = isSearchVisible}

initialModel : Navbar
initialModel =
    {
        searchOptions = {
            searchTerm = "",
            searchTermType = "",
            ptm_types = [],
            role = "Enzyme or Substrate",
            organisms_defaults = [],
            organisms_user = ""
        },
        isSearchVisible = False,
        advancedSearchVisibility = False
    }