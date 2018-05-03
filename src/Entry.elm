module Entry exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)
import String

view : Model -> Html Msg
view model =  
            div [id "page",css [
            Css.property "height" "100%",
            displayFlex,
            flexDirection row,
            flex (num 1)
            ]
        ] [
            div [id "sidebar", css [
                displayFlex,
                flexDirection column,
                alignItems center,
                backgroundColor (hex "ecececff"),
                flexGrow (num 1)
            ]][
                text "Display"
            ],
            div [id "content", css [
                displayFlex,
                flexDirection column,
                flexGrow (num 4),
                padding (px 40)
            ]][
                info model.info

            ]
        ]
    

info: WebData (Info) -> Html Msg
info response = 
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success info ->
            
            div [] [
                h2[] [text (interpolate "iPTMnet Report for {0} ({1})" [info.uniprot_ac, info.gene_name])],
                h4 [] [text "Protein information"],

                Html.Styled.table [id "info_table", css [
                    paddingTop (px 10)
                ] ] [
                    tr [] [
                        td [] [text "UniProt AC / UniProt ID"],
                        td [] [text (interpolate "{0}/{1}" [info.uniprot_ac,info.uniprot_id])] 
                    ],
                    tr [] [
                        td [] [text "Protein Name"],
                        td [] [text info.protein_name] 
                    ],
                    tr [] [
                        td [align "top"] [text "Gene Name"],
                        td [] [text (interpolate "Name: {0} " [info.gene_name]),
                               br[][],
                               text (interpolate "Synonyms: {0} " [String.join "," info.synonymns])] 
                    ],
                    tr [] [
                        td [] [text "Organism"],
                        td [] [text info.uniprot_ac] 
                    ]
                ],

                Html.Styled.table [id "pro_table", css [
                    paddingTop (px 10)
                ]] [
                    tr [] [
                        td [] [text "PRO ID"],
                        td [] [text info.uniprot_ac] 
                    ],
                    tr [] [
                        td [] [text "PRO Name"],
                        td [] [text info.uniprot_ac] 
                    ],
                    tr [] [
                        td [] [text "Definition"],
                        td [] [text info.uniprot_ac] 
                    ],
                    tr [] [
                        td [] [text "Short Label"],
                        td [] [text info.uniprot_ac] 
                    ],
                    tr [] [
                        td [] [text "Category"],
                        td [] [text info.uniprot_ac] 
                    ]

                ]

            ]

        RemoteData.Failure error ->
            text (toString error)


