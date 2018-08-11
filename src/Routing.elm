module Routing exposing (..)
import Navigation
import String.Extra exposing (..)
import Model.Misc exposing (..)

type Route
    = HomeRoute
    | LicenseRoute
    | CitationRoute
    | AboutRoute
    | ApiRoute
    | StatisticsRoute
    | EntryRoute String
    | SearchRoute String
    | BatchRoute
    | BatchResultRoute
    | BrowseRoute 
    | NotFoundRoute


{-|
Match a location given by the Navigation package and return the matched route.
-}
parseLocation : Navigation.Location -> Route
parseLocation location =
    if String.contains "/home" location.pathname then
        HomeRoute
    else if String.contains "/license" location.pathname then 
        LicenseRoute
    else if String.contains "/citation" location.pathname then
        CitationRoute
    else if String.contains "/batch-result" location.pathname then
        BatchResultRoute
    else if String.contains "/batch" location.pathname then
        BatchRoute
    else if String.contains "/api" location.pathname then
        ApiRoute
    else if String.contains "/about" location.pathname then
        AboutRoute
    else if String.contains "/statistics" location.pathname then
        StatisticsRoute
    else if String.contains "/browse" location.pathname then
        BrowseRoute
    else if String.contains "/entry" location.pathname then
        EntryRoute (rightOf "/entry/" location.pathname)
    else if String.contains "/search" location.pathname then
        SearchRoute (rightOf "/search/" location.pathname)
    else if (rightOf pathname location.pathname |> isBlank) then
        HomeRoute
    else
        NotFoundRoute