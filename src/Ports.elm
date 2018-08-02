port module Ports exposing (..)


import Model.SearchResult exposing (..)

port scrollToDiv : String -> Cmd msg

port highlight : String -> Cmd msg

port performSearch : String -> Cmd msg

port onSearchDone : (SearchData -> msg) -> Sub msg

