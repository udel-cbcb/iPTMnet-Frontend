module Views.Sequence exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)

-- returns the sequence view
view: Html Msg 
view =
    div [id "sequence_viewer", css [marginTop (px 20)] ][
        h4 [css [
            fontSize (px 20),
            fontWeight normal
        ]] [text "Interactive Sequence View"],

                div [id "proteoformppi_table", css [
            displayFlex,
            flexDirection column,
            fontSize (px 13),
            borderWidth (px 1),
            borderStyle solid,
            borderColor (hex "#d9dadb")
        ]][
            -- header
            div [id "proteoformppi_table_header", css [
                displayFlex,
                flexDirection row,
                backgroundColor (hex "#eff1f2"),
                paddingTop (px 5),
                paddingBottom (px 5),
                fontWeight bold,
                Css.height (px 100)
            ]] []
        
        ]

    ]