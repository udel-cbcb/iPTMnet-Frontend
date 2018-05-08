module Page.Search exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)
import Views.Navbar

view : Model -> Html Msg
view model =  
            div [id "page",css [
            displayFlex,
            flexDirection column]] 
            [  

            Views.Navbar.view,

            div [id "search_table", css [
                displayFlex,
                flexDirection column,
                fontSize (px 13)
            ]][
                -- header
                div [id "search_table_header", css [
                    displayFlex,
                    flexDirection row,
                    backgroundColor (hex "#eff1f2"),
                    paddingTop (px 5),
                    paddingBottom (px 5),
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
                    div [css [flex (num 2),
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
                    div [css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        text "PTM-dependent PPI"
                    ],
                    div [css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        text "Sites"
                    ],
                    div [css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        text "Isoforms"
                    ]                  


                ],

                -- rows
                div [] (List.map searchResultRow (Debug.log "search_results" model.searchPage.searchData.data)) 
            
            ]       

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
                    div [css [flex (num 2),
                            marginRight (px 20)
                            ]]
                    [
                        text ( interpolate "{0} ({1})" [searchResult.organism.common_name,searchResult.organism.species] )
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
                    div [css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        text "PTM-dependent PPI"
                    ],
                    div [css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        text (toString searchResult.sites)
                    ],
                    div [css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        text (toString searchResult.isoforms)
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