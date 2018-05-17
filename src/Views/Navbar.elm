module Views.Navbar exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)

navBarItemCSS: List Style
navBarItemCSS = 
        [color (hex "#FFFFFF"),
         textDecoration none,
         paddingLeft (px 20),
         paddingRight (px 20),
         fontSize (px 13)
        ]

view: Html Msg
view = 
    div [id "nav_bar", css [position sticky, Css.property "top" "0px"]] [
                div [
                    css [
                        displayFlex,
                        flexDirection row,
                        Css.property "width" "100%",
                        backgroundColor (hex "#71A1CF"),
                        paddingTop (px 5),
                        paddingBottom (px 5),
                        alignItems center
                    ]
                ] [
                    a [href "/", css [color (hex "#FFFFFF"),
                                      textDecoration none,
                                      paddingLeft (px 50),
                                      paddingRight (px 50)
                                      ]][text "iPTMnet"],

                    a [href "/", css navBarItemCSS][text "Home"],
                    a [href "/", css navBarItemCSS][text "Browse"],
                    a [href "/", css navBarItemCSS][text "Statistics"],
                    a [href "/", css navBarItemCSS][text "Project Info"],
                    a [href "/", css navBarItemCSS][text "Help"],
                    a [href "/", css navBarItemCSS][text "Result"],

                    div [css [marginLeft auto, display inline]] [
                        select [css[Css.width (px 80),
                                    fontSize (px 13),
                                    marginRight (px 10)
                                ]][
                                option [value "all"] [text "All"],
                                option [value "uniprot"] [text "Uniprot AC/ID"],
                                option [value "name"] [text "Protein/Gene Name"],
                                option [value "pmid"] [text "PMID"]
                            ],
                        input [css [fontSize (px 13),marginRight (px 10)], placeholder "Search"] []
                    ]

                ]
            ]