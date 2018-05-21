module Views.PTMDependentPPI exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Model exposing (..)
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)
import Views.Loading
import Views.Error


-- returns the substrate view
view: PTMDependentPPIData -> Bool -> Html Msg 
view data showErrorMsg = 
    case data.status of
        NotAsked ->
            div [][]
        Loading ->
            viewWithSection Views.Loading.view
        Success ->
            case (List.length data.data) of
            0 -> div [][]
            _ ->  viewWithSection (renderPTMTable data.data)
        Error ->
            viewWithSection (Views.Error.view data.error showErrorMsg Msgs.OnPTMDepPPIErrorButtonClicked)

viewWithSection: (Html Msg) -> Html Msg
viewWithSection childView =
    div [
        id "ptm_dependent_ppi",
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
                    ]][text "PTM Dependent PPI"],
                    div [id "ptm_dep_ppi__search" ,css [
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

renderPTMTable: List (PTMDependentPPI Entity Source) -> Html Msg
renderPTMTable ptmDependentPPIList =
        div [id "ptmdependentppi_table", css [
            displayFlex,
            flexDirection column,
            fontSize (Css.em 0.88),
            borderWidth (px 1),
            borderStyle solid,
            borderColor (hex "#d9dadb"),
            alignSelf stretch
        ]][
            -- header
            div [id "ptmdependentppi_table_header", css [
                displayFlex,
                flexDirection row,
                backgroundColor (hex "#eff1f2"),
                paddingTop (px 10),
                paddingBottom (px 10),
                fontWeight bold
            ]] [
                div [css [flex (num 1),
                          marginLeft (px 5),
                          marginRight (px 10),
                          paddingLeft (px 20)
                    ]]
                [
                    text "PTM type"
                ],
                div [css [flex (num 1),
                          marginRight (px 10)         
                         ]] 
                [
                    text "Substrate"
                ],
                div [css [flex (num 1),
                     marginRight (px 10)         
                    ]]
                [
                    text "Site"
                ],
                div [css [flex (num 1),
                          marginRight (px 10)
                         ]]
                [
                    text "Interactant"
                ],
                div [css [flex (num 1),
                          marginRight (px 10)
                         ]]
                [
                    text "Association type"
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
            div [] (List.map ptmDependentPPIRow ptmDependentPPIList) 
        
        ]

ptmDependentPPIRow: (PTMDependentPPI Entity Source) -> Html Msg
ptmDependentPPIRow ptmdependentppi = 
    div [css [
        displayFlex,
        flexDirection row,
        paddingTop (px 10),
        paddingBottom (px 10),
        hover [
            backgroundColor (hex "#f4f4f4")
        ]
    ]] [
        div [css [flex (num 1),
                  marginLeft (px 5),
                  marginRight (px 20)
                 ]] 
        [
            input [type_ "checkbox", css[marginLeft (px 5), marginRight (px 10)]][],
            span [] [text (interpolate " {0}" [ptmdependentppi.ptm_type])]
        ],
        div [css [flex (num 1),
                  marginRight (px 20)
                 ]] 
        [
            a [] [text ptmdependentppi.substrate.uniprot_id],
            span [] [text (interpolate " ({0})" [ptmdependentppi.substrate.name])]
        ],
        div [css [flex (num 1),
                  marginRight (px 20)
                 ]] 
        [
            text ptmdependentppi.site
        ],
        div [css [flex (num 1),
                  marginRight (px 20)
                 ]] 
        [
            a [] [text ptmdependentppi.interactant.uniprot_id],
            span [] [text (interpolate " ({0})" [ptmdependentppi.interactant.name])]
        ],
        div [css [flex (num 1),
                  marginRight (px 20)
                 ]] 
        [
            text ptmdependentppi.association_type
        ],
        div [css [flex (num 1),
                  marginRight (px 20)
                 ]] 
        [
            a [href (interpolate "{0}" [ptmdependentppi.source.url]), Html.Styled.Attributes.target "_blank"] [text ptmdependentppi.source.name]
        ],
        div [css [flex (num 1),
                  marginRight (px 20)
                 ]] 
        [
            text "PMID"
        ]
    ]

decodeResponse: WebData (List (PTMDependentPPI Entity Source)) -> PTMDependentPPIData 
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

        RemoteData.Success ptmDependentPPIList ->
            {
                status = Success,
                error = "",
                data = ptmDependentPPIList
            }

        RemoteData.Failure error ->
            {
                status = Error,
                error = (toString error),
                data = []
            }