module Page.License exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Views.Footer
import Colors
import Views.Navbar
import Model exposing (..)

view : Model -> Html Msg
view model = 

            div [id "page",css [
            Css.property "min-height" "100%",
            displayFlex,
            flexDirection column,
            alignItems center,
            flex (num 1),
            backgroundColor Colors.pageBackground
            ]
        ] [

        div [id "header", css [
            displayFlex,
            flexDirection column,
            alignSelf stretch
            ]] [
                Views.Navbar.view model.navbar
            ],
        
        div [id "body", css [
            displayFlex,
            flexDirection column,
            alignItems center,
            flexGrow (num 1),
            paddingTop (px 20),
            overflow auto            
            ]] [   
                div [
                    css [
                        displayFlex,
                        flexDirection column,
                        paddingLeft (px 20),
                        paddingRight (px 20)
                    ]
                ] [
                    div [css [
                        fontSize (Css.em 1.5)
                    ]][
                        text "License & disclaimer"
                    ],
                    div [
                        css [
                            fontSize (Css.em 1.25),
                            marginTop (px 20)
                        ]
                    ][
                        text "License"
                    ],
                    p [][
                        text """The iPTMnet data are freely searchable and browsable from the website. However, the iPTMnet database is protected under the CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike 4.0 International) license. 
                        This means that you are free to copy and redistribute the material in any medium or format as long as you comply with the following terms:"""
                    ],
                    ul [][
                        li [][
                            text "You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use."
                        ],
                        li [][
                            text "You may not use the material for commercial purposes."
                        ],
                        li [][
                            text "If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. "
                        ]
                    ],
                    div [
                        css [
                            fontSize (Css.em 1.25),
                            marginTop (px 20)
                        ]
                    ][
                        text "Disclaimer"
                    ],
                    p[][
                        text """We make no warranties regarding the correctness of the data, and disclaim liability for damages resulting from its use. We cannot provide unrestricted permission regarding the use of the data, as some data may be covered by patents or other rights.
                        Any medical or genetic information is provided for research, educational and informational purposes only. It is not in any way intended to be used as a substitute for professional medical advice, diagnosis, treatment or care."""
                    ],
                    div [
                        css [
                            fontSize (Css.em 1.25),
                            marginTop (px 20)
                        ]
                    ][
                        text "Privacy policy"
                    ],
                    p[][
                        text "Data submitted through this website will never be shared with any other third parties. We reserve the right to use information about visitors (IP addresses), date/time visited, page visited, referring website, etc. for site usage statistics and to improve our services."
                    ]
                ]
            ],

            div[
                id "filler",css [alignSelf stretch ]]
            [],

            Views.Footer.view 

    ]