module Views.Alignment exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html
import Html.Styled exposing (toUnstyled,fromUnstyled)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Msgs exposing (..)
import Model exposing  (..)
import Array exposing (..)
import Html.Lazy exposing (..)
import RemoteData exposing (WebData)

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
            backgroundColor (case (selectedIndex == index) of
                                True -> (hex "#e4e82e")
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
                paddingLeft (px 20),
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
                text alignment.id
            ]
        ]
    ]

buildAlignmentItem : Int -> Int -> AlignmentItem -> Html Msg
buildAlignmentItem rowIndex columnIndex alignmentItem =
    div [
        title "this is a decoration",
        css [
            fontSize (Css.em 0.70),
            Css.property "min-width" "20px",
            Css.property "min-height" "25px",
            displayFlex,
            alignItems center,
            hover [
                cursor pointer,
                backgroundColor (hex "#e4e82e")
            ]
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
        headerItems = (List.range 0 (length-1))
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