module Routing exposing (..)
import UrlParser exposing (s, (</>), string)
import Navigation

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
    | NotFoundRoute


{-|
Define how to match urls
-}
matchers : UrlParser.Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ UrlParser.map HomeRoute UrlParser.top
        , UrlParser.map LicenseRoute (s "license")
        , UrlParser.map CitationRoute (s "citation") 
        , UrlParser.map AboutRoute (s "about") 
        , UrlParser.map ApiRoute (s "api")
        , UrlParser.map StatisticsRoute (s "statistics") 
        , UrlParser.map EntryRoute (s "entry" </> string)
        , UrlParser.map SearchRoute (s "search" </> string)
        , UrlParser.map BatchRoute (s "batch")
        , UrlParser.map BatchResultRoute (s "batch-result")
        ]


{-|
Match a location given by the Navigation package and return the matched route.
-}
parseLocation : Navigation.Location -> Route
parseLocation location =
    case (UrlParser.parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute