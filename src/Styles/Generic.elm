module Styles.Generic exposing (..)
import Css exposing (..)
import Colors exposing (..)


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