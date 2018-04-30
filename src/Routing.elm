module Routing exposing (..)
import UrlParser exposing (s, (</>), string)
import Navigation

type Route
    = HomeRoute
    | EntryRoute String
    | NotFoundRoute


{-|
Define how to match urls
-}
matchers : UrlParser.Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ UrlParser.map HomeRoute UrlParser.top
        , UrlParser.map EntryRoute (s "entry" </> string)
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