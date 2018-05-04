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
        ]] [text "Interactive Sequence View"]
    ]