module Views.Error exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import Colors
import Ionicon

view: String -> Bool-> Msg -> Html Msg 
view errorMsg isMsgVisible erroButtonMsg = 
    div [
        id "div_error_container",
        css [
            displayFlex,
            flexDirection row,
            alignSelf center,
            alignItems center
        ]
    ] [
        div [
            id "div_error",
            css [
                displayFlex,
                flexDirection column,
                alignItems center
            ]
        ][
            div [
                id "error_label",
                css [
                    color Colors.errorText,
                    fontSize (Css.em 1.5),
                    Css.fontWeight bold
                ]
            ][
                text "Whoops!"
            ],

            div [
                id "error_label_1",
                css [
                    color Colors.errorText,
                    fontSize (Css.em 1)
                ]
            ][
                text "Looks like something went wrong"
            ],

            div [
                id "btn_error",
                css [
                    displayFlex,
                    flexDirection row,
                    alignItems center,
                    Css.height (px 30),
                    backgroundColor Colors.errorButtonBackground,
                    borderRadius (px 5),
                    marginTop (px 10),
                    hover [
                        cursor pointer
                    ]
                ],
                onClick erroButtonMsg
            ][
                div [
                    css [
                        paddingLeft (px 10),
                        paddingRight (px 10),
                        color Colors.errorCodeIconBackground,
                        fontSize (Css.em 0.95)
                    ]
                ][
                    text "ERROR"
                ],
                div [
                    id "error_code",
                            css [
                                displayFlex,
                                flexDirection column,
                                alignItems center,
                                paddingLeft (px 5),
                                paddingRight (px 5),
                                Css.property "height" "100%",
                                backgroundColor Colors.errorCodeIconBackground,
                                borderTopRightRadius (px 5),
                                borderBottomRightRadius (px 5)
                            ]
                    ][
                        div [
                                css [
                                    marginTop (px 6),
                                    paddingLeft (px 5),
                                    paddingRight (px 5)
                                ]
                            ] [
                                Ionicon.code 16 Colors.errorCodeIcon |> Html.Styled.fromUnstyled
                        ]
                ]
            ],

            div [
                id "error_msg",
                css ([
                    color Colors.errorCodeIconBackground,
                    marginTop (px 10),
                    marginBottom (px 20),
                    marginLeft (px 20),
                    marginRight (px 20),
                    textAlign center
                ] ++ Model.isVisible isMsgVisible)
            ][
                text errorMsg
            ]
        ]
    ]