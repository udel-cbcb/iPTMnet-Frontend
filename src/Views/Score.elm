module Views.Score exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Colors
import Ionicon.Ios


view : Int -> Html Msg
view score =
    div [
        id "div_score",
        css [
            displayFlex,
            flexDirection row,
            alignItems center
        ]
    ][
            div [
                css [
                    paddingRight (px 5)
                    ]
                ] [
                    renderStar 1 score 
            ],

            div [
                css [
                    paddingRight (px 5)
                    ]
                ] [
                    renderStar 2 score 
            ],

            div [
                css [
                    paddingRight (px 5)
                    ]
                ] [
                    renderStar 3 score
            ],

            div [
                css [
                    ]
                ] [
                    renderStar 4 score
            ]

    ]

renderStar : Int -> Int -> Html Msg
renderStar index score =
    case index <= score of
    True -> Ionicon.Ios.star 16 Colors.score |> Html.Styled.fromUnstyled
    False -> Ionicon.Ios.starOutline 16 Colors.score |> Html.Styled.fromUnstyled


