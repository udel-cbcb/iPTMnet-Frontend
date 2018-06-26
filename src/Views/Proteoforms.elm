module Views.Proteoforms exposing (view, decodeResponse)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Msgs exposing (..)
import RemoteData exposing (WebData)
import Model exposing (..)
import String.Interpolate exposing (interpolate)
import String.Extra exposing (..)
import Views.Loading 
import Views.Error
import Misc
import String
import Filter

-- returns the substrate view
view: ProteoformsData -> (List CytoscapeItem) -> Bool ->  Html Msg 
view data cytoscapeItems showErrorMsg= 
    case data.status of
        NotAsked ->
            div [][]
        Loading ->
            viewWithSection Views.Loading.view
        Success ->
            viewWithSection (renderProteoformTable data.data data.filterTerm cytoscapeItems) 
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
                    div [id "proteforms_search" ,
                        Html.Styled.Events.onInput Msgs.OnProteoformSearch,
                        css [
                                marginLeft auto,
                                alignSelf center
                            ]
                        ]
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



renderProteoformTable: List (Proteoform Enzyme Source) -> String -> (List CytoscapeItem) -> Html Msg
renderProteoformTable proteoformList filterTerm cytoscapeItems =
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
                paddingTop (px 10),
                paddingBottom (px 10),
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
            div [] (List.map (proteoformRow cytoscapeItems) (case String.length filterTerm of
                                             0 -> proteoformList
                                             _ -> List.filter (Filter.proteoforms filterTerm) proteoformList)
                   ) 
        
        ]

proteoformRow: (List CytoscapeItem) -> (Proteoform Enzyme Source) -> Html Msg
proteoformRow cytoscapeItems proteoform = 
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
                  marginLeft (px 5),
                  marginRight (px 20)
                 ]] 
        [
            (
                let
                    cytoscapeItem = {id_1 = proteoform.pro_id ,id_2 = proteoform.ptm_enzyme.pro_id,item_type = "pro" } 
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
        (
            List.map Misc.buildPMID proteoform.pmids 
            |> List.intersperse (span [css [display inline]] [text ",  "])
        )
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
