module Page.Entry exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import Views.Info
import Views.Sequence
import Views.Substrate
import Views.Proteoforms
import Views.PTMDependentPPI
import Views.ProteoformPPI
import Views.Navbar
import Views.Footer

-- css
sideBarItemCSS: List Style
sideBarItemCSS = 
    [
        padding (px 10),
        paddingTop (px 7),
        paddingBottom (px 7),
        fontSize (Css.em 0.88),
        flex (num 1),
        hover [
            backgroundColor (hex "#0000000D")
        ],
        textDecoration none,
        color (hex "#000000")
    ]

view : Model -> Html Msg
view model =

        div [id "page",css [
            displayFlex,
            flexDirection column,
            Css.property "min-height" "100%"
            ]] 
            [  

            Views.Navbar.view model,

            div [id "content",css [
                displayFlex,
                flexDirection row,
                flex (num 1)
                ]
            ] [
                
                div [id "sidebar", css [
                    displayFlex,
                    flexDirection column,
                    flex (num 1)
                ]][
                    div [css [
                        position fixed,
                        Css.property "width" "20%"
                    ]] [
                        div [css [
                            displayFlex,
                            flexDirection column,
                            margin (px 20),
                            backgroundColor (hex "ecececff")
                        ]]
                    [
                        div [css [fontWeight bold, padding (px 10)]] [
                            text "Display"
                        ],

                        div [css [displayFlex]] [
                            a[href "#info", css sideBarItemCSS][text "Protein Information"]
                        ],
                        
                        div [css [displayFlex]] [
                            a[href "#sequence_viewer", css sideBarItemCSS][text "Interactive Sequence Viewer"]
                        ],
                        
                        div [css [displayFlex]] [
                            a[href "#substrate", css sideBarItemCSS][text "Substrate"]
                        ],
                        
                        div [css [displayFlex]] [
                            a[href "#proteoforms", css sideBarItemCSS][text "Proteoforms"]
                        ],
                        
                        div [css [displayFlex]] [
                            a[href "#ptm_dependent_ppi", css sideBarItemCSS][text "PTM Dependent PPI"]
                        ],
                        
                        div [css [displayFlex]] [
                            a[href "#proteoform_ppi", css sideBarItemCSS][text "Proteoform PPI"]
                        ],
                                            
                        div [css [displayFlex]] [
                            a[href "#info", css sideBarItemCSS][text "Back to top"]
                        ]

                    ],

                    -- cytoscape
                    div [css [
                            backgroundColor (hex "ecececff"),
                            displayFlex,
                            flexDirection column,
                            margin (px 20)
                        ]]
                    [
                        div [css [fontWeight bold, padding (px 10)]] [
                            text "Cytoscape View"
                        ]

                    ]
                    ]
                    
                ],
                div [id "entry_content", css [
                    displayFlex,
                    flexDirection column,
                    flex (num 4),
                    paddingLeft (px 40),
                    paddingRight (px 40),
                    paddingBottom (px 40)
                ]][
                    Views.Info.view model.entryPage.infoData model.entryPage.showInfoErrorMsg,
                    Views.Sequence.view,
                    Views.Substrate.view model.entryPage.substrateData model.entryPage.infoData.data.uniprot_ac model.entryPage.infoData.data.gene_name model.entryPage.showSubstrateErrorMsg,
                    Views.Proteoforms.view model.entryPage.proteoformsData model.entryPage.showProteoformsErrorMsg,
                    Views.PTMDependentPPI.view model.entryPage.ptmDependentPPIData model.entryPage.showPTMDepPPIErrorMsg,
                    Views.ProteoformPPI.view model.entryPage.proteoformPPIData model.entryPage.showProteoformsPPIErrorMsg
                ]
            ],

            div[
                        id "filler",
                        css [
                            alignSelf stretch
                        ]
                    ][],

                    Views.Footer.view


        ]






