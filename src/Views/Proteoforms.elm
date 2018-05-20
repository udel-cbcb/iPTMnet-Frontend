module Views.Proteoforms exposing (view, decodeResponse)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import Model exposing (..)
import String.Interpolate exposing (interpolate)
import String.Extra exposing (..)
import Views.Loading 
import Views.Error

-- returns the substrate view
view: ProteoformsData -> Bool -> Html Msg 
view data showErrorMsg= 
    case data.status of
        NotAsked ->
            div [][]
        Loading ->
            viewWithSection Views.Loading.view
        Success ->
            case (List.length data.data) of
            0 -> div [][]
            _ ->  viewWithSection (renderProteoformTable data.data)
        Error ->
            viewWithSection (Views.Error.view data.error showErrorMsg Msgs.OnProteoformsErrorButtonClicked)
        

viewWithSection: (Html Msg) -> Html Msg
viewWithSection childView =
    div [
        id "proteoforms",
        css [
                displayFlex,
                flexDirection column,
                marginTop (px 30),
                alignItems center
            ]]
            [
                div [css [
                            displayFlex,
                            flexDirection row,
                            paddingTop (px 10),
                            paddingBottom (px 10),
                            alignItems center,
                            alignSelf stretch
                        ]]
                [
                    span [css [
                        fontSize (Css.em 1.5)
                    ]][text "Proteoforms"],
                    div [id "proteforms_search" ,css [
                                                        marginLeft auto,
                                                        alignSelf center
                                                    ]]
                    [
                        span [css [marginRight (px 10), fontSize (Css.em 1)]] [text "Search:"],
                        input [] []
                    ]
                ],
                childView             
            ]

decodeResponse: WebData (List (Proteoform Enzyme Source)) -> ProteoformsData 
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

        RemoteData.Success proteoformsList ->
            {
                status = Success,
                error = "",
                data = proteoformsList
            }

        RemoteData.Failure error ->
            {
                status = Error,
                error = (toString error),
                data = []
            }



renderProteoformTable: List (Proteoform Enzyme Source) -> Html Msg
renderProteoformTable proteoformList =
        div [id "proteoforms_table", css [
            displayFlex,
            flexDirection column,
            fontSize (Css.em 0.88),
            borderWidth (px 1),
            borderStyle solid,
            borderColor (hex "#d9dadb"),
            alignSelf stretch
        ]][
            -- header
            div [id "proteoforms_table_header", css [
                displayFlex,
                flexDirection row,
                backgroundColor (hex "#eff1f2"),
                paddingTop (px 5),
                paddingBottom (px 5),
                fontWeight bold
            ]] [
                div [css [flex (num 2),
                          marginLeft (px 5),
                          marginRight (px 20),
                          paddingLeft (px 5)
                    ]]
                [
                    text "PRO ID (Short Label)"
                ],
                div [css [flex (num 1.5),
                          marginRight (px 10)         
                         ]] 
                [
                    text "Sites"
                ],
                div [css [flex (num 2),
                     marginRight (px 20)         
                    ]]
                [
                    text "PTM Enzymes"
                ],
                div [css [flex (num 0.5),
                          marginRight (px 20)
                         ]]
                [
                    text "Source"
                ],
                div [css [flex (num 1),
                          marginRight (px 20)
                         ]]
                [
                    text "PMID"
                ]
            ],

            -- rows
            div [] (List.map proteoformRow proteoformList) 
        
        ]

proteoformRow: (Proteoform Enzyme Source) -> Html Msg
proteoformRow proteoform = 
    div [css [
        displayFlex,
        flexDirection row,
        paddingTop (px 5),
        paddingBottom (px 5),
        hover [
            backgroundColor (hex "#f4f4f4")
        ]
    ]] [
        div [css [flex (num 2),
                  marginLeft (px 5),
                  marginRight (px 20)
                 ]] 
        [
            input [type_ "checkbox", css[marginLeft (px 5), marginRight (px 10)]][],
            a [href (interpolate "http://purl.obolibrary.org/obo/{0}" [(replace ":" "_" proteoform.pro_id )]), Html.Styled.Attributes.target "_blank"] [text proteoform.pro_id],
            span [] [text (interpolate " ({0})" [proteoform.label])]
        ],
        div [css [flex (num 1.5),
                  marginRight (px 10),
                  Css.property "word-wrap" "breakword"         
                 ]]
        [
            text (String.join ", " proteoform.sites)
        ],
        div [css [flex (num 2),
                  marginRight (px 20)         
                 ]] (buildEnzyme proteoform.ptm_enzyme)
        ,
        div [css [flex (num 0.5),
                  marginRight (px 20)
                 ]] [
            a [href (interpolate "{0}/{1}" [proteoform.source.url,(replace ":" "_" proteoform.pro_id )]), Html.Styled.Attributes.target "_blank"] [text proteoform.source.name]
        ],
        div [css [flex (num 1),
                  marginRight (px 20)
                 ]] 
        [
            text "PMID"
        ]
    ]

buildEnzyme: Enzyme -> List (Html Msg)
buildEnzyme entity = 
    if String.length(entity.label) /= 0 then
        [
            a [href (interpolate "http://purl.obolibrary.org/obo/{0}" [(replace ":" "_" entity.pro_id )]), Html.Styled.Attributes.target "_blank"] [text entity.pro_id],
            span [] [text (interpolate " ({0})" [entity.label])]
        ]
    else
        [

        ]


