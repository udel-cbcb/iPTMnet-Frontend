module Views.Alignment exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html
import Html.Styled exposing (toUnstyled,fromUnstyled)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Msgs exposing (..)
import Model exposing  (..)
import Array
import Html.Lazy exposing (..)

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
                backgroundColor (hex "#f9f9f9"),
                paddingTop (px 5)
            ]
        ] (([buildLabelHeaderItem])++ ((Array.indexedMap (buildAlignmentLabel alignmentViewer.rowIndex) alignmentViewer.alignment) |> Array.toList)),

        div [
                id "sequences",
                css [
                    flex (num 5),
                    paddingTop (px 5),
                    paddingLeft (px 10),
                    overflowX auto
                ]
        ][
            ((buildHeader alignmentViewer.columnIndex) (getSequenceLength alignmentViewer.alignment) ),
            (lazy buildSequences alignmentViewer.alignment) |> Html.Styled.fromUnstyled
        ]
          
    ]

    -- ([((buildHeader selectedColumnIndex) (getSequenceLength alignmentRows) )] ++ 

buildSequences : (Array.Array AlignmentRow) -> Html.Html Msg
buildSequences alignmentRows = 
    (div[
            id "sequences",
            css [

            ]
    ] ((Array.indexedMap buildAlignmentSequences alignmentRows) |> Array.toList)) |> toUnstyled

buildAlignmentLabel : Int -> Int -> AlignmentRow -> Html Msg
buildAlignmentLabel selectedIndex index alignmentRow =
    div [
        css [
            displayFlex,
            flexDirection row,
            alignItems center,
            backgroundColor (case (selectedIndex == index) of
                                True -> (hex "#e4e82e")
                                False -> (hex "#f9f9f9")
                            )
        ]
    ][
        div [
            id "name",
            css [
                fontSize (Css.em 0.80),
                Css.height (Css.em 1.2),
                paddingLeft (px 10)
            ]
        ][
                text alignmentRow.name
        ]
    ]

buildAlignmentSequences : Int -> AlignmentRow -> Html Msg
buildAlignmentSequences rowIndex alignmentRow =
    div [
        css[
            displayFlex,
            flexDirection row
        ]
    ]((Array.indexedMap (buildAlignmentItem rowIndex) alignmentRow.sequences) |> Array.toList)


buildAlignmentItem : Int -> Int -> AlignmentItem -> Html Msg
buildAlignmentItem rowIndex columnIndex alignmentItem =
    div [
        css [
            fontSize (Css.em 0.85),
            Css.property "min-width" "1em",
            Css.property "min-height" "1em",
            textAlign center,
            hover [
                cursor pointer,
                backgroundColor (hex "#e4e82e")
            ]
        ],
        Html.Styled.Events.onMouseOver (Msgs.OnSequenceHover rowIndex columnIndex)        
    ][
        text alignmentItem.label
    ]

buildHeader : Int -> Int -> Html Msg
buildHeader selectedIndex length = 
    let
        headerItems = (List.range 0 (length-1))
    in
        div [
            css [
                displayFlex,
                flexDirection row
            ]
        ] (List.map (buildHeaderItem selectedIndex) headerItems)

buildHeaderItem : Int -> Int -> Html Msg
buildHeaderItem selectedIndex index =
    div [
        css [
            fontSize (Css.em 0.85),
            Css.property "min-width" "1em",
            Css.property "min-height" "1em",
            textAlign center,
            backgroundColor (case (selectedIndex == index) of
                                True -> (hex "#e4e82e")
                                False -> (hex "#f9f9f9")
                            )
        ]  
    ][
        text "."
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
            id "header",
            css [
                fontSize (Css.em 0.85),
                Css.property "min-height" "1em",
                paddingLeft (px 10)
            ]
        ][
                text ""
        ]
    ]


getSequenceLength: Alignment -> Int 
getSequenceLength alignment = 
    case (Array.get 0 alignment) of 
        Just alignmentRow -> Array.length alignmentRow.sequences
        Nothing -> 0


