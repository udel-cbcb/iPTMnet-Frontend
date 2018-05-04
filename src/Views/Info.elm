module Views.Info exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)
import String

-- css
geneInfoTableCSS = 
    [
        marginTop (px 20),
        fontSize (px 13),
        displayFlex,
        flexDirection column
    ]

proInfoTableCSS = 
    [
        marginTop (px 40),
        fontSize (px 13),
        displayFlex,
        flexDirection column
    ]

tableRowCSS = 
    [  
        displayFlex,
        flexDirection row
    ]

tableKeysCSS = 
    [
        flex (num 1.5),
        borderBottomWidth (px 1),
        borderBottomStyle solid,
        borderBottomColor (rgb 225 225 232)
    ]

tableValueCSS = 
    [
        flex (num 8),
        borderLeftWidth (px 1),
        borderLeftStyle solid,
        borderLeftColor (rgb 225 225 232),
        borderBottomWidth (px 1),
        borderBottomStyle solid,
        borderBottomColor (rgb 225 225 232),
        padding (Css.em 0.2),
        paddingLeft (Css.em 1)
    ]    


-- returns the info views
view: WebData (Info) -> Html Msg
view response = 
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success info ->
            
            div [id "info"] [
                h2[ css [
                    borderBottomWidth (px 1),
                    borderBottomStyle solid,
                    borderBottomColor (rgb 225 225 232),
                    paddingBottom (px 10),
                    fontSize (px 30),
                    fontWeight normal
                ]] [text (interpolate "iPTMnet Report for {0} ({1})" [info.uniprot_ac, info.gene_name])],

                h4 [css [
                    fontSize (px 20),
                    fontWeight normal

                ]] [text "Protein information"],

                div [id "info_table", css geneInfoTableCSS ] [
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "UniProt AC / UniProt ID"],
                        span [css tableValueCSS]
                              [a [href (interpolate "http://www.uniprot.org/uniprot/{0}" [info.uniprot_ac] ), Html.Styled.Attributes.target "_blank"] [text info.uniprot_ac],
                               text (interpolate " / {0}" [info.uniprot_id] )] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Protein Name"],
                        span [css tableValueCSS] [text info.protein_name] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Gene Name"],
                        span [css tableValueCSS] [text (interpolate "Name: {0} " [info.gene_name]),
                               br[][],
                               text (interpolate "Synonyms: {0} " [String.join "," info.synonymns])] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Organism"],
                        span [css tableValueCSS,align "left"] [text (interpolate "{0} ({1})" [info.organism.species,info.organism.common_name])] 
                    ]
                ],

               div [id "pro_table", css proInfoTableCSS] [
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "PRO ID"],
                        span [css tableValueCSS] [
                            a [href (interpolate "http://purl.obolibrary.org/obo/PR_{0}" [info.uniprot_ac] ), Html.Styled.Attributes.target "_blank"] [text (info.pro.id)]] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "PRO Name"],
                        span [css tableValueCSS] [text info.pro.name] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Definition"],
                        span [css tableValueCSS] [text info.pro.definition] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Short Label"],
                        span [css tableValueCSS] [text info.pro.short_label] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Category"],
                        span [css tableValueCSS] [text info.pro.category] 
                    ]

                ]

            ]

        RemoteData.Failure error ->
            text (toString error)