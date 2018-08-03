module Page.Home exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Html.Styled.Events exposing (..)
import Json.Decode as Decode
import Colors exposing (..)
import Views.Navbar
import Ionicon
import Views.AdvancedSearch exposing (..)
import Views.Footer exposing (..)
import String.Extra
import Model.AppModel exposing (..)
import Misc exposing (..)
import Model.Misc exposing (..)

{-|
When clicking a link we want to prevent the default browser behaviour which is to load a new page.
So we use `onWithOptions` instead of `onClick`.
-}
onLinkClick : msg -> Attribute msg
onLinkClick message =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed message)


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
                id "search_section",
                css [
                    displayFlex,
                    flexDirection column,
                    alignItems center,
                    paddingTop (px 100),
                    paddingBottom (px 100)
                ]
            ] [
                div [
                    id "dv_title",
                    css [
                        fontSize (Css.em 5),
                        marginTop (Css.em 0.1)
                    ]
                ][
                    text "iPTMnet"
                ],

                div [
                    id "div_grants",
                    css [
                        marginTop (px 5),
                        displayFlex,
                        flexDirection row,
                        alignItems center,
                        fontSize (Css.em 1)
                    ]
                ] [
                    -- label
                    div [
                        id "div_nsf-label"
                    ][
                        text "NSF Grants : "
                    ],
                    a [
                        href "#",
                        css[
                            marginLeft (px 10),
                            fontSize (Css.em 0.85),
                            link [
                                color Colors.miscText
                            ],
                            visited [
                                color Colors.miscText
                            ]
                        ]]
                        [
                            text "ABI-1062520"
                    ],

                    a [
                        href "http://nsf.gov/awardsearch/showAward.do?AwardNumber=1062520",
                        Html.Styled.Attributes.target "blank",
                        css[
                            marginLeft (px 10),
                            fontSize (Css.em 0.85),
                            link [
                                color Colors.miscText
                            ],
                            visited [
                                color Colors.miscText
                            ]
                        ]]
                        [
                            text "U01GM120953"
                    ]

                ],

                div [
                    id "dv_search",
                    css [
                        displayFlex,
                        flexDirection row,
                        alignItems center,
                        Css.height (px 50),
                        marginTop (px 60),
                        boxShadow4 (px 0) (px 3) (px 10) (hex "#83838354"),
                        focus [
                            boxShadow4 (px 4) (px 6) (px 12) (hex "#83838354")
                        ],
                        hover [
                            boxShadow4 (px 4) (px 6) (px 12) (hex "#83838354")
                        ]
                    ]
                ][
                   div [
                        id "div_advanced_search_icon",
                        css [
                            Css.property "height" "105%",
                            Css.property "width" "50px",
                            backgroundColor Colors.selectBackground,
                            displayFlex,
                            flexDirection column,
                            alignItems center,
                            hover [
                                cursor pointer,
                                backgroundColor Colors.selectBackgroundHover
                            ]
                        ],
                        onClick (Msgs.OnAdvancedSearchVisibilityChange (not model.homePage.advancedSearchVisibility))
                    ]
                    [
                        div [
                            css [
                                margin auto
                            ]
                        ][
                            Ionicon.gearA 20 Colors.dropDownIconColor |> Html.Styled.fromUnstyled
                        ]
                    ],

                   input [
                        id "input_search_term",
                        Html.Styled.Events.onInput Msgs.OnHomePageSearchInputChange,
                        onKeyDown Msgs.OnHomePageSearchKeyDown,
                        css [
                            Css.width (px 400),
                            Css.property "height" "98%",
                            backgroundColor Colors.searchBoxColor,
                            paddingLeft (px 30),
                            paddingRight (px 30),
                            borderStyle none,
                            fontSize (px 16),
                            focus [
                                outline none
                            ]
                        ],
                        placeholder "Search for protein in iPTMnet database"
                    ][

                    ],

                    div 
                    [
                        id "div_search_term_type",
                        css [
                            displayFlex,
                            flexDirection row,
                            alignItems center,
                            Css.property "height" "105%",
                            Css.width (px 164),
                            backgroundColor Colors.selectBackground,
                            boxShadow4 (px 0) (px 3) (px 5) (hex "#83838354"),
                            hover [
                                    cursor pointer,
                                    backgroundColor Colors.selectBackgroundHover
                            ]
                        ]
                    ]
                    [
                        select [
                            id "select_search_term_type",
                            css[
                                borderStyle none,
                                backgroundColor Colors.transparent,
                                color selectText,
                                fontSize (px 14),
                                paddingLeft (px 10),
                                paddingRight (px 10),
                                Css.property "height" "100%",
                                Css.property "-webkit-appearance" "none",
                                Css.property "-moz-appearance" "none",
                                margin (px 0),
                                focus [
                                    outline none
                                ],
                                hover [
                                    cursor pointer
                                ] 
                            ]
                            ][
                                option [value "all",css[color Colors.infoText]][text "All"],
                                option [value "uniprot",css[color Colors.infoText]] [text "Uniprot AC/ID"],
                                option [value "name",css[color Colors.infoText]] [text "Protein/Gene Name"],
                                option [value "pmid",css[color Colors.infoText]] [text "PMID"]
                        ],
                        div [
                            id "div_dropdown_icon",
                            css [
                                paddingLeft (px 2),
                                paddingRight (px 2)
                            ]
                        ] [
                            Ionicon.arrowDownB 12 Colors.dropDownIconColor |> Html.Styled.fromUnstyled
                        ]
                    ]
                ],

                -- advanced search
                Views.AdvancedSearch.view model.homePage.searchOptions model.homePage.advancedSearchVisibility False,

                -- misc
                    div [
                        id "div_misc",
                        css [
                            displayFlex,
                            flexDirection row,
                            alignSelf stretch,
                            marginTop (px 25),
                            fontSize (Css.em 0.9),
                            paddingLeft (px 10),
                            color Colors.miscText
                        ]
                    ] [
                        div [
                            css [
                                color Colors.miscText,
                                paddingRight (px 20),
                                textDecoration underline,
                                hover [
                                    cursor pointer
                                ]
                            ],
                            onClick (Msgs.OnAdvancedSearchVisibilityChange (not model.homePage.advancedSearchVisibility))
                        ][
                            text "Advanced search"
                        ],
                        a [
                            href "/entry/Q15796",
                            Html.Styled.Attributes.target "_blank",
                            css[
                                marginRight (px 20),
                                link [
                                    color Colors.miscText
                                ],
                                visited [
                                    color Colors.miscText
                                ]
                            ]]
                            [
                                text "Sample Report"
                        ],
                        a [
                            href (pathname ++ "batch"),
                            css[
                                marginLeft auto,
                                marginRight (px 20),
                                link [
                                    color Colors.miscText
                                ],
                                visited [
                                    color Colors.miscText
                                ]
                            ]]
                            [
                                text "Batch retrieval (New)"
                        ]
                    ],

                -- search button
                    div [
                        id "div_buttons",
                        css [
                            displayFlex,
                            flexDirection row,
                            alignItems center,
                            marginTop (px 70)
                        ]
                    ][
                        button [
                            id "btn_search",
                            onClick ( case (String.Extra.clean model.homePage.searchOptions.searchTerm) == "" of 
                                      False -> ChangeLocation (buildSearchUrl model.homePage.searchOptions)
                                      True -> ChangeLocation "/"),
                            css [
                                backgroundColor Colors.searchButton,
                                Css.width (px 100),
                                fontSize (Css.em 1),
                                paddingTop (px 10),
                                paddingBottom (px 10),
                                borderStyle none,
                                borderRadius (px 25),
                                color Colors.searchButtonText,
                                focus [
                                    outline none
                                ],
                                hover [
                                    cursor pointer,
                                    backgroundColor Colors.searchButtonHover
                                ]
                            ]                            
                        ][
                            text "Search"
                        ],

                        button [
                            id "btn_reset",
                            css [
                                backgroundColor Colors.transparent,
                                Css.width (px 100),
                                fontSize (Css.em 1),
                                paddingTop (px 10),
                                paddingBottom (px 10),
                                marginLeft (px 40),
                                borderStyle solid,
                                borderColor Colors.searchButton,
                                borderRadius (px 25),
                                borderWidth (px 1),
                                color Colors.resetButtonText,
                                focus [
                                    outline none
                                ],
                                hover [
                                    cursor pointer,
                                    color Colors.resetButtonTextHover,
                                    backgroundColor Colors.resetButtonHover
                                ]
                            ]                            
                        ][
                            text "Reset"
                        ]

                    ],

                    -- info
                    div [
                        id "div_info",
                        css [
                            displayFlex,
                            Css.width (px 680),
                            marginTop (px 30),
                            flexDirection column,
                            alignItems center,
                            fontSize (Css.em 1),
                            color Colors.infoText
                        ]
                    ][
                        p [] [text "iPTMnet is a bioinformatics resource for integrated understanding of protein post-translational modifications (PTMs) in systems biology context."],
                        p [] [text "It connects multiple disparate bioinformatics tools and systems of text mining, data mining, analysis and visualization tools, and databases and ontologies into an integrated cross-cutting research resource to address the knowledge gaps in exploring and discovering PTM networks."]
                    ]

            ],

            div[
                id "filler",css [alignSelf stretch ]]
            []

            ],

            Views.Footer.view 

    ]