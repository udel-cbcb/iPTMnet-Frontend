module Model.SearchOptions exposing (..)

type alias SearchOptions = 
    {
        searchTerm : String,
        searchTermType : String,
        ptm_types : (List String),
        role : String,
        organisms_defaults: (List String),
        organisms_user: String
    }

setSelectedPTMTypes : SearchOptions -> (List String) -> SearchOptions
setSelectedPTMTypes searchOptions selected_ptms = 
    {searchOptions | ptm_types = selected_ptms}

setSelectedTaxons : SearchOptions -> (List String) -> SearchOptions
setSelectedTaxons searchOptions selected_taxons = 
    {searchOptions | organisms_defaults = selected_taxons}

setSearchRole : SearchOptions -> String -> SearchOptions
setSearchRole searchOptions new_role =
    {searchOptions | role = new_role}

setSearchTermType : SearchOptions -> String -> SearchOptions
setSearchTermType searchOptions new_term_type =
    {searchOptions | searchTermType = new_term_type}

setOrganismsUser : SearchOptions -> String -> SearchOptions
setOrganismsUser searchOptions new_taxons =
    {searchOptions | organisms_user = new_taxons}

setSearchInput: SearchOptions -> String -> SearchOptions
setSearchInput searchOptions newInput =
    { searchOptions | searchTerm = newInput }