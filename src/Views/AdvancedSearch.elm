module Views.AdvancedSearch exposing (..)
import Model exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import Colors exposing (..)
import Styles.Home exposing (..)

view : Model -> Bool -> Html Msg
view model isInNavbar = 
                -- advanced search
                div [
                    id "div_advanced_search",
                    css ((Styles.Home.advancedSearch (model.homePage.advancedSearchVisibility)) ++ if isInNavbar then
                                                                                                    [
                                                                                                        Css.paddingTop (px 20),
                                                                                                        Css.paddingBottom (px 40),
                                                                                                        Css.width (Css.em 80),
                                                                                                        marginTop (px 0),
                                                                                                        marginLeft auto,
                                                                                                        marginRight auto
                                                                                                    ]
                                                                                                 else 
                                                                                                    []
                                                                                            )
                ] [

                    div [
                        id "div_ptm",
                        css [
                            displayFlex,
                            flexDirection column,
                            alignSelf stretch
                        ]
                    ] [
                         div [
                            id "div_ptm_header",
                            css [
                                displayFlex,
                                flexDirection row,
                                alignSelf stretch
                            ]
                         ][
                             div [
                                 id "div_ptm_label",
                                 css [
                                     fontWeight bold,
                                     color Colors.headerBlack,
                                     alignSelf stretch
                                 ]
                             ][
                                 text "PTM type"
                             ],
                            
                             button [
                                 id "btn_select_all_ptm",
                                 css Styles.Home.selectorButton
                             ][
                                 text "All"
                             ],
                             button [
                                 id "btn_select_none_ptm",
                                 css (Styles.Home.selectorButton ++ [marginLeft (px 20)])
                             ][
                                 text "None"
                             ]
                         ],
                        div [
                            id "ptm_type_selections",
                            css [
                                displayFlex,
                                flexDirection row,
                                marginLeft (px 5),
                                marginRight (px 5),
                                marginTop (px 5),
                                alignSelf stretch,
                                justifyContent spaceBetween
                            ]                             
                        ][
                            div [
                                id "ptm_type_column",
                                css [
                                    displayFlex,
                                    flexDirection column,
                                    alignSelf stretch
                                ]
                            ][
                                label [
                                    id "lbl_acetylation"
                                ][ 
                                    input [
                                        id "cb_acetylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType
                                    ][], text "Acetylation"
                                ],

                                label [
                                    id "lbl_n_lycosylation"
                                ][ 
                                    input [
                                        id "cb_n_glycosylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType
                                    ][], text "N-Glycosylation"
                                ],

                                label [
                                    id "lbl_o_lycosylation"
                                ][ 
                                    input [
                                        id "cb_o_glycosylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "O-Glycosylation"
                                ],

                                label [
                                    id "lbl_c_lycosylation"
                                ][ 
                                    input [
                                        id "cb_c_glycosylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "C-Glycosylation"
                                ]
                            ],
                            div [
                                id "ptm_type_column",
                                css [
                                    displayFlex,
                                    flexDirection column,
                                    marginTop (px 5)
                                ]
                            ][
                                label [
                                    id "lbl_s_glycosylation"
                                ][ 
                                    input [
                                        id "cb_s_glycosylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "S-Glycosylation"
                                ],

                                label [
                                    id "lbl_methylation"
                                ][ 
                                    input [
                                        id "cb_methylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Methylation"
                                ],

                                label [
                                    id "lbl_c_myristoylation"
                                ][ 
                                    input [
                                        id "cb_c_myristoylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Myristoylation"
                                ],

                                label [
                                    id "lbl_c_phosphorylation"
                                ][ 
                                    input [
                                        id "cb_c_phosphorylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Phosphorylation"
                                ]

                            ],
                            div [
                                id "ptm_type_column",
                                css [
                                    displayFlex,
                                    flexDirection column,
                                    marginTop (px 5)
                                ]
                            ][
                                label [
                                    id "lbl_s_sumoylation"
                                ][ 
                                    input [
                                        id "cb_s_sumoylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Sumoylation"
                                ],

                                label [
                                    id "lbl_ubiquitination"
                                ][ 
                                    input [
                                        id "cb_ubiquitination",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Ubiquitination"
                                ],

                                label [
                                    id "lbl_s_nitrosylation"
                                ][ 
                                    input [
                                        id "cb_s_nitrosylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "S-Nitrosylation"
                                ]
                            ]
                        ]
                    ],
                    
                    div [
                        id "div_role",
                        css [
                            displayFlex,
                            flexDirection column,
                            alignSelf left,
                            marginTop (px 20),
                            alignSelf stretch
                        ]
                    ][
                        div [
                            id "div_role_label",
                            css [
                                fontWeight bold,
                                color Colors.headerBlack,
                                alignSelf stretch
                            ]
                        ][
                            text "Role"
                        ],
                        div [
                            id "div_role_selections",
                            css [
                                displayFlex,
                                flexDirection row,
                                justifyContent spaceBetween,
                                marginLeft (px 5),
                                marginRight (px 5),
                                alignSelf stretch,
                                alignItems center
                            ]
                        ][
                            label [
                                id "lbl_enzyme_or_substrate"
                            ][ 
                                input [
                                    id "rb_enzyme_or_substrate",
                                    type_ "radio",
                                    name "role" ,
                                    value "enzyme_or_substrate",
                                    css [
                                        marginTop (px 10),
                                        marginRight (px 10)
                                    ] 
                                ][],
                                
                                text "Enzyme or Substrate"
                                
                            ],

                            label [
                                id "lbl_enzyme"
                            ][ 
                                input [
                                    id "rb_enzyme",
                                    type_ "radio",
                                    name "role" ,
                                    value "enzyme",
                                    css [
                                        marginTop (px 10),
                                        marginRight (px 10)
                                    ] 
                                ][],
                                
                                text "Enzyme"
                                
                            ],

                            label [
                                id "lbl_substrate"
                            ][ 
                                input [
                                    id "rb_substrate",
                                    type_ "radio",
                                    name "role" ,
                                    value "substrate",
                                    css [
                                        marginTop (px 10),
                                        marginRight (px 10)
                                    ] 
                                ][],
                                
                                text "Substrate"
                                
                            ],

                            label [
                                id "lbl_enzyme_or_substrate"
                            ][ 
                                input [
                                    id "rb_enzyme_or_substrate",
                                    type_ "radio",
                                    name "role" ,
                                    value "enzyme_or_substrate",
                                    css [
                                        marginTop (px 10),
                                        marginRight (px 10)
                                    ] 
                                ][],
                                
                                text "Enzyme Or Substrate"
                                
                            ]

                        ]

                    ],

                    div [
                        id "div_organism",
                        css [
                            displayFlex,
                            flexDirection column,
                            alignSelf stretch,
                            marginTop (px 25)
                        ]
                    ] [
                         div [
                            id "div_organism_header",
                            css [
                                displayFlex,
                                flexDirection row,
                                alignSelf stretch
                            ]
                         ][
                             div [
                                 id "div_organism_label",
                                 css [
                                     fontWeight bold,
                                     color Colors.headerBlack,
                                     alignSelf stretch
                                 ]
                             ][
                                 text "Organism"
                             ],
                            
                             button [
                                 id "btn_select_all_organisms",
                                 css Styles.Home.selectorButton
                             ][
                                 text "All"
                             ],
                             button [
                                 id "btn_select_none_organisms",
                                 css (Styles.Home.selectorButton ++ [marginLeft (px 20)])
                             ][
                                 text "None"
                             ]
                         ],
                        div [
                            id "organism_selections",
                            css [
                                displayFlex,
                                flexDirection row,
                                marginLeft (px 5),
                                marginRight (px 5),
                                marginTop (px 5),
                                alignSelf stretch,
                                justifyContent spaceBetween
                            ]                             
                        ][
                            div [
                                id "organism_column",
                                css [
                                    displayFlex,
                                    flexDirection column,
                                    alignSelf stretch
                                ]
                            ][
                                label [
                                    id "lbl_humans"
                                ][ 
                                    input [
                                        id "cb_human",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType
                                    ][], text "Human"
                                ],

                                label [
                                    id "lbl_Cow"
                                ][ 
                                    input [
                                        id "cb_cow",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType
                                    ][], text "Cow"
                                ],

                                label [
                                    id "lbl_fruit_fly"
                                ][ 
                                    input [
                                        id "cb_fruit_fly",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Fruit fly"
                                ],

                                label [
                                    id "lbl_fission_yeast"
                                ][ 
                                    input [
                                        id "cb_fission_yeast",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Fission yeast"
                                ]
                            ],
                            div [
                                id "organism_column",
                                css [
                                    displayFlex,
                                    flexDirection column,
                                    marginTop (px 5)
                                ]
                            ][


                                label [
                                    id "lbl_m_truncatula"
                                ][ 
                                    input [
                                        id "cb_m_truncatula",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "M. truncatula"
                                ],

                                label [
                                    id "lbl_mouse"
                                ][ 
                                    input [
                                        id "cb_mouse",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Mouse"
                                ],

                                label [
                                    id "lbl_chicken"
                                ][ 
                                    input [
                                        id "cb_chicken",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Chicken"
                                ],

                                label [
                                    id "lbl_c_elegans"
                                ][ 
                                    input [
                                        id "cb_c_elegans",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "C. elegans"
                                ]

                            ],
                            div [
                                id "ptm_type_column",
                                css [
                                    displayFlex,
                                    flexDirection column,
                                    marginTop (px 5)
                                ]
                            ][
                                label [
                                    id "lbl_a_thaliana"
                                ][ 
                                    input [
                                        id "cb_a_thaliana",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "A. Thaliana"
                                ],

                                label [
                                    id "lbl_rice"
                                ][ 
                                    input [
                                        id "cb_rice",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Rice (japonica)"
                                ],

                                label [
                                    id "lbl_rat"
                                ][ 
                                    input [
                                        id "cb_rat",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Rat"
                                ],

                                label [
                                    id "lbl_zebrafish"
                                ][ 
                                    input [
                                        id "cb_zebrafish",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Zebrafish"
                                ]
                            ],

                            div [
                                id "ptm_type_column",
                                css [
                                    displayFlex,
                                    flexDirection column,
                                    marginTop (px 5)
                                ]
                            ][
                                label [
                                    id "lbl_bakers_yeast"
                                ][ 
                                    input [
                                        id "cb_bakers_yeast",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Bakers's Yeast"
                                ],

                                label [
                                    id "lbl_maize"
                                ][ 
                                    input [
                                        id "cb_maize",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType 
                                    ][], text "Maize"
                                ]
                            ]
                        ],
                        div [
                            id "div_organism_taxon_codes",
                            css [
                                displayFlex,
                                flexDirection row,
                                alignSelf stretch,
                                marginTop (px 10),
                                marginLeft (px 10),
                                marginRight (px 10)
                            ]
                        ][
                            input [
                                id "input_organism_taxons",
                                css [
                                    Css.property "width" "100%",
                                    Css.height (px 35),
                                    paddingLeft (px 10),
                                    paddingRight (px 10)
                                ],
                                placeholder "Enter organism taxon codes seperated by comma"
                            ][

                            ]
                        ]
                    ]
                ]