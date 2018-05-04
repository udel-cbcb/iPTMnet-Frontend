module Views.Proteoforms exposing (view)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import Model exposing (..)
import String.Interpolate exposing (interpolate)
import String.Extra exposing (..)

-- returns the substrate view
view: WebData (List (Proteoform Entity Source)) -> Html Msg 
view response = 
        div [id "proteoforms", css [marginTop (px 20)] ][
            
            h4 [css [
                fontSize (px 20),
                fontWeight normal
            ]][text "Proteoforms"],
            
            decodeResponse response

        ]


decodeResponse: WebData (List (Proteoform Entity Source)) -> Html Msg 
decodeResponse response = 
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
             text "Loading"

        RemoteData.Success proteoformsList ->
            renderProteoformTable proteoformsList

        RemoteData.Failure error ->
            text (toString error)


renderProteoformTable: List (Proteoform Entity Source) -> Html Msg
renderProteoformTable proteoformList =
        div [id "proteoforms_table", css [
            displayFlex,
            flexDirection column
        ]][
            -- header
            div [id "proteoforms_table_header", css [
                displayFlex,
                flexDirection row,
                backgroundColor (hex "#eff1f2"),
                padding (px 10)
            ]] [
                div [css [flex (num 2)]] [
                    text "PRO ID (Short Label)"
                ],
                div [css [flex (num 1)]] [
                    text "Sites"
                ],div [css [flex (num 2)]] [
                    text "PTM Enzymes"
                ],
                div [css [flex (num 1)]] [
                    text "Source"
                ],
                div [css [flex (num 1)]] [
                    text "PMID"
                ]
            ],

            -- rows
            div [] (List.map proteoformRow proteoformList) 
        
        ]

proteoformRow: (Proteoform Entity Source) -> Html Msg
proteoformRow proteoform = 
    div [css [
        displayFlex,
        flexDirection row,
        padding (px 5)
    ]] [
        div [css [flex (num 2)]] [
            input [type_ "checkbox"][],
            a [href (interpolate "http://purl.obolibrary.org/obo/{0}" [(replace ":" "_" proteoform.pro_id )]), Html.Styled.Attributes.target "_blank"] [text proteoform.pro_id],
            span [] [text (interpolate " ({0})" [proteoform.label])]
        ],
        div [css [flex (num 1)]] [
            text "Sites"
        ],
        div [css [flex (num 2)]] [
            text "PTM Enzymes"
        ],
        div [css [flex (num 1)]] [
            text "Source"
        ],
        div [css [flex (num 1)]] [
            text "PMID"
        ]
    ]

