module Entry exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)
import String
import Views.Info
import Views.Sequence
import Views.Substrate
import Views.Proteoforms
import Views.PTMDependentPPI

view : Model -> Html Msg
view model =  
            div [id "page",css [
            Css.property "height" "100%",
            displayFlex,
            flexDirection row,
            flex (num 1)
            ]
        ] [
            div [id "sidebar", css [
                displayFlex,
                flexDirection column,
                alignItems center,
                backgroundColor (hex "ecececff"),
                flexGrow (num 1)
            ]][
                text "Display"
            ],
            div [id "content", css [
                displayFlex,
                flexDirection column,
                flexGrow (num 4),
                paddingLeft (px 40),
                paddingRight (px 40)
            ]][
                Views.Info.view model.entryPage.info,
                Views.Sequence.view,
                Views.Substrate.view,
                Views.Proteoforms.view model.entryPage.proteoforms,
                Views.PTMDependentPPI.view
            ]
        ]






