module Page.Batch exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import Views.Navbar
import FileReader exposing (NativeFile)
import String.Interpolate exposing (interpolate)
import Views.Footer

tableItemCSS: List Style
tableItemCSS =
    [
        display tableCell,
        flex (num 1),
        border3 (px 1) solid (hex "#D3D3D3"),
        padding (px 5),
        textAlign center,
        borderCollapse collapse
    ]

view : Model -> Html Msg
view model =  
            div [id "page",css [
                displayFlex,
                Css.property "min-height" "100%",
                flexDirection column]] 
            [  
            
                -- header
                Views.Navbar.view model,

                -- content
                div [id "content", css [
                    displayFlex,
                    flexDirection column,
                    marginLeft (px 20),
                    flexGrow (num 1),
                    fontSize (px 13),
                    marginBottom (px 100)
                ]] [
                    
                    div [css [
                            marginTop (px 40),
                            fontSize (px 24),
                            fontWeight bold                        
                            ]] [text "Batch retrieval"],
                    
                    div [css [
                            marginTop (px 10),
                            marginBottom (px 40),
                            fontSize (px 14)                        
                            ]] [text "Use this page to retrieve information from the iPTMnet on PTM Enzyme-Site relation, and PTM-dependent PPIs. "],
                    
                    div [ css [
                        displayFlex,
                        flexDirection row
                    ]] [
                        -- input
                        div [css [
                            Css.property "height" "100%",
                            displayFlex,
                            flexDirection column,
                            flex (num 2),
                            paddingRight (px 50)
                        ]] [
                            
                            -- text area
                            textarea [ 
                                id "ta_substrates",
                                css [
                                    Css.height (px 400)
                                ],
                                onInput Msgs.OnBatchInputChanged,
                                value model.batchPage.inputText                                 
                            ][
                                
                            ],
                            
                            -- examples
                            div [ 
                                id "div_examples",
                                css [
                                    displayFlex,
                                    flexDirection row,
                                    alignItems center,
                                    marginTop (px 5)
                                ]
                            ][
                                button [
                                    id "btn_clear", 
                                    css [
                                        margin (px 5)
                                        ],
                                    onClick Msgs.OnBatchClearClicked
                                    ]
                                    [text "Clear"],
                                button [ 
                                    id "btn_examples",
                                    css [
                                            margin (px 5),
                                            marginLeft auto
                                        ],
                                    onClick Msgs.OnBatchInputExampleClicked
                                    ] [text "Input examples"]
                            ],

                            -- input
                            div [
                                id "div_upload",
                                css [
                                    displayFlex,
                                    flexDirection row,
                                    alignItems center,
                                    marginTop (px 15)
                                ]
                            ][
                                input [
                                    id "btn_browse", 
                                    type_ "file",
                                    multiple False,
                                    FileReader.onFileChange Msgs.OnFileChange |> Html.Styled.Attributes.fromUnstyled,
                                    css [
                                        margin (px 5)]
                                        ] [text "Browse"]
                            ],
                            
                            div [css [marginLeft (px 5)]][text (interpolate "Contains {0} kinases" [toString (List.length model.batchPage.kinases)])],

                            -- output
                            div [
                                id "div_select_output",
                                css [
                                    marginTop (px 40)
                                ]
                            ][
                                text "Select Output"
                            ],
                            div [
                                id "div_output",
                                css [
                                        displayFlex,
                                        flexDirection column,
                                        alignItems left
                                    ]
                                ] [  
                                
                                label [
                                    id "lbl_enzymes"
                                ][ 
                                    input [
                                        id "rb_enzymes",
                                        type_ "radio",
                                        name "output" ,
                                        value "enzymes",
                                        Html.Styled.Attributes.checked (case model.batchPage.outputType of 
                                                                        Model.Enzymes ->
                                                                            True
                                                                        _ ->
                                                                            False
                                        ),
                                        onClick (Msgs.SwitchBatchOutput Model.Enzymes),
                                        css [
                                            marginTop (px 10),
                                            marginRight (px 10)
                                        ] 
                                    ][], text "PTM Enzymes"
                                ],
                                label [
                                    id "lbl_ptm_ppi"
                                ][ 
                                    input [
                                        id "rb_ptmppi",
                                        type_ "radio",
                                        name "output" ,
                                        value "ptmppi",
                                        Html.Styled.Attributes.checked (case model.batchPage.outputType of 
                                                                        Model.PTMPPI ->
                                                                            True
                                                                        _ ->
                                                                            False
                                        ),
                                        onClick (Msgs.SwitchBatchOutput Model.PTMPPI),
                                        css [
                                            marginTop (px 10),
                                            marginRight (px 10)
                                        ] 
                                    ][], text "PTM Dependent PPIs"
                                ]
                            ],
                            button [
                                id "btn_submit",
                                css [
                                    marginTop (px 20),
                                    alignSelf center
                                ],
                                onClick (Msgs.ChangeLocation "batch-result")
                            ][
                                text "Submit"
                            ]

                        ],

                        -- info
                        div [css [
                            displayFlex,
                            flexDirection column,
                            flex (num 4),
                            paddingLeft (px 50)
                        ]] [
                            div [css [fontWeight bold]] [text "Input format"],
                            div [css [marginTop (px 10)]] [text "Paste into the box or upload a text file containing a three column space/comma/tab-delimited list (do not include a header line)"],
                            

                            -- header
                            div [css [
                                displayFlex,
                                flexDirection row,
                                marginTop (px 10)
                            ]][
                                div [css tableItemCSS] [text "Substrate AC"],
                                div [css tableItemCSS] [text "Site Residue"],
                                div [css tableItemCSS] [text "Site Position"]
                            ],

                            -- row
                            div [css [
                                displayFlex,
                                flexDirection row
                            ]][
                                div [css tableItemCSS] [text "Q15796"],
                                div [css tableItemCSS] [text "S"],
                                div [css tableItemCSS] [text "465"]
                            ],

                            div [css [marginTop (px 10)]] [text "Query Limit: 500 lines (Large queries may take several minutes to process)"],
                            div [css [marginTop (px 10)]] [text "Delimiter: comma, tab, space"],
                            div [css [marginTop (px 10)]] [text "Substrate must be provided. "], 

                            div [css [marginTop (px 30),fontWeight bold]] [text "Select desired output"],
                            div [css [marginTop (px 10)]] [text "PTM Enzymes: Displays all iPTMnet PTM enzyme-site relations for the sites on the input list along with evidence source(s)."],
                            div [css [marginTop (px 10)]] [text "PTM Dependent PPIs: Displays all PTM-dependent protein-protein interactions for the sites on the input list along with evidence source(s)."]  

                        ],

                        -- right space
                        div [id "right_space",css [flex (num 1)]] []

                    ]

                ],

                -- footer
                Views.Footer.view

            ]


