module Views.Substrate exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)

-- returns the substrate view
view: Html Msg 
view =
    div [id "substrates", css [marginTop (px 20)] ][
        h4 [css [
            fontSize (px 20),
            fontWeight normal
        ]] [text "{0} ({1}) as Substrate"]
    ]