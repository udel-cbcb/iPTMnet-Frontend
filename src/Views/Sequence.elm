module Views.Sequence exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Json.Encode

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
            embed [
                  css [
                      borderWidth (px 0),
                      alignSelf stretch
                  ],
                  Html.Styled.Attributes.src "https://research.bioinformatics.udel.edu/iptmnet/visual/msa/view/entry/Q15796/"
                  
                ][

                ]        
        ]

    ]