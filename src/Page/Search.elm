module Page.Search exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)
import Views.Navbar
import Ionicon.Ios
import Colors
import Views.Footer exposing (..)

view : Model -> Html Msg
view model =  
            div [
                id "page",
                css [
                    displayFlex,
                    flexDirection column,
                    Css.property "min-height" "100%"
                ]] [  

                Views.Navbar.view model,

                div [id "search_table", css [
                    displayFlex,
                    flexDirection column,
                    fontSize (Css.em 0.9)
                ]][
                    -- header
                    div [id "search_table_header", css [
                        displayFlex,
                        flexDirection row,
                        backgroundColor (hex "#eff1f2"),
                        paddingTop (px 10),
                        paddingBottom (px 10),
                        fontWeight bold,
                        alignItems center
                    ]] [
                        div [css [flex (num 2),
                                marginLeft (px 5),
                                marginRight (px 20),
                                paddingLeft (px 5),
                                displayFlex,
                                flexDirection row,
                                alignItems center
                            ]]
                        [
                            input [type_ "checkbox", css[marginLeft (px 5), marginRight (px 15)]][],
                            text "iPTM ID"
                        ],
                        div [css [flex (num 3),
                                marginRight (px 10)         
                                ]] 
                        [
                            text "Protein Name"
                        ],
                        div [css [flex (num 1.5),
                            marginRight (px 20)         
                            ]]
                        [
                            text "Gene Name"
                        ],
                        div [css [flex (num 1.5),
                                marginRight (px 20)
                                ]]
                        [
                            text "Organism"
                        ],
                        div [css [flex (num 1),
                                marginRight (px 20)
                                ]]
                        [
                            text "Substrate Role"
                        ],
                        div [css [flex (num 1),
                                marginRight (px 20)
                                ]]
                        [
                            text "Enzyme Role"
                        ],
                        div [css [flex (num 1.5),
                                marginRight (px 20)
                                ]]
                        [
                            text "PTM-dependent PPI"
                        ],
                        div [css [flex (num 0.5),
                                marginRight (px 20)
                                ]]
                        [
                            text "Sites"
                        ],
                        div [css [flex (num 0.5),
                                marginRight (px 20)
                                ]]
                        [
                            text "Isoforms"
                        ]                  


                    ],

                    -- rows
                    div [] (List.map searchResultRow (Debug.log "search_results" model.searchPage.searchData.data))               

                ],

                div[
                    id "filler",
                    css [
                        flexGrow (num 1)
                    ]]
                [],

                Views.Footer.view        

        ]

searchResultRow: (SearchResult Organism) -> Html Msg
searchResultRow searchResult = 
    div [id "search_table_header", css [
                    displayFlex,
                    flexDirection row,
                    paddingTop (px 10),
                    paddingBottom (px 10),
                    hover [
                        backgroundColor (hex "#0000000D")
                    ]
                ]] [
                    div [css [flex (num 2),
                            marginLeft (px 5),
                            marginRight (px 20),
                            paddingLeft (px 5),
                            displayFlex,
                            flexDirection row,
                            alignItems center
                        ]]
                    [
                        input [type_ "checkbox", css[marginLeft (px 5), marginRight (px 15)]][],
                        a [href (interpolate "/entry/{0}" [searchResult.iptm_id] )] [text (interpolate "iPTM:{0}" [searchResult.iptm_id])]
                    ],
                    div [css [flex (num 3),
                            marginRight (px 10)         
                            ]] 
                    [
                        text searchResult.protein_name
                    ],
                    div [css [flex (num 1.5),
                        marginRight (px 20)         
                        ]]
                    [
                        span [] [text (interpolate "Name: {0} " [searchResult.gene_name]),
                        br[][],
                        text (interpolate "Synonyms: {0} " [String.join "," searchResult.synonyms])] 
                    ],
                    div [css [flex (num 1.5),
                            marginRight (px 20)
                            ]]
                    [
                        text ( interpolate "{0} ({1})" [searchResult.organism.common_name,searchResult.organism.species] )
                    ],
                    div [css [flex (num 1),
                            marginRight (px 20),
                            displayFlex,
                            flexDirection row,
                            alignItems center
                            ]]
                    [
                        viewSubstrateRole searchResult.substrate_role searchResult.substrate_num
                    ],
                    div [css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        viewEnzymeRole searchResult.enzyme_num searchResult.enzyme_role
                    ],
                    div [css [flex (num 1.5),
                            marginRight (px 20)
                        ]]
                    [
                        viewPTMDepPPIRole searchResult.ptm_dependent_ppi_role searchResult.ptm_dependent_ppi_num                        
                    ],
                    div [css [flex (num 0.5),
                            marginRight (px 20)
                            ]]
                    [
                        text (toString searchResult.sites)
                    ],
                    div [css [flex (num 0.5),
                            marginRight (px 20)
                            ]]
                    [
                        text (toString searchResult.isoforms)
                    ]                  


                ]

viewSubstrateRole : Bool -> Int -> Html Msg
viewSubstrateRole substrate_role substrate_num =
            case substrate_role of 
            True ->
                div [
                    css [
                            displayFlex,
                            flexDirection row,
                            alignItems center
                        ] 
                        ][
                        div [
                            id "substrate_role_icon_container"
                        ] [
                            div [
                                id "substrate_role_icon"
                            ][
                                Ionicon.Ios.checkmarkEmpty 30 Colors.checkMark |> Html.Styled.fromUnstyled
                            ]
                        ],
                        div [][
                            text (interpolate "{0} enzymes" [toString substrate_num])
                        ]
                ]
            False ->
                div [
                    css [
                            displayFlex,
                            flexDirection column,
                            alignItems center
                        ] 
                        ][
                        div [
                            id "substrate_role_icon_container"
                        ] [
                            div [
                                id "substrate_role_icon"
                            ][
                                Ionicon.Ios.closeEmpty 30 Colors.checkMark |> Html.Styled.fromUnstyled
                            ]
                        ]
                ]

viewEnzymeRole : Int -> Bool -> Html Msg
viewEnzymeRole enzyme_num enzyme_role =
            case enzyme_role of 
            True ->
                div [
                    css [
                            displayFlex,
                            flexDirection row,
                            alignItems center
                        ] 
                        ][
                        div [
                            id "enzyme_role_icon_container"
                        ] [
                            div [
                                id "enzyme_role_icon"
                            ][
                                Ionicon.Ios.checkmarkEmpty 30 Colors.checkMark |> Html.Styled.fromUnstyled
                            ]
                        ],
                        div [][
                            text (interpolate "{0} enzymes" [toString enzyme_num])
                        ]
                ]
            False ->
                div [
                    css [
                            displayFlex,
                            flexDirection column,
                            alignItems center
                        ] 
                        ][
                        div [
                            id "enzyme_role_icon_container"
                        ] [
                            div [
                                id "enzyme_role_icon"
                            ][
                                Ionicon.Ios.closeEmpty 30 Colors.checkMark |> Html.Styled.fromUnstyled
                            ]
                        ]
                ]

viewPTMDepPPIRole : Bool -> Int -> Html Msg
viewPTMDepPPIRole ptm_dep_ppi_role ptm_dep_ppi_num =
            case ptm_dep_ppi_role of 
            True ->
                div [
                    css [
                            displayFlex,
                            flexDirection row,
                            alignItems center
                        ] 
                        ][
                        div [
                            id "ptm_dep_ppi_role_icon_container"
                        ] [
                            div [
                                id "ptm_dep_ppi_role_icon"
                            ][
                                Ionicon.Ios.checkmarkEmpty 30 Colors.checkMark |> Html.Styled.fromUnstyled
                            ]
                        ],
                        div [][
                            text (interpolate "{0} interactants" [toString ptm_dep_ppi_num])
                        ]
                ]
            False ->
                div [
                    css [
                            displayFlex,
                            flexDirection column,
                            alignItems center
                        ] 
                        ][
                        div [
                            id "enzyme_role_icon_container"
                        ] [
                            div [
                                id "enzyme_role_icon"
                            ][
                                Ionicon.Ios.closeEmpty 30 Colors.checkMark |> Html.Styled.fromUnstyled
                            ]
                        ]
                ]

decodeResponse: WebData (List (SearchResult Organism)) -> SearchData 
decodeResponse response = 
    case response of
        RemoteData.NotAsked ->
            {
                status = NotAsked,
                error = "",
                data = []
            }

        RemoteData.Loading ->
            {
                status = Loading,
                error = "",
                data = []
            }

        RemoteData.Success searchResultList ->
            {
                status = Success,
                error = "",
                data = searchResultList
            }

        RemoteData.Failure error ->
            {
                status = Error,
                error = (toString error),
                data = []
            }