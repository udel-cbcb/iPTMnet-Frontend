module Views.Footer exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Colors

view : Html Msg
view = 
            div [id "footer", css [
                alignSelf stretch,
                backgroundColor (hex "#f2f2f2"),
                displayFlex,
                flexDirection row,
                alignItems center,
                color Colors.footerTextColor,
                padding (px 10)
            ]] [
                div [
                     id "div_ud",
                     css [
                         displayFlex,
                         flexDirection column,
                         alignItems center,
                         margin auto,
                         marginRight (px 20),
                         marginTop (px 10),
                         marginBottom (px 10)
                     ]
                 ][
                    a [
                        href "http://bioinformatics.udel.edu/",
                        Html.Styled.Attributes.target "_blank",
                        css [
                            link [
                                color Colors.footerTextColor
                            ],
                            visited [
                                color Colors.footerTextColor
                            ]
                        ]
                    ][
                        text "University of Delaware"
                    ],
                    div [
                        css [marginTop (px 5)]
                    ] [
                        text "15 Innovation Way, Suite 205"
                    ],
                    div [
                        css [marginTop (px 5)]
                    ][
                        text "Newark, DE 19711, USA"
                    ]
                 ],
                 div [
                     id "div_georgetown",
                     css [
                         displayFlex,
                         flexDirection column,
                         alignItems center,
                         margin auto,
                         marginLeft (px 20),
                         marginTop (px 10),
                         marginBottom (px 10)
                     ]
                 ][
                    a [
                        href "http://gumc.georgetown.edu/",
                        Html.Styled.Attributes.target "_blank",
                        css [
                            link [
                                color Colors.footerTextColor
                            ],
                            visited [
                                color Colors.footerTextColor
                            ]
                        ]
                    ][
                        text "Georgetown University Medical Center"
                    ],
                    div [
                        css [marginTop (px 5)]
                    ] [
                        text "3300 Whitehaven Street, NW, Suite 1200"
                    ],
                    div [
                        css [marginTop (px 5)]
                    ][
                        text "Washington, DC 20007, USA"
                    ]
                 ]
            ]