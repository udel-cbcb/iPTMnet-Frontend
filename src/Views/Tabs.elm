module Views.Tabs exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Css exposing (..)
import Msgs exposing (..)
import Colors
import Model

view : Model.TabData -> (String -> Msg) -> Html Msg
view data onTabClick = 
            div [
                    id "div_tabs",
                    css [
                        displayFlex,
                        flexDirection row,
                        borderWidth (px 1),
                        borderStyle solid,
                        borderColor (rgb 225 225 232),
                        borderLeftStyle none
                    ]
                ]([
                    
                ] ++ List.map (viewTabItem data.selectedTab onTabClick) data.tabs) 


viewTabItem: String -> (String -> Msg) -> String -> Html Msg
viewTabItem selected_tab onTabClick label =
        div [
           id "sub_button",
           css tabItemStyle,
           onClick (onTabClick label)
        ][
            div [
                id "tab_label",
                css [
                    paddingTop (px 10),
                    paddingLeft (px 10),
                    paddingRight (px 10)
                ]
            ]
            [
                text label
            ],

            div [
                id "selector_bar",
                css [
                    alignSelf stretch,
                    marginTop (px 5),
                    Css.height (px 4),
                    backgroundColor (case selected_tab == label of 
                                        True -> Colors.tabSelectedColor
                                        False -> Colors.transparent
                                    )
                ]
            ][]

        ]


tabItemStyle: List Style
tabItemStyle = 
    [
        displayFlex,
        flexDirection column,
        alignItems center,
      
        borderLeftWidth (px 1),
        borderLeftStyle solid,
        borderLeftColor (rgb 225 225 232),

        hover [
            cursor pointer,
            backgroundColor Colors.tabHoverColor
        ]

    ]