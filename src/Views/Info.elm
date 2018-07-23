module Views.Info exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)
import String
import Views.Error
import Views.Loading

-- css
geneInfoTableCSS: List Style
geneInfoTableCSS = 
    [
        marginTop (px 20),
        fontSize (Css.em 0.9),
        displayFlex,
        flexDirection column
    ]

proInfoTableCSS: List Style
proInfoTableCSS = 
    [
        marginTop (px 40),
        fontSize (Css.em 0.9),
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
view: InfoData -> Bool -> Html Msg
view data isErrorVisible =
    div [
            id "info",
                css [
                    displayFlex,
                    flexDirection column,
                    alignItems center
                ]
            ][
                h2[ 
                    css [
                        borderBottomWidth (px 1),
                        borderBottomStyle solid,
                        borderBottomColor (rgb 225 225 232),
                        paddingBottom (px 10),
                        fontSize (Css.em 2.5),
                        fontWeight normal,
                        alignSelf stretch
                    ]] [
                        text (interpolate "iPTMnet Report for {0} ({1})" [data.data.uniprot_ac, data.data.gene_name])
                ],

            case data.status of
                NotAsked ->
                    text ""

                Loading ->
                    Views.Loading.view
                    
                Success ->
                    div [
                        css [
                            alignSelf stretch
                        ]
                    ][
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
                        viewPro data.data.pro data.data.uniprot_ac
                    ]                    

                Error ->
                    (Views.Error.view data.error isErrorVisible Msgs.OnInfoErrorButtonClicked)

            ]

viewPro: Maybe PRO -> String -> Html Msg
viewPro maybe_pro uniprot_ac =  
        case maybe_pro of
            Just pro ->
                div [id "pro_table", css proInfoTableCSS]
                    [
                            div [css tableRowCSS] [
                                span [css tableKeysCSS] [text "PRO ID"],
                                span [css tableValueCSS] [
                                    a [href (interpolate "http://purl.obolibrary.org/obo/PR_{0}" [uniprot_ac] ), Html.Styled.Attributes.target "_blank"] [text (pro.id)]] 
                            ],
                            div [css tableRowCSS] [
                                span [css tableKeysCSS] [text "PRO Name"],
                                span [css tableValueCSS] [text pro.name] 
                            ],
                            div [css tableRowCSS] [
                                span [css tableKeysCSS] [text "Definition"],
                                span [css tableValueCSS] [text pro.definition] 
                            ],
                            div [css tableRowCSS] [
                                span [css tableKeysCSS] [text "Short Label"],
                                span [css tableValueCSS] [text pro.short_label] 
                            ],
                            div [css tableRowCSS] [
                                span [css tableKeysCSS] [text "Category"],
                                span [css tableValueCSS] [text pro.category] 
                            ]
                    ]
                       
            Nothing -> 
                div [] []

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
