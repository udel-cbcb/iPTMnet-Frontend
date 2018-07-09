module Views.Sequence exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Views.Alignment
import Model

-- returns the sequence view
view: Model.AlignmentViewer -> Html Msg 
view alignmentViewer =
    div [id "sequence_viewer", css [marginTop (px 20)] ][
        div [css [
            fontSize (px 20),
            fontWeight normal
        ]] [text "Interactive Sequence View"],

        div [
            id "div_sequence_alignment_viewer",
            css [
                marginTop (px 10)
            ]][
                Views.Alignment.view alignmentViewer
        ]

    ]