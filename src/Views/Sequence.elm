module Views.Sequence exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Views.Alignment
import Ionicon
import Colors
import Model.AlignmentViewer exposing (..)
import Model.Misc exposing (..)

-- returns the sequence view
view: AlignmentViewer -> Html Msg 
view alignmentViewer =
    div [id "sequence_viewer", css [marginTop (px 20)] ][
        div [css [
            fontSize (px 20),
            fontWeight normal
        ]] [text "Interactive Sequence View"],

        div [
            id "div_sequence_alignment_viewer",
            css [
                marginTop (px 10)
            ]][
                --- Views.Alignment.view alignmentViewer
                -- viewLoading
                (case alignmentViewer.status of 
                NotAsked ->
                    div [] []
                Loading ->
                    viewLoading
                Error ->
                    -- viewError model.searchPage.searchData.error model.searchPage.showErrorMsg Msgs.OnSearchResultErrorButtonClicked
                    div [] []
                Success ->
                    Views.Alignment.view alignmentViewer)
        ]
    ]


viewLoading: Html Msg 
viewLoading = 
    div [
        id "div_loading_view_container",
        css [
            displayFlex,
            flexDirection row,
            alignSelf center,
            flexGrow (num 5),
            alignItems center
        ]
    ] [
        div [
            id "div_loading_view",
            css [
                displayFlex,
                flexDirection column,
                alignItems center,
                marginLeft auto,
                marginRight auto
            ]
        ][
            div [
                id "loading_icon",
                        css [
                            Css.width (px 50),
                            Css.height (px 50),
                            Css.property "-webkit-animation" "spin 0.8s linear infinite",
                            Css.property "-moz-animation" "spin 0.8s linear infinite"
                        ]
                ][
                    div [
                            css [
                                margin auto
                            ]
                        ] [
                            Ionicon.loadC 50 Colors.emptyIcon |> Html.Styled.fromUnstyled
                    ]
            ],
            div [
                id "loading_label",
                css [
                    color Colors.emptyText,
                    fontSize (Css.em 1.0),
                    Css.fontWeight bold
                ]
            ][
                text "Loading results.."
            ]
        ]
    ]
