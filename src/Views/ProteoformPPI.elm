module Views.ProteoformPPI exposing (..)
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
import Misc
import Html.Styled.Events
import Filter
import Html.Styled.Events exposing (..)

-- returns the substrate view
view: ProteoformPPIData -> (List CytoscapeItem) -> Bool -> Html Msg 
view data cytoscapeItems showErrorMsg= 
    case data.status of
        NotAsked ->
            div [][]
        Loading ->
            viewWithSection Views.Loading.view
        Success ->
            case (List.length data.data) of
            0 -> div [][]
            _ ->  viewWithSection (renderProteoformPPITable data.data data.filterTerm cytoscapeItems)
        Error ->
            viewWithSection (Views.Error.view data.error showErrorMsg Msgs.OnProteoformsPPIErrorButtonClicked)

viewWithSection: (Html Msg) -> Html Msg
viewWithSection childView =
    div [
        id "proteoforms_ppi",
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
                    ]][text "ProteoformsPPI"],
                    div [id "proteforms_ppi_search",
                         css [
                                marginLeft auto,
                                alignSelf center
                            ],
                         Html.Styled.Events.onInput Msgs.OnProteoformPPISearch
                        ]
                    [
                        span [css [marginRight (px 10), fontSize (Css.em 1)]] [text "Search:"],
                        input [] []
                    ]
                ],
                childView             
            ]


renderProteoformPPITable: List (ProteoformPPI Protein Source) -> String -> (List CytoscapeItem) -> Html Msg
renderProteoformPPITable proteoformPPIList filterTerm cytoscapeItems =
        div [id "proteoformppi_table", css [
            displayFlex,
            flexDirection column,
            fontSize (Css.em 0.88),
            borderWidth (px 1),
            borderStyle solid,
            borderColor (hex "#d9dadb"),
            alignSelf stretch
        ]][
            -- header
            div [id "proteoformppi_table_header", css [
                displayFlex,
                flexDirection row,
                backgroundColor (hex "#eff1f2"),
                paddingTop (px 10),
                paddingBottom (px 10),
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
            div [] (List.map (proteoformPPIRow cytoscapeItems) (case String.length filterTerm of
                                             0 -> proteoformPPIList
                                             _ -> List.filter (Filter.proteoformPPI filterTerm) proteoformPPIList)
                    ) 
        
        ]

proteoformPPIRow: (List CytoscapeItem) -> (ProteoformPPI Protein Source) -> Html Msg
proteoformPPIRow cytoscapeItems proteoformPPI = 
    div [css [
        displayFlex,
        flexDirection row,
        paddingTop (px 10),
        paddingBottom (px 10),
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
                    (
                        let
                            cytoscapeItem = {id_1 = proteoformPPI.protein_1.pro_id ,id_2 = proteoformPPI.protein_2.pro_id,item_type = "pro_ppi" } 
                            isChecked = List.member cytoscapeItem cytoscapeItems
                        in
                            input [
                                type_ "checkbox",
                                css[marginLeft (px 5),
                                    marginRight (px 10)],
                                onClick (Msgs.ToggleCytoscapeItem cytoscapeItem),
                                Html.Styled.Attributes.checked isChecked
                        ][]
                    ),
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
                (
                    List.map Misc.buildPMID proteoformPPI.pmids 
                    |> List.intersperse (span [css [display inline]] [text ",  "])
                )
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
                data = [],
                filterTerm = ""
            }

        RemoteData.Loading ->
            {
                status = Loading,
                error = "",
                data = [],
                filterTerm = ""
            }

        RemoteData.Success proteoformsList ->
            {
                status = Success,
                error = "",
                data = proteoformsList,
                filterTerm = ""
            }

        RemoteData.Failure error ->
            {
                status = Error,
                error = (toString error),
                data = [],
                filterTerm = ""
            }

