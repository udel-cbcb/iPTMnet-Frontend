module Page.BatchResult exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import Views.Navbar
import Views.Score
import String.Interpolate exposing (interpolate)

view : Model -> Html Msg
view model =  
            div [id "page",css [
            displayFlex,
            flexDirection column]] 
            [  

            Views.Navbar.view model,

            case model.batchPage.outputType of
                Model.Enzymes ->
                    batchEnzymesView model
                Model.PTMPPI ->
                    batchPTMPPIView model
        ]

batchEnzymesView: Model -> Html Msg
batchEnzymesView model =
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
                    div [css [flex (num 1),
                            marginLeft (px 5),
                            marginRight (px 20),
                            paddingLeft (px 5),
                            displayFlex,
                            flexDirection row,
                            alignItems center
                        ]]
                    [
                        input [type_ "checkbox", css[marginLeft (px 5), marginRight (px 15)]][],
                        text "PTM Type"
                    ],
                    div [css [flex (num 1),
                        marginRight (px 20)         
                        ]]
                    [
                        text "Substrate"
                    ],
                    div [css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        text "Site"
                    ],
                    div [css [flex (num 1),
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
                    div [css [flex (num 1),
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
                div [] (List.map enzymeResultRow model.batchPage.batchEnzymeData.data)
            
            ]

batchPTMPPIView: Model -> Html Msg
batchPTMPPIView model =
            div [] []

enzymeResultRow: (BatchEnzyme Entity Source) -> Html Msg
enzymeResultRow enzyme = 
    div [id "enzyme_table_row", css [
                    displayFlex,
                    flexDirection row,
                    paddingTop (px 10),
                    paddingBottom (px 10),
                    hover [
                        backgroundColor (hex "#0000000D")
                    ]
                ]] [
                    div [
                        id "ptm_type",
                        css [flex (num 1),
                            marginLeft (px 5),
                            marginRight (px 20),
                            paddingLeft (px 5),
                            displayFlex,
                            flexDirection row,
                            alignItems center
                        ]]
                    [
                        input [type_ "checkbox", css[marginLeft (px 5), marginRight (px 15)]][],
                        text enzyme.ptm_type
                    ],
                    div [
                        id "substrate",
                        css [flex (num 1),
                        marginRight (px 20)         
                        ]]
                    [
                        text enzyme.substrate.uniprot_id
                    ],
                    div [
                        id "site",
                        css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        text enzyme.site
                    ],
                    div [
                        id "ptm_enzyme",
                        css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        text enzyme.enzyme.uniprot_id
                    ],
                    div [
                        id "score",
                        css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        Views.Score.view enzyme.score
                    ],
                    div [
                        id "source",
                        css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        div [] (List.map buildSource enzyme.source |> List.intersperse (span [css [display inline]] [text ", "]))
                    ],
                    div [
                        id "pmid",
                        css [flex (num 1),
                            marginRight (px 20)
                            ]]
                    [
                        div [] (List.map buildPMID enzyme.pmids |> List.intersperse (span [css [display inline]] [text ",  "]))
                    ]

                                     


                ]

decodeEnzymeResponse: WebData (List (BatchEnzyme Entity Source)) -> BatchEnzymeData 
decodeEnzymeResponse response = 
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

        RemoteData.Success enzymeList ->
            {
                status = Success,
                error = "",
                data = enzymeList
            }

        RemoteData.Failure error ->
            {
                status = Error,
                error = (toString error),
                data = []
            }


buildSource: Source -> Html Msg 
buildSource source =
    a [
        css [
            display inline
        ],
        href "#",
        Html.Styled.Attributes.target "_blank"
    ] [
        text source.name
    ]

buildPMID: String -> Html Msg
buildPMID pmid =
    a [css [display inline], 
       href (interpolate "https://www.ncbi.nlm.nih.gov/pubmed/{0}" [pmid]), Html.Styled.Attributes.target "_blank"] [text pmid]