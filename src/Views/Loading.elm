module Views.Loading exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Colors
import Ionicon

view: Html Msg 
view = 
    div [
        id "div_loading_view_container",
        css [
            displayFlex,
            flexDirection row,
            alignSelf center,
            alignItems center
        ]
    ] [
        div [
            id "div_loading_view",
            css [
                displayFlex,
                flexDirection column,
                alignItems center
            ]
        ][
            div [
                id "loading_icon",
                        css [
                            Css.width (px 50),
                            Css.height (px 50),
                            Css.property "-webkit-animation" "spin 0.8s linear infinite",
                            Css.property "-moz-animation" "spin 0.8s linear infinite"
                        ]
                ][
                    div [
                            css [
                                margin auto
                            ]
                        ] [
                            Ionicon.loadC 50 Colors.emptyIcon |> Html.Styled.fromUnstyled
                    ]
            ],
            div [
                id "loading_label",
                css [
                    color Colors.emptyText,
                    fontSize (Css.em 1),
                    Css.fontWeight bold,
                    marginTop (px 10)
                ]
            ][
                text "Loading results.."
            ]
        ]
    ]