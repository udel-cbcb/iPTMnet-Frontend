module Misc exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import String.Interpolate exposing (interpolate)
import Html.Styled.Events exposing (on, keyCode, onInput)
import Json.Decode as Json
import String.Extra
import Model.SearchOptions exposing (..)
import Regex


buildPMID: String -> Html Msg
buildPMID pmid =
    a [css [display inline], 
       href (interpolate "https://www.ncbi.nlm.nih.gov/pubmed/{0}" [pmid]), Html.Styled.Attributes.target "_blank"] [text pmid]

onKeyDown : (Int -> msg) -> Html.Styled.Attribute msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)

buildSearchUrl: SearchOptions -> String
buildSearchUrl searchOptions =
    let
        ptm_types = case (List.length searchOptions.ptm_types) > 0 of
                        True -> interpolate "&{0}" [(String.join "&" (List.map buildPTMType searchOptions.ptm_types))]
                        False -> ""
        
        taxon_codes = searchOptions.organisms_defaults
                      ++ 
                      (
                        String.Extra.clean searchOptions.organisms_user  
                        |> String.split ","
                        |> List.map String.Extra.clean
                        |> List.filter isNotEmpty 
                      )
                       
        taxons = case (List.length taxon_codes) > 0 of 
                            True -> interpolate "&{0}" [(String.join "&" (List.map buildOrganism taxon_codes))] 
                            False -> ""

    in
        interpolate "/search/search_term={0}&term_type={1}&role={2}{3}{4}" [searchOptions.searchTerm,
                                                                            searchOptions.searchTermType,
                                                                            searchOptions.role,
                                                                            ptm_types,
                                                                            taxons]

buildPTMType: String -> String
buildPTMType ptm_type =
    interpolate "ptm_type={0}" [ptm_type]

buildOrganism: String -> String
buildOrganism organism = 
    interpolate "organism={0}" [organism]

isNotEmpty : String -> Bool
isNotEmpty string =
    not (String.Extra.isBlank string)

performSearch : SearchOptions -> Msg
performSearch searchOptions =
    case (String.Extra.clean searchOptions.searchTerm) == "" of 
                                      False -> Msgs.ChangeLocation (buildSearchUrl searchOptions)
                                      True -> ChangeLocation "/"

extractSearchTerm : String -> String
extractSearchTerm queryString =
    Regex.find (Regex.AtMost 1) (Regex.regex "=\\d*\\w*&") queryString
    |> List.map (\item -> item.match)
    |> List.head
    |> Maybe.withDefault ""
    |> String.Extra.replace "=" ""
    |> String.Extra.replace "&" ""