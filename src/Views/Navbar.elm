module Views.Navbar exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Msgs exposing (..)
import Colors exposing (..)
import Styles.Home exposing (..)
import Ionicon exposing (..)
import Ionicon.Ios exposing (..)
import Views.AdvancedSearch exposing (..)
import Model exposing (..)

navBarItemCSS: List Style
navBarItemCSS = 
        [color (hex "#FFFFFF"),
         textDecoration none,
         paddingLeft (px 20),
         paddingRight (px 20),
         fontSize (px 13)
        ]

view: Model.Navbar -> Html Msg
view navbar = 
        div [
            id "nav_bar_container",
            css [
                position sticky,
                Css.property "top" "0px",
                boxShadow4 (px 0) (px 4) (px 8) (hex "#83838354")
            ]
        ][
            div [
                    id "nav_bar",
                    css [
                        Css.height (px 40),
                        backgroundColor Colors.navigationBackground,
                        displayFlex,
                        flexDirection row,
                        alignItems center,
                        fontSize (Css.em 1)
                    ]
                ][
                    div [
                        id "nav_home",
                        css navigationItem,
                        onClick (ChangeLocation "/")
                    ][
                        text "iPTMnet"
                    ],
                    div [
                        id "seperator",
                        css Styles.Home.navigationSeperator
                    ][],
                    div [
                        id "nav_browse",
                        css navigationItem
                    ][
                        text "Browse"
                    ],
                    div [
                        id "seperator",
                        css [
                            Css.property "height" "50%",
                            Css.width (px 1),
                            backgroundColor Colors.navigationSeperator
                        ]
                    ][],
                    div [
                        id "nav_stats",
                        css navigationItem
                    ][
                        text "Statistics"
                    ],
                    div [
                        id "seperator",
                        css Styles.Home.navigationSeperator
                    ][],
                    div [
                        id "nav_help",
                        css navigationItem
                    ][
                        text "Help"
                    ],
                    div [
                        id "seperator",
                        css Styles.Home.navigationSeperator
                    ][],
                    div [
                        id "nav_license",
                        css navigationItem
                    ][
                        text "License"
                    ],
                    div [
                        id "seperator",
                        css Styles.Home.navigationSeperator
                    ][],
                    div [
                        id "nav_citation",
                        css navigationItem
                    ][
                        text "Citation"
                    ],
                    div [
                        id "seperator",
                        css Styles.Home.navigationSeperator
                    ][],
                    div [
                        id "nav_about",
                        css navigationItem
                    ][
                        text "About"
                    ],
                    div [
                        id "seperator",
                        css Styles.Home.navigationSeperator
                    ][],
                    
                    div [
                        id "search_container",
                        css [
                            marginLeft auto,
                            marginRight (px 20),
                            displayFlex,
                            flexDirection row,
                            alignItems center
                        ]
                    ][
                        div 
                    [
                        id "div_search_term_type",
                        css [
                            displayFlex,
                            flexDirection row,
                            alignItems center,
                            Css.property "height" "2.5em",
                            Css.width (px 164),
                            paddingRight (px 5),
                            backgroundColor Colors.selectBackground,
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
                                textAlign center,
                                textAlignLast center,
                                focus [
                                    outline none
                                ],
                                hover [
                                    cursor pointer
                                ]
                            ]][
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
                    ],
                        input [
                            id "input_search_navbar",
                            css [
                                    fontSize (px 13),
                                    marginRight (px 10),
                                    paddingTop (px 5),
                                    paddingBottom (px 5),
                                    paddingLeft (px 10),
                                    paddingRight (px 10),
                                    borderStyle none
                                ],
                            placeholder "Search"
                        ][],

                        div [
                            id "seperator",
                            css Styles.Home.navigationSeperator
                        ][],
                        div [
                            id "nav_search_icon",
                            css [ 
                                Css.width (px 50), 
                                Css.property "height" "40px",
                                displayFlex,
                                flexDirection column,
                                alignItems center,
                                hover [
                                    cursor pointer,
                                    backgroundColor Colors.selectBackgroundHover
                                ]
                            ]
                        ][
                            div [
                                css [
                                    margin auto
                                ]
                            ] [
                                Ionicon.Ios.searchStrong 25 Colors.dropDownIconColor |> Html.Styled.fromUnstyled
                            ]
                        ],

                        div [
                            id "nav_gear_icon",
                            css [ 
                                Css.width (px 50), 
                                Css.height (px 40),
                                displayFlex,
                                flexDirection column,
                                alignItems center,
                                hover [
                                    cursor pointer,
                                    backgroundColor Colors.selectBackgroundHover
                                ]
                            ],
                            Html.Styled.Events.onClick (Msgs.OnAdvancedSearchVisibilityChange (not navbar.advancedSearchVisibility))
                        ][
                            div [
                                css [
                                    margin auto
                                ]
                            ] [
                                Ionicon.Ios.gear 25 Colors.dropDownIconColor |> Html.Styled.fromUnstyled
                            ]
                        ]

                    ]

                ],
            div [
                id "advanced_search_container",
                css [
                    backgroundColor Colors.advancedSearchExpandBackground
                ]
            ][
                Views.AdvancedSearch.view navbar.searchOptions navbar.isSearchVisible True
            ]
            
        ]