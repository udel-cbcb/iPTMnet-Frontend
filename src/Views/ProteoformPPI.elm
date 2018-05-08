module Views.ProteoformPPI exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import Model exposing (..)
import String.Interpolate exposing (interpolate)
import String.Extra exposing (..)

-- returns the substrate view
view: ProteoformPPIData -> Html Msg 
view data = 
            div [id "proteoform_ppi", css [marginTop (px 20),paddingBottom (px 80)] ][
            div [css [
                        displayFlex,
                        flexDirection row,
                        paddingTop (px 10),
                        paddingBottom (px 10)
                     ]]
                [
                span [css [fontSize (px 20)]][text "Proteoform PPI"],
                div [id "proteoform_ppi_search" ,css [
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


renderView: ProteoformPPIData -> Html Msg
renderView data =
    case data.status of
        NotAsked ->
            text "No yet requested"
        Loading ->
            text "Loading"
        Success ->
            renderProteoformPPITable data.data
        Error ->
            text data.error


renderProteoformPPITable: List (ProteoformPPI Protein Source) -> Html Msg
renderProteoformPPITable proteoformPPIList =
        div [id "proteoformppi_table", css [
            displayFlex,
            flexDirection column,
            fontSize (px 13),
            borderWidth (px 1),
            borderStyle solid,
            borderColor (hex "#d9dadb")
        ]][
            -- header
            div [id "proteoformppi_table_header", css [
                displayFlex,
                flexDirection row,
                backgroundColor (hex "#eff1f2"),
                paddingTop (px 5),
                paddingBottom (px 5),
                fontWeight bold
            ]] [
                div [css [flex (num 2),
                          marginLeft (px 5),
                          marginRight (px 10),
                          paddingLeft (px 20)
                    ]]
                [
                    text "Protein 1"
                ],
                div [css [flex (num 1),
                          marginRight (px 10)         
                         ]] 
                [
                    text "Relation"
                ],
                div [css [flex (num 2),
                     marginRight (px 10)         
                    ]]
                [
                    text "Protein 2"
                ],
                div [css [flex (num 1),
                          marginRight (px 10)
                         ]]
                [
                    text "Source"
                ],
                div [css [flex (num 1),
                          marginRight (px 10)
                         ]]
                [
                    text "PMID"
                ]
                
            ],
            -- rows
            div [] (List.map proteoformPPIRow proteoformPPIList) 
        
        ]

proteoformPPIRow: (ProteoformPPI Protein Source) -> Html Msg
proteoformPPIRow proteoformPPI = 
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
                          marginLeft (px 0),
                          marginRight (px 10),
                          paddingLeft (px 5)
                    ]]
                [
                    input [type_ "checkbox", css[marginLeft (px 5), marginRight (px 10)]][],
                    a [href (interpolate "http://purl.obolibrary.org/obo/{0}" [(replace ":" "_" proteoformPPI.protein_1.pro_id )]), Html.Styled.Attributes.target "_blank"] [text proteoformPPI.protein_1.pro_id],
                    span [] [text (interpolate " ({0})" [proteoformPPI.protein_1.label])]
                ],
                div [css [flex (num 1),
                          marginRight (px 10)         
                         ]] 
                [
                    text proteoformPPI.relation
                ],
                div [css [flex (num 2),
                     marginRight (px 10)         
                    ]] (buildProtein2 proteoformPPI.protein_2) ,
                div [css [flex (num 1),
                          marginRight (px 10)
                         ]]
                [
                    a [href (interpolate "{0}" [proteoformPPI.source.url]), Html.Styled.Attributes.target "_blank"] [text proteoformPPI.source.name]
                ],
                div [css [flex (num 1),
                          marginRight (px 10)
                         ]]
                [
                    text "PMID"
                ]
    ]


buildProtein2: Protein -> List (Html Msg)
buildProtein2 entity = 
    if String.length(entity.label) /= 0 then
        [
            a [href (interpolate "http://purl.obolibrary.org/obo/{0}" [(replace ":" "_" entity.pro_id )]), Html.Styled.Attributes.target "_blank"] [text entity.pro_id],
            span [] [text (interpolate " ({0})" [entity.label])]
        ]
    else
        [

        ]


decodeResponse: WebData (List (ProteoformPPI Protein Source)) -> ProteoformPPIData 
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

