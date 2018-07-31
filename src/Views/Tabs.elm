module Views.Tabs exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Css exposing (..)
import Msgs exposing (..)
import Colors

import Model.Tab exposing (..)

view : TabData -> (String -> Msg) -> Html Msg
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


viewTabItem: String -> (String -> Msg) -> Tab -> Html Msg
viewTabItem selected_tab onTabClick tab =
        div [
           id "sub_button",
           css tabItemStyle,
           onClick (onTabClick tab.title)
        ][
            div [
                css [
                    displayFlex,
                    flexDirection row,
                    alignItems center,
                    paddingTop (px 10),
                    paddingLeft (px 10),
                    paddingRight (px 10)
                ]
            ][
                div [
                    id "tab_label",
                    css [
                    
                    ]
                ][
                    text tab.title
                ],

                div [
                    id "count",
                    css [
                        Css.height (px 25),
                        Css.width (px 25),
                        backgroundColor Colors.tabSelectedColor,
                        color (hex "#ffffff"),
                        Css.property "border-radius" "50%",
                        displayFlex,
                        alignItems center,
                        marginLeft (px 10),
                        marginRight (px 5),
                        fontSize (Css.em 0.75)
                    ]
                ][
                    span [css [margin auto, textAlign center]] [text (toString tab.count)]
                ]               

            ],

            div [
                id "selector_bar",
                css [
                    alignSelf stretch,
                    marginTop (px 5),
                    Css.height (px 4),
                    backgroundColor (case selected_tab == tab.title of 
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