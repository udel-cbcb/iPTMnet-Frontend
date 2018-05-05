module Views.PTMDependentPPI exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Model exposing (..)
import RemoteData exposing (WebData)
import String.Interpolate exposing (interpolate)


-- returns the substrate view
view: PTMDependentPPIData -> Html Msg 
view data = 
        div [id "ptm_dependent_ppi", css [marginTop (px 20)] ][
            div [css [
                        displayFlex,
                        flexDirection row,
                        paddingTop (px 10),
                        paddingBottom (px 10)
                     ]]
                [
                span [css [
                    fontSize (px 20)
                ]][text "PTM Dependent PPI"],
                div [id "ptm_dependent_ppi_search" ,css [
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

renderView: PTMDependentPPIData -> Html Msg
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

renderProteoformTable: List (PTMDependentPPI Entity Source) -> Html Msg
renderProteoformTable ptmDependentPPIList =
        div [id "ptmdependentppi_table", css [
            displayFlex,
            flexDirection column,
            fontSize (px 13),
            borderWidth (px 1),
            borderStyle solid,
            borderColor (hex "#d9dadb")
        ]][
            -- header
            div [id "ptmdependentppi_table_header", css [
                displayFlex,
                flexDirection row,
                backgroundColor (hex "#eff1f2"),
                paddingTop (px 5),
                paddingBottom (px 5),
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
        paddingTop (px 5),
        paddingBottom (px 5),
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