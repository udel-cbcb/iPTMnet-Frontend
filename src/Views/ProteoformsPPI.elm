module Views.PTMDependentPPI exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)

-- returns the substrate view
view: Html Msg 
view = 
    div [id "proteoforms_ppi", css [marginTop (px 20)] ][
        h4 [css [
            fontSize (px 20),
            fontWeight normal
        ]] [text "Proteoforms PPI"]
    ]