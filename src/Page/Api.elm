module Page.Api exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Msgs exposing (..)
import Views.Footer
import Colors
import Views.Navbar
import Model exposing (..)

view : Model -> Html Msg
view model = 

    div [id "page",css [
            Css.property "min-height" "100%",
            displayFlex,
            flexDirection column,
            flex (num 1),
            backgroundColor Colors.pageBackground
            ]
        ] [

        div [id "header", css [
            displayFlex,
            flexDirection column,
            alignSelf stretch
            ]] [
                Views.Navbar.view model.navbar
            ],
        
        div [id "body", css [
            displayFlex,
            flexDirection column,
            flexGrow (num 1),
            paddingTop (px 20),
            overflow auto            
            ]] [   
                div [
                    css [
                        displayFlex,
                        flexDirection column,
                        paddingLeft (px 30),
                        paddingRight (px 30)
                    ]
                ] [
                    div [
                        css [
                            fontSize (Css.em 1.5),
                            marginTop (px 20)
                        ]
                    ][
                        text "RESTful API for iPTMnet"
                    ],

                    div [
                        css [
                            marginTop (px 15)
                        ]
                    ][
                        text """
                        Though this website is an excellent resource for accessing and visualizing the data within iPTMnet, it does not provide an automated way of integrating iPTMnet data with existing tools and pipelines.
                        For this purpose, we have developed a RESTful API.
                        The API provides an efficient and automated means of retrieving the data from the iPTMnet database.
                        We have also developed Python and R packages that make it easy for new users to integrate iPTMnet into their existing tools.
                        """
                    ],

                    div [
                        css [
                            marginTop (px 20),
                            fontWeight bold,
                            fontSize (Css.em 1.0)
                        ]
                    ][
                        text "Interactive documentation of API (Swagger UI): "
                    ],

                    a [
                        href "https://research.bioinformatics.udel.edu/iptmnet/api/doc/",
                        css [
                            marginTop (px 15),
                            marginLeft (px 10)
                        ]
                    ][
                        text "https://research.bioinformatics.udel.edu/iptmnet/api/doc/"
                    ],

                    div [
                        css [
                            marginTop (px 30),
                            fontSize (Css.em 1.4)
                        ]
                    ][
                        text "Getting started"
                    ],
                    
                    div [
                        css [
                            marginTop (px 20),
                            fontWeight bold,
                            fontSize (Css.em 1.0)
                        ]
                    ][
                        text "R package"
                    ],

                    div [
                        css [
                            marginTop (px 15),
                            marginLeft (px 15),
                            display inline
                        ]
                    ][
                        div [
                            css [
                                display inline
                            ]
                        ][
                            text "Installation:"
                        ],
                        div [
                            css [
                                marginLeft (px 10),
                                paddingTop (px 5),
                                paddingBottom (px 5),
                                paddingLeft (px 10),
                                paddingRight (px 10),
                                backgroundColor (hex "#f7f7f7ff"),
                                display inline,
                                fontSize (Css.em 1.2),
                                fontFamilies ["Monospace"],
                                borderRadius (px 5)
                            ]
                        ][
                            text """
                            install.packages("iptmnetr") 
                            """
                        ]
                    ],

                    div [
                        css [
                            marginTop (px 15),
                            marginLeft (px 15),
                            display inline
                        ]
                    ][
                        div [
                            css [
                                display inline
                            ]
                        ][
                            text "Getting started:"
                        ],
                        a [
                            href "https://udel-cbcb.github.io/iptmnetr/#/?id=iptmnetr",
                            css [
                                marginLeft (px 10)
                            ]
                        ][
                            text """
                            https://udel-cbcb.github.io/iptmnetr/#/?id=iptmnetr
                            """
                        ]
                    ],

                    div [
                        css [
                            marginTop (px 15),
                            marginLeft (px 15),
                            display inline
                        ]
                    ][
                        div [
                            css [
                                display inline
                            ]
                        ][
                            text "Documentation:"
                        ],
                        a [
                            href "https://udel-cbcb.github.io/iptmnetr",
                            css [
                                marginLeft (px 10)
                            ]
                        ][
                            text """
                            https://udel-cbcb.github.io/iptmnetr
                            """
                        ]
                    ],

                    div [
                        css [
                            marginTop (px 20),
                            fontWeight bold,
                            fontSize (Css.em 1.0)
                        ]
                    ][
                        text "Python package"
                    ],

                    div [
                        css [
                            marginTop (px 15),
                            marginLeft (px 15),
                            display inline
                        ]
                    ][
                        div [
                            css [
                                display inline
                            ]
                        ][
                            text "Installation:"
                        ],
                        div [
                            css [
                                marginLeft (px 10),
                                paddingTop (px 5),
                                paddingBottom (px 5),
                                paddingLeft (px 10),
                                paddingRight (px 10),
                                backgroundColor (hex "#f7f7f7ff"),
                                display inline,
                                fontSize (Css.em 1.2),
                                fontFamilies ["Monospace"],
                                borderRadius (px 5)
                            ]
                        ][
                            text """
                            pip install pyiptmnet
                            """
                        ]
                    ],

                    div [
                        css [
                            marginTop (px 15),
                            marginLeft (px 15),
                            display inline
                        ]
                    ][
                        div [
                            css [
                                display inline
                            ]
                        ][
                            text "Getting started:"
                        ],
                        a [
                            href "https://udel-cbcb.github.io/pyiptmnet/#/?id=pyiptmnet",
                            css [
                                marginLeft (px 10)
                            ]
                        ][
                            text """
                            https://udel-cbcb.github.io/pyiptmnet/#/?id=pyiptmnet
                            """
                        ]
                    ],

                    div [
                        css [
                            marginTop (px 15),
                            marginLeft (px 15),
                            display inline
                        ]
                    ][
                        div [
                            css [
                                display inline
                            ]
                        ][
                            text "Documentation:"
                        ],
                        a [
                            href " https://udel-cbcb.github.io/pyiptmnet/ ",
                            css [
                                marginLeft (px 10)
                            ]
                        ][
                            text """
                            https://udel-cbcb.github.io/pyiptmnet/ 
                            """
                        ]
                    ],

                    div [
                        css [
                            marginTop (px 30),
                            fontSize (Css.em 1.4)
                        ]
                    ][
                        text "Contact"
                    ],

                    div [
                        css [
                            marginTop (px 20),
                            marginLeft (px 15)
                        ]
                    ][
                        text "If you have any problem with using the API or packages please send us an email on the following email id."
                    ],

                    div [
                        css [
                            marginLeft (px 15),
                            marginTop (px 20)
                        ]
                    ][
                        div [
                            css [
                                display inline
                            ]
                        ][
                            div [
                                css [
                                    display inline,
                                    fontWeight bold
                                ]
                            ][
                                text "Name"
                            ],

                            div [
                                css [
                                    display inline,
                                    marginLeft (px 5)
                                ]
                            ][
                                text ":"
                            ],

                            div [
                                css [
                                    display inline,
                                    marginLeft (px 5)
                                ]
                            ][
                                text "Sachin Gavali"
                            ]
                        ],
                        div [
                            css [
                                marginTop (px 10)
                            ]
                        ][
                            div [
                                css [
                                    display inline,
                                    fontWeight bold
                                ]
                            ][
                                text "Email"
                            ],

                            div [
                                css [
                                    display inline,
                                    marginLeft (px 5)
                                ]
                            ][
                                text ":"
                            ],

                            a [
                                href "mailto:saching@udel.edu",
                                css [
                                    display inline,
                                    marginLeft (px 5)
                                ]
                            ][
                                text "saching@udel.edu"
                            ]
                        ]
                    ]

                ]
            ],

            div[
                id "filler",css [alignSelf stretch ]]
            [],

            Views.Footer.view 

    ]