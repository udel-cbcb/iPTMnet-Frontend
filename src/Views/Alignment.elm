module Views.Alignment exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html
import Html.Styled exposing (toUnstyled,fromUnstyled)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Msgs exposing (..)
import Array exposing (..)
import Html.Lazy exposing (..)
import RemoteData exposing (WebData)
import Model.AlignmentViewer exposing (..)
import Model.Alignment exposing (..)
import Model.Misc exposing (..)
import Model.Source exposing (..)

view: AlignmentViewer -> Html Msg 
view alignmentViewer =

    div [
        css[
            displayFlex,
            flexDirection row,
            Css.property "align-items" "top"
        ]
    ][
        div[
            id "labels",
            css [
                flex (num 1),
                backgroundColor (hex "#f9f9f9")
            ]
        ] (([buildLabelHeaderItem])++ ((Array.indexedMap (buildLabel alignmentViewer.rowIndex) alignmentViewer.alignments) |> Array.toList)),

        div [
                id "sequences",
                css [
                    flex (num 5),
                    paddingLeft (px 10),
                    paddingBottom (px 10),
                    overflowX auto,
                    overflowY visible
                ]
        ][
            (lazy (buildHeader) (getSequenceLength alignmentViewer.alignments)) |> Html.Styled.fromUnstyled ,
            (lazy buildSequenceSection alignmentViewer.alignments) |> Html.Styled.fromUnstyled
        ]
          
    ]

    -- ([((buildHeader selectedColumnIndex) (getSequenceLength alignmentRows) )] ++ 

buildSequenceSection : (Array Alignment) -> Html.Html Msg
buildSequenceSection alignmentRows = 
    (div[
            id "sequences",
            css [

            ]
    ] ((Array.indexedMap buildSequence alignmentRows) |> Array.toList)) |> toUnstyled

buildSequence : Int -> Alignment -> Html Msg
buildSequence rowIndex alignment =
    div [
        css[
            displayFlex,
            flexDirection row
        ]
    ]((Array.indexedMap (buildAlignmentItem rowIndex) alignment.sequence) |> Array.toList)


buildLabel : Int -> Int -> Alignment -> Html Msg
buildLabel selectedIndex index alignment =
    div [
        css [
            displayFlex,
            flexDirection row,
            alignItems center,
            color (case (selectedIndex == index) of
                                True -> (hex "#ffffff")
                                False -> (hex "#191818")
                            ),
            backgroundColor (case (selectedIndex == index) of
                                True -> (hex "#329CDA")
                                False -> (hex "#f9f9f9")
                            )
        ]
    ][
        div [
            css [
                fontSize (Css.em 0.70),
                Css.property "min-height" "25px",
                displayFlex,
                alignItems center,
                paddingLeft (px 20)
            ]        
        ][
            div [
                css [
                    margin auto
                ]
            ][
                text alignment.id
            ]
        ]
    ]

buildAlignmentItem : Int -> Int -> AlignmentItem -> Html Msg
buildAlignmentItem rowIndex columnIndex alignmentItem =
    let 
        background_color = (getBackgroundColor alignmentItem.decorations)
        text_color = if (hex "#ffffff") == background_color then
                        (hex "#191818")
                     else
                        (hex "#ffffff")
        title_text = if (List.length alignmentItem.decorations) > 0 then
                    (buildTitle alignmentItem.decorations alignmentItem.site alignmentItem.position)
                else
                    alignmentItem.site ++ toString alignmentItem.position

    in
        div [
            title title_text,
            css [
                fontSize (Css.em 0.70),
                color text_color,
                Css.property "min-width" "20px",
                Css.property "min-height" "25px",
                displayFlex,
                alignItems center,
                backgroundColor background_color,
                hover ([
                    cursor pointer,
                    color (hex "#ffffff")
                ] ++ (if (List.length alignmentItem.decorations) > 0 then
                            [
                                Css.property "filter" "brightness(80%)"
                            ]
                      else
                            [
                                backgroundColor (hex "#329CDA")
                            ]
                     ))
            ],
            Html.Styled.Events.onMouseOver (Msgs.OnSequenceHover rowIndex columnIndex)        
        ][
            div [
                css [
                    margin auto
                ]
            ][
                text alignmentItem.site
            ]
        ]

buildHeader : Int -> Html.Html Msg
buildHeader length = 
    let
        headerItems = (List.range 1 (length))
    in
        (div [
            css [
                displayFlex,
                flexDirection row
            ]
        ] (List.map (buildHeaderItem) headerItems)) |> toUnstyled

buildHeaderItem : Int -> Html Msg
buildHeaderItem index =
    div [
        css [
            Css.property "min-width" "20px",
            Css.property "min-height" "25px",
            displayFlex,
            fontSize (if (index < 100) then
                        Css.em(0.80)
                      else if(index >= 100 && index < 1000) then 
                        Css.em(0.65)
                      else 
                        Css.em(0.52) 
                     ),
            alignItems center,
            backgroundColor (hex "#f9f9f9")
        ]  
    ][
        div [
            css [
                margin auto
            ]
        ][
            text (case (index % 10) of 
                    0 -> (toString index)
                    _ -> "."
                  )
        ]
    ]

buildLabelHeaderItem :  Html Msg
buildLabelHeaderItem  =
    div [
        css [
            displayFlex,
            flexDirection row,
            alignItems center,
            backgroundColor (hex "#f9f9f9")
        ]
    ][
        div [
            css [
                fontSize (Css.em 0.70),
                Css.property "min-height" "25px",
                displayFlex,
                alignItems center,
                hover [
                    cursor pointer,
                    backgroundColor (hex "#e4e82e")
                ]
            ]        
        ][
            div [
                css [
                    margin auto
                ]
            ][
                text ""
            ]
        ]
    ]


getSequenceLength: Array Alignment -> Int 
getSequenceLength alignment = 
    case (Array.get 0 alignment) of 
        Just alignmentRow -> Array.length alignmentRow.sequence
        Nothing -> 0


decodeResponse: WebData (Array Alignment) -> AlignmentViewer 
decodeResponse response = 
    case response of
        RemoteData.NotAsked ->
            {
                rowIndex = -1,
                columnIndex = -1,
                status =  NotAsked,
                error = "",
                alignments = Array.fromList []    
            }

        RemoteData.Loading ->
            {
                rowIndex = -1,
                columnIndex = -1,
                status =  Loading,
                error = "",
                alignments = Array.fromList []    
            }

        RemoteData.Success alignments ->
            {
                rowIndex = -1,
                columnIndex = -1,
                status =  Success,
                error = "",
                alignments = alignments    
            }

        RemoteData.Failure error ->
            {
                rowIndex = -1,
                columnIndex = -1,
                status =  Error,
                error = toString error,
                alignments = Array.fromList []    
            }

getBackgroundColor: (List Decoration) -> Css.Color
getBackgroundColor decorations =
    case (List.length decorations) of 
        0 -> (hex "#ffffff")
        1 -> (case (List.head decorations) of
                Nothing -> (hex "#ffffff")
                Just decoration -> (getColorFromDecoration decoration)
            )
        _ -> (hex "#f7c23d")

getColorFromDecoration: Decoration -> Css.Color
getColorFromDecoration decoration = 
    let
        color = if (not (String.isEmpty decoration.ptm_type)) then 
                    case (String.toLower decoration.ptm_type) of
                        "phosphorylation" -> "#f4428c"
                        "acetylation" -> "#bf42f4"
                        "n-glycosylation" -> "#0bbc64"
                        "o-glycosylation" -> "#0bbc64"
                        "s-glycosylation" -> "#0bbc64"
                        "c-glycosylation" -> "#0bbc64"
                        "methylation" -> "#42cef4"
                        "ubiquitination" -> "#415cf4"
                        "myristoylation" -> "#058252"
                        "s-nitrosylation" -> "#821704"
                        _ -> 
                            "#191818"
                else
                    (if decoration.is_conserved then
                                "#cecccc"
                            else
                                "#ffffff" 
                    )
    in
    (hex color)

buildTitle: (List Decoration) -> String -> int -> String
buildTitle decorations site position =
    List.map (buildTitleFromDecoration site position) decorations |> String.join "\n" 

buildTitleFromDecoration: String -> int -> Decoration -> String
buildTitleFromDecoration site position decoration = 
    if (not (String.isEmpty decoration.ptm_type)) then
        site ++ (toString position) ++ ": " ++ decoration.ptm_type ++ ", Source: " ++ (sourcesToString decoration.source) ++ ", PMID: " ++ pmidsToString decoration.pmids
    else
        site ++ (toString position)

sourcesToString : (List Source) -> String 
sourcesToString sources =
    if (List.length sources) > 0 then
        List.map (\source -> source.name) sources |> String.join "\n"
    else
        "NA"

pmidsToString : (List String) -> String 
pmidsToString pmids =
    if (List.length pmids) > 0 then
        pmids |> String.join ","
    else
        "NA"

    