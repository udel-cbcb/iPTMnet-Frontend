module Views.Substrate exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import Model exposing (..)
import Dict exposing (..)
import String.Interpolate exposing (interpolate)
import String.Extra exposing (..)

-- returns the substrate view
view: SubstrateData -> String -> String -> Html Msg 
view  data entryID geneName =
    div [id "substrates", css [marginTop (px 20)] ][
        h4 [css [
            fontSize (px 20),
            fontWeight normal
        ]] [text (interpolate "{0} ({1}) as Substrate" [entryID, geneName])],

        renderView data

    ]

renderView: SubstrateData -> Html Msg
renderView data =
    case data.status of
        NotAsked ->
            text "No yet requested"
        Loading ->
            text "Loading"
        Success ->
            renderSubstrateTable data.data
        Error ->
            text data.error

renderSubstrateTable: Dict String (List (Substrate Source SubstrateEnzyme)) -> Html Msg
renderSubstrateTable substrateDict =
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
                div [css [flex (num 1),
                          marginLeft (px 20),
                          marginRight (px 20),
                          paddingLeft (px 5)
                    ]]
                [
                    text "Site"
                ],
                div [css [flex (num 1),
                          marginRight (px 20)         
                         ]] 
                [
                    text "PTM Type"
                ],
                div [css [flex (num 3),
                     marginRight (px 20)         
                    ]]
                [
                    text "PTM Enzyme"
                ],
                div [css [flex (num 1),
                          marginRight (px 20)
                         ]]
                [
                    text "Score"
                ],
                div [css [flex (num 3),
                          marginRight (px 20)
                         ]]
                [
                    text "Sources"
                ],
                div [css [flex (num 3),
                          marginRight (px 20)
                         ]]
                [
                    text "PMID"
                ]
            ],
            -- rows
            case Dict.get "Q15796" substrateDict of 
                Just substrates -> 
                    div [] (List.map substrateRow substrates) 
                Nothing -> 
                    div [] []
        ]

substrateRow: Substrate Source SubstrateEnzyme -> Html Msg
substrateRow substrate = 
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
                          marginLeft (px 20),
                          marginRight (px 20),
                          paddingLeft (px 5)
                    ]]
                [
                    text substrate.site
                ],
                div [css [flex (num 1),
                          marginRight (px 20)         
                         ]] 
                [
                    text substrate.ptm_type
                ],
                div [css [flex (num 3),
                     marginRight (px 20)         
                    ]] (List.map buildEnzyme substrate.enzymes |> List.intersperse (span [css [display inline]] [text ", "])) ,
                div [css [flex (num 1),
                          marginRight (px 20)
                         ]]
                [
                    text "Score"
                ],
                div [css [flex (num 3),
                          marginRight (px 20)
                         ]]
                [
                    text "Sources"
                ],
                div [css [flex (num 3),
                          marginRight (px 20),
                          Css.property "word-wrap" "break-word"
                         ]]
                (
                    List.map buildPMID substrate.pmids 
                    |> List.intersperse (span [css [display inline]] [text ",  "])
                )
            ]


buildEnzyme: SubstrateEnzyme -> Html Msg
buildEnzyme enzyme = 
    div [css [display inline]] [
        a [href (interpolate "Q15796/{0}" [(replace ":" "_" enzyme.id )]), Html.Styled.Attributes.target "_blank"] [text enzyme.id],
        span [] [text (interpolate " ({0})" [enzyme.name])]
    ]

buildPMID: String -> Html Msg
buildPMID pmid =
    a [css [display inline], 
       href (interpolate "https://www.ncbi.nlm.nih.gov/pubmed/{0}" [pmid]), Html.Styled.Attributes.target "_blank"] [text pmid]


decodeResponse: WebData (Dict String (List (Substrate Source SubstrateEnzyme))) -> SubstrateData 
decodeResponse response = 
    case response of
        RemoteData.NotAsked ->
            {
                status = NotAsked,
                error = "",
                data = Dict.empty
            }

        RemoteData.Loading ->
            {
                status = Loading,
                error = "",
                data = Dict.empty
            }

        RemoteData.Success substrateTable ->
            {
                status = Success,
                error = "",
                data = substrateTable
            }

        RemoteData.Failure error ->
            {
                status = Error,
                error = (toString error),
                data = Dict.empty
            }


