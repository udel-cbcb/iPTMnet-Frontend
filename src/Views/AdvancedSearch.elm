module Views.AdvancedSearch exposing (..)
import Model exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import Colors exposing (..)
import Styles.Home exposing (..)
import List.Extra

view : SearchOptions -> Bool -> Bool -> Html Msg
view searchOptions advancedSearchVisibility isInNavbar = 
                -- advanced search
                div [
                    id "div_advanced_search",
                    css ((Styles.Home.advancedSearch (advancedSearchVisibility)) ++ if isInNavbar then
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
                                 css Styles.Home.selectorButton,
                                 onClick (Msgs.SetSelectedPTMTypes ["Acetylation","N-Glycosylation","O-Glycosylation","C-Glycosylation","S-Glycosylation",
                                                                    "Methylation","Myristoylation","Phosphorylation","Sumoylation","Ubiquitination","S-Nitrosylation"])
                             ][
                                 text "All"
                             ],
                             button [
                                 id "btn_select_none_ptm",
                                 css (Styles.Home.selectorButton ++ [marginLeft (px 20)]),
                                 onClick (Msgs.SetSelectedPTMTypes [])
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
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "Acetylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "Acetylation")
                                    ][], text "Acetylation"
                                ],

                                label [
                                    id "lbl_n_lycosylation"
                                ][ 
                                    input [
                                        id "cb_n_glycosylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "N-Glycosylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "N-Glycosylation")
                                    ][], text "N-Glycosylation"
                                ],

                                label [
                                    id "lbl_o_lycosylation"
                                ][ 
                                    input [
                                        id "cb_o_glycosylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "O-Glycosylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "O-Glycosylation") 
                                    ][], text "O-Glycosylation"
                                ],

                                label [
                                    id "lbl_c_lycosylation"
                                ][ 
                                    input [
                                        id "cb_c_glycosylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "C-Glycosylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "C-Glycosylation") 
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
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "S-Glycosylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "S-Glycosylation") 
                                    ][], text "S-Glycosylation"
                                ],

                                label [
                                    id "lbl_methylation"
                                ][ 
                                    input [
                                        id "cb_methylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "Methylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "Methylation") 
                                    ][], text "Methylation"
                                ],

                                label [
                                    id "lbl_c_myristoylation"
                                ][ 
                                    input [
                                        id "cb_c_myristoylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "Myristoylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "Myristolytation") 
                                    ][], text "Myristoylation"
                                ],

                                label [
                                    id "lbl_c_phosphorylation"
                                ][ 
                                    input [
                                        id "cb_c_phosphorylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "Phosphorylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "Phosphorylation")  
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
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "Sumoylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "Sumoylation")    
                                    ][], text "Sumoylation"
                                ],

                                label [
                                    id "lbl_ubiquitination"
                                ][ 
                                    input [
                                        id "cb_ubiquitination",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "Ubiquitination" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "Ubiquitination") 
                                    ][], text "Ubiquitination"
                                ],

                                label [
                                    id "lbl_s_nitrosylation"
                                ][ 
                                    input [
                                        id "cb_s_nitrosylation",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "S-Nitrosylation" searchOptions.ptm_types),
                                        onClick (togglePTMType searchOptions.ptm_types "S-Nitrosylation")
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
                                    ],
                                    Html.Styled.Attributes.checked (searchOptions.role == "Enzyme or Substrate"),
                                    onClick (Msgs.SearchRoleChanged "Enzyme or Substrate")
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
                                    ],
                                    Html.Styled.Attributes.checked (searchOptions.role == "Enzyme"),
                                    onClick (Msgs.SearchRoleChanged "Enzyme") 
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
                                    ],
                                    Html.Styled.Attributes.checked (searchOptions.role == "Substrate"),
                                    onClick (Msgs.SearchRoleChanged "Substrate") 
                                ][],
                                
                                text "Substrate"
                                
                            ],

                            label [
                                id "lbl_enzyme_and_substrate"
                            ][ 
                                input [
                                    id "rb_enzyme_and_substrate",
                                    type_ "radio",
                                    name "role" ,
                                    value "enzyme_and_substrate",
                                    css [
                                        marginTop (px 10),
                                        marginRight (px 10)
                                    ],
                                    Html.Styled.Attributes.checked (searchOptions.role == "Enzyme and Substrate"),
                                    onClick (Msgs.SearchRoleChanged "Enzyme and Substrate")
                                ][],
                                
                                text "Enzyme and Substrate"
                                
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
                                 css Styles.Home.selectorButton,
                                 onClick (Msgs.SetSelectedTaxons ["9606","9913","7215","4896","3880","10090",
                                                                  "9031","124036","344310","35790","10114","7955",
                                                                  "4932","4577"])
                             ][
                                 text "All"
                             ],
                             button [
                                 id "btn_select_none_organisms",
                                 css (Styles.Home.selectorButton ++ [marginLeft (px 20)]),
                                 onClick (Msgs.SetSelectedTaxons [""])
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
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "9606" searchOptions.organisms_defaults),
                                        onClick (toggleTaxon searchOptions.organisms_defaults "9606")
                                    ][], text "Human"
                                ],

                                label [
                                    id "lbl_Cow"
                                ][ 
                                    input [
                                        id "cb_cow",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "9913" searchOptions.organisms_defaults),
                                        onClick (toggleTaxon searchOptions.organisms_defaults "9913")
                                    ][], text "Cow"
                                ],

                                label [
                                    id "lbl_fruit_fly"
                                ][ 
                                    input [
                                        id "cb_fruit_fly",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "7215" searchOptions.organisms_defaults)
                                    ][], text "Fruit fly"
                                ],

                                label [
                                    id "lbl_fission_yeast"
                                ][ 
                                    input [
                                        id "cb_fission_yeast",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "4896" searchOptions.organisms_defaults) 
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
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "3880" searchOptions.organisms_defaults)  
                                    ][], text "M. truncatula"
                                ],

                                label [
                                    id "lbl_mouse"
                                ][ 
                                    input [
                                        id "cb_mouse",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "10090" searchOptions.organisms_defaults)  
                                    ][], text "Mouse"
                                ],

                                label [
                                    id "lbl_chicken"
                                ][ 
                                    input [
                                        id "cb_chicken",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "9031" searchOptions.organisms_defaults) 
                                    ][], text "Chicken"
                                ],

                                label [
                                    id "lbl_c_elegans"
                                ][ 
                                    input [
                                        id "cb_c_elegans",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "124036" searchOptions.organisms_defaults) 
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
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "344310" searchOptions.organisms_defaults) 
                                    ][], text "A. Thaliana"
                                ],

                                label [
                                    id "lbl_rice"
                                ][ 
                                    input [
                                        id "cb_rice",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "35790" searchOptions.organisms_defaults) 
                                    ][], text "Rice (japonica)"
                                ],

                                label [
                                    id "lbl_rat"
                                ][ 
                                    input [
                                        id "cb_rat",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "10114" searchOptions.organisms_defaults) 
                                    ][], text "Rat"
                                ],

                                label [
                                    id "lbl_zebrafish"
                                ][ 
                                    input [
                                        id "cb_zebrafish",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "7955" searchOptions.organisms_defaults)  
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
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "4932" searchOptions.organisms_defaults) 
                                    ][], text "Bakers's Yeast"
                                ],

                                label [
                                    id "lbl_maize"
                                ][ 
                                    input [
                                        id "cb_maize",
                                        type_ "checkbox",
                                        css Styles.Home.ptmType,
                                        Html.Styled.Attributes.checked (List.member "4577" searchOptions.organisms_defaults) 
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
                                onInput Msgs.OnTaxonsUserInput, 
                                placeholder "Enter organism taxon codes seperated by comma"
                            ][

                            ]
                        ]
                    ]
                ]


togglePTMType : (List String) -> String -> Msg
togglePTMType ptm_types ptm_type = 
    case List.member ptm_type ptm_types of
        True -> Msgs.SetSelectedPTMTypes (List.Extra.remove ptm_type ptm_types)
        False -> Msgs.SetSelectedPTMTypes (ptm_types ++ [ptm_type])

toggleTaxon : (List String) -> String -> Msg
toggleTaxon taxons taxon = 
    case List.member taxon taxons of
        True -> Msgs.SetSelectedTaxons (List.Extra.remove taxon taxons)
        False -> Msgs.SetSelectedTaxons (taxons ++ [taxon])