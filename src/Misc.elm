module Misc exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import String.Interpolate exposing (interpolate)

buildPMID: String -> Html Msg
buildPMID pmid =
    a [css [display inline], 
       href (interpolate "https://www.ncbi.nlm.nih.gov/pubmed/{0}" [pmid]), Html.Styled.Attributes.target "_blank"] [text pmid]