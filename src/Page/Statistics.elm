module Page.Statistics exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Views.Footer
import Colors
import Views.Navbar
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)
import Model.AppModel exposing (..)
import Model.Statistics as Statistics exposing (..)
import Model.Misc exposing (..)

overViewCellStyle : (List Style)
overViewCellStyle =
    [
        paddingTop (px 15)
    ]    

view : Model -> Html Msg
view model = 

        div [id "page",css [
            Css.property "min-height" "100%",
            displayFlex,
            flexDirection column,
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
            flexGrow (num 1),
            paddingTop (px 20),
            marginLeft (px 80),
            marginRight (px 80),
            overflow auto            
            ]] [   

                -- info
                div [
                    css [
                        displayFlex,
                        flexDirection row,
                        alignItems baseline
                    ]
                ][
                    div [
                        css [
                            fontSize (Css.em 1.8)
                        ]
                    ][
                        text (interpolate "iPTMnet v{0}" [model.statisticsPage.statisticsData.data.release])
                    ],

                    div [
                        css [
                            fontStyle italic,
                            marginLeft (px 10),
                            fontSize (Css.em 0.95)
                        ]
                    ][
                        text (interpolate "Updated on {0}" [model.statisticsPage.statisticsData.data.date])
                    ]
                ],

                -- overview
                div [
                    css [
                        fontSize (Css.em 1.5),
                        marginTop (px 30)
                    ]
                ][
                    text "Overview"
                ],

                
                Html.Styled.table [
                    id "table_overview",
                    css [
                        marginTop (px 20),
                        borderCollapse collapse,
                        Css.property "width" "100%"
                    ]
                ][
                    -- header
                    tr [
                        css [
                            fontSize (Css.em 0.90),
                            fontWeight bold,
                            marginTop (px 20)
                        ]
                    ][
                        td [][
                            text "Substrates (protein)"
                        ],

                        td [
                            css [
                            ]
                        ][
                            text "Substrates (proteoforms)"
                        ],

                        td [
                            css [
                            ]
                        ][
                            text "Sites"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzymes"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzyme-substrate pairs"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzyme-substrate-site"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "PTM-dependent PPI"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "PMIDs"
                        ]

                    ],
                    
                    -- values
                    tr [
                    ][
                        td [
                            id "substrate_protein",
                            css overViewCellStyle
                        ][
                            text (toString model.statisticsPage.statisticsData.data.overview.substrates_protein)
                        ],

                        td [
                            id "substrate_proteoforms",
                            css overViewCellStyle
                        ][
                            text (toString model.statisticsPage.statisticsData.data.overview.substrates_proteoform)
                        ],

                        td [
                            id "sites",
                            css overViewCellStyle
                        ][
                            text (toString model.statisticsPage.statisticsData.data.overview.sites)
                        ],

                        td [
                            id "enzymes",
                            css overViewCellStyle
                        ][
                            text (toString model.statisticsPage.statisticsData.data.overview.enzymes)
                        ],

                        td [
                            id "enzyme-substrate-pairs",
                            css overViewCellStyle
                        ][
                            text (toString model.statisticsPage.statisticsData.data.overview.enzyme_substrate_pairs)
                        ],

                        td [
                            id "enzyme-substrate-site",
                            css overViewCellStyle
                        ][
                            text (toString model.statisticsPage.statisticsData.data.overview.enzyme_substrate_site)
                        ],

                        td [
                            id "ptm_dep_ppi",
                            css overViewCellStyle
                        ][
                            text (toString model.statisticsPage.statisticsData.data.overview.ptm_dependent_ppi)
                        ],

                        td [
                            id "pmid",
                            css overViewCellStyle
                        ][
                            text (toString model.statisticsPage.statisticsData.data.overview.pmids)
                        ]
                    ]
                                
                ],

                -- Events
                div [
                    css [
                        fontSize (Css.em 1.5),
                        marginTop (px 60)
                    ]
                ][
                    text "Events"
                ],
                
                Html.Styled.table [
                    id "table_events",
                    css [
                        marginTop (px 20),
                        borderCollapse collapse,
                        Css.property "width" "100%"
                    ]
                ][
                    -- header
                    tr [
                        css [
                            fontSize (Css.em 0.90),
                            fontWeight bold,
                            marginTop (px 20)
                        ]
                    ][
                        td [][
                            text "Event type"
                        ],

                        td [
                            css [
                            ]
                        ][
                            text "Substrates (protein)"
                        ],

                        td [
                            css [
                            ]
                        ][
                            text "Substrates (proteoforms)"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Sites"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzymes"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzyme-substrate pairs"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzyme-substrate-site"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "PTM-dependent PPI"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "PMIDs"
                        ]

                    ]       
                ],

                -- top organisms
                div [
                    css [
                        fontSize (Css.em 1.5),
                        marginTop (px 60)
                    ]
                ][
                    text "Top organisms"
                ],
                
                Html.Styled.table [
                    id "table_organisms",
                    css [
                        marginTop (px 20),
                        borderCollapse collapse,
                        Css.property "width" "100%"
                    ]
                ][
                    -- header
                    tr [
                        css [
                            fontSize (Css.em 0.90),
                            fontWeight bold,
                            marginTop (px 20)
                        ]
                    ][
                        td [][
                            text "Name"
                        ],

                        td [
                            css [
                            ]
                        ][
                            text "Substrates (protein)"
                        ],

                        td [
                            css [
                            ]
                        ][
                            text "Substrates (proteoforms)"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Sites"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzymes"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzyme-substrate pairs"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzyme-substrate-site"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "PTM-dependent PPI"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "PMIDs"
                        ]

                    ]       
                ],

                -- source
                div [
                    css [
                        fontSize (Css.em 1.5),
                        marginTop (px 60)
                    ]
                ][
                    text "Source"
                ],
                
                Html.Styled.table [
                    id "table_source",
                    css [
                        marginTop (px 20),
                        borderCollapse collapse,
                        Css.property "width" "100%"
                    ]
                ][
                    -- header
                    tr [
                        css [
                            fontSize (Css.em 0.90),
                            fontWeight bold,
                            marginTop (px 20)
                        ]
                    ][
                        td [][
                            text "Name"
                        ],

                        td [
                            css [
                            ]
                        ][
                            text "Substrates (protein)"
                        ],

                        td [
                            css [
                            ]
                        ][
                            text "Substrates (proteoforms)"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Sites"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzymes"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzyme-substrate pairs"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "Enzyme-substrate-site"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "PTM-dependent PPI"
                        ],

                        td [
                            css [
                                flexGrow (num 1)
                            ]
                        ][
                            text "PMIDs"
                        ]

                    ]       
                ]

            ],

            div[
                id "filler",css [alignSelf stretch ]]
            [],

            Views.Footer.view 

    ]

decodeResponse: WebData (Statistics) -> StatisticsData 
decodeResponse response = 
    case response of
        RemoteData.NotAsked ->
            {
                status = NotAsked,
                error = "",
                data = Statistics.initialModel
            }

        RemoteData.Loading ->
            {
                status = Loading,
                error = "",
                data = Statistics.initialModel
            }

        RemoteData.Success statistics ->
            {
                status = Success,
                error = "",
                data = statistics
            }

        RemoteData.Failure error ->
            {
                status = Error,
                error = (toString error),
                data = Statistics.initialModel
            }