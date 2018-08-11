module Styles.Home exposing (..)
import Css exposing (..)
import Colors exposing (..)


navigationItem : List Style
navigationItem =
    [
    lineHeight (px 40),
    color Colors.navigationText,
    Css.paddingLeft (px 40),
    Css.paddingRight (px 40),
    fontSize (Css.em 1),
    hover [
            cursor pointer,
            backgroundColor Colors.navigationBackgroundHover
          ]
    ]

navigationSeperator : List Style
navigationSeperator =
    [
        Css.property "height" "50%",
        Css.width (px 1),
        backgroundColor Colors.navigationSeperator
    ]

selectorButton : List Style
selectorButton = 
    [
        marginLeft auto,
        fontSize (Css.em 0.85),
        paddingTop (px 2),
        paddingBottom (px 2),
        paddingLeft (px 15),
        paddingRight (px 15),
        backgroundColor Colors.transparent,
        color Colors.textBlack,
        borderStyle solid,
        borderRadius (px 50),
        borderWidth (px 1),
        borderColor Colors.navigationBackground,
        hover [
            cursor pointer,
            backgroundColor Colors.navigationBackground,
            color Colors.navigationText
        ],
        focus [
            outline none
        ]
    ]

ptmType : List Style
ptmType = 
   [
        marginTop (px 10),
        marginRight (px 10)
   ]

advancedSearch : Bool -> List Style 
advancedSearch is_visible =
    let 
        style  = [
                displayFlex,
                flexDirection column,
                alignSelf stretch,
                marginTop (px 20),
                marginLeft (px 5),
                marginRight (px 5),
                fontSize (Css.em 0.95),
                Css.property "visibility" (isVisible is_visible)
            ]


        chromeVisibility = case is_visible of 
                           True -> []
                           False -> [display none]

        finalStyle = style ++ chromeVisibility

    in
        finalStyle


isVisible : Bool -> String
isVisible is_visible =
    case is_visible of
    True -> "visible"
    False -> "collapse"