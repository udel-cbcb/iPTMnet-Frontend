module Views.Info exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)
import String
import Dict exposing (..)

-- css
geneInfoTableCSS: List Style
geneInfoTableCSS = 
    [
        marginTop (px 20),
        fontSize (px 13),
        displayFlex,
        flexDirection column
    ]

proInfoTableCSS: List Style
proInfoTableCSS = 
    [
        marginTop (px 40),
        fontSize (px 13),
        displayFlex,
        flexDirection column
    ]

tableRowCSS: List Style
tableRowCSS = 
    [  
        displayFlex,
        flexDirection row
    ]

tableKeysCSS: List Style
tableKeysCSS = 
    [
        flex (num 1.5),
        borderBottomWidth (px 1),
        borderBottomStyle solid,
        borderBottomColor (rgb 225 225 232)
    ]

tableValueCSS: List Style
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
view: InfoData -> Html Msg
view data = 
    case data.status of
        NotAsked ->
            text ""

        Loading ->
            text "Loading..."

        Success ->
            
            div [id "info"] [
                h2[ css [
                    borderBottomWidth (px 1),
                    borderBottomStyle solid,
                    borderBottomColor (rgb 225 225 232),
                    paddingBottom (px 10),
                    fontSize (px 30),
                    fontWeight normal
                ]] [text (interpolate "iPTMnet Report for {0} ({1})" [data.data.uniprot_ac, data.data.gene_name])],

                h4 [css [
                    fontSize (px 20),
                    fontWeight normal

                ]] [text "Protein information"],

                div [id "info_table", css geneInfoTableCSS ] [
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "UniProt AC / UniProt ID"],
                        span [css tableValueCSS]
                              [a [href (interpolate "http://www.uniprot.org/uniprot/{0}" [data.data.uniprot_ac] ), Html.Styled.Attributes.target "_blank"] [text data.data.uniprot_ac],
                               text (interpolate " / {0}" [data.data.uniprot_id] )] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Protein Name"],
                        span [css tableValueCSS] [text data.data.protein_name] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Gene Name"],
                        span [css tableValueCSS] [text (interpolate "Name: {0} " [data.data.gene_name]),
                               br[][],
                               text (interpolate "Synonyms: {0} " [String.join "," data.data.synonymns])] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Organism"],
                        span [css tableValueCSS,align "left"] [text (interpolate "{0} ({1})" [data.data.organism.species,data.data.organism.common_name])] 
                    ]
                ],

               div [id "pro_table", css proInfoTableCSS] [
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "PRO ID"],
                        span [css tableValueCSS] [
                            a [href (interpolate "http://purl.obolibrary.org/obo/PR_{0}" [data.data.uniprot_ac] ), Html.Styled.Attributes.target "_blank"] [text (data.data.pro.id)]] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "PRO Name"],
                        span [css tableValueCSS] [text data.data.pro.name] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Definition"],
                        span [css tableValueCSS] [text data.data.pro.definition] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Short Label"],
                        span [css tableValueCSS] [text data.data.pro.short_label] 
                    ],
                    div [css tableRowCSS] [
                        span [css tableKeysCSS] [text "Category"],
                        span [css tableValueCSS] [text data.data.pro.category] 
                    ]

                ]

            ]

        error ->
            text data.error

decodeResponse: WebData Info -> InfoData 
decodeResponse response = 
    case response of
        RemoteData.NotAsked ->
            {
                status = NotAsked,
                error = "",
                data = Model.emptyInfo
            }

        RemoteData.Loading ->
            {
                status = Loading,
                error = "",
                data = Model.emptyInfo
            }

        RemoteData.Success info ->
            {
                status = Success,
                error = "",
                data = info
            }

        RemoteData.Failure error ->
            {
                status = Error,
                error = (toString error),
                data = Model.emptyInfo
            }
