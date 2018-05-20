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

-- css
sideBarItemCSS: List Style
sideBarItemCSS = 
    [
        padding (px 10),
        paddingTop (px 7),
        paddingBottom (px 7),
        fontSize (px 13),
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
            flexDirection column]] 
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
                            backgroundColor (hex "ecececff"),
                            displayFlex,
                            flexDirection column,
                            margin (px 20)
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
                    paddingRight (px 40)
                ]][
                    Views.Info.view model.entryPage.infoData,
                    Views.Sequence.view,
                    Views.Substrate.view model.entryPage.substrateData model.entryPage.infoData.data.uniprot_ac model.entryPage.infoData.data.gene_name ,
                    Views.Proteoforms.view model.entryPage.proteoformsData,
                    Views.PTMDependentPPI.view model.entryPage.ptmDependentPPIData,
                    Views.ProteoformPPI.view model.entryPage.proteoformPPIData
                ]
            ]

        ]






