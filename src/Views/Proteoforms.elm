module Views.Proteoforms exposing (view, decodeResponse)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import Model exposing (..)
import String.Interpolate exposing (interpolate)
import String.Extra exposing (..)

-- returns the substrate view
view: ProteoformsData -> Html Msg 
view data = 
        div [id "proteoforms", css [marginTop (px 20)] ][
            div [css [
                        displayFlex,
                        flexDirection row,
                        paddingTop (px 10),
                        paddingBottom (px 10)
                     ]]
                [
                span [css [
                    fontSize (px 20)
                ]][text "Proteoforms"],
                div [id "proteforms_search" ,css [
                                                    marginLeft auto,
                                                    alignSelf center
                                                ]]
                [
                    span [css [marginRight (px 10), fontSize (px 12)]] [text "Search:"],
                    input [] []
                ]
            ],
            renderView data             
        ]

renderView: ProteoformsData -> Html Msg
renderView data =
    case data.status of
        NotAsked ->
            text "No yet requested"
        Loading ->
            text "Loading"
        Success ->
            renderProteoformTable data.data
        Error ->
            text data.error

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
            fontSize (px 13),
            borderWidth (px 1),
            borderStyle solid,
            borderColor (hex "#d9dadb")
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
        paddingBottom (px 2),
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


