module Home exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import Html.Styled.Events exposing (onClick,onWithOptions)
import Json.Decode as Decode

{-|
When clicking a link we want to prevent the default browser behaviour which is to load a new page.
So we use `onWithOptions` instead of `onClick`.
-}
onLinkClick : msg -> Attribute msg
onLinkClick message =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed message)


view : Model -> Html Msg
view model =
        div [id "page",css [
            Css.property "height" "100%",
            displayFlex,
            flexDirection column,
            alignItems center,
            flex (num 1)
            ]
        ] [

        div [id "header", css [
            Css.height (px 100),
            alignSelf stretch,
            backgroundColor (hex "#4169E1")
            ]] [],
        
        div [id "body", css [
            displayFlex,
            flexDirection column,
            alignItems center,
            flexGrow (num 1)
            ]] [
        div [ id "main_section", css [
                    backgroundColor (hex "#eee"),
                    Css.width (px 900),
                    padding (px 10),
                    displayFlex,
                    flexDirection row
                ]
            ] [
                        
            div [id "iptmnet_description", css []]
            [ 
            h2 [] [text "iPTMnet"],
            p [] [text "iPTMnet is a bioinformatics resource for integrated understanding of protein post-translational modifications (PTMs) in systems biology context."],
            p [] [text "It connects multiple disparate bioinformatics tools and systems text mining, data mining, analysis and visualization tools, and databases and ontologies into an integrated cross-cutting research resource to address the knowledge gaps in exploring and discovering PTM networks."],
            ul [] [
                li[][a [href "/entry", onLinkClick (ChangeLocation "/entry") ] [text "Browse"]],
                li[][a [href "/stats"] [text "Statistics"]],
                li[][a [href "/info"] [text "Project Info"]],
                li[][a [href "/help"] [text "Help"]],
                li[][a [href "/license"] [text "License"]],
                li[][a [href "/citation"] [text "Citation"]]
                ] 
            ],
         
            div [id "nsf-grant", css [
                    displayFlex,
                    flexDirection column,
                    alignItems center
            ] ] [
                -- nsf
                div [css [
                    displayFlex,
                    flexDirection row,
                    alignItems center
                ]] [
                    img [src "images/nsf.png", css[
                        padding (px 5)
                        ]][],
                    a [css [fontSize (px 13)], href "http://nsf.gov/awardsearch/showAward.do?AwardNumber=1062520"] [text "NSF grants ABI-1062520"]
                ],
                span [css [fontSize (px 13)]] [text "NIH/NIGMS grants U01GM120953"], 
                img [src "images/logo.png", css[
                    Css.maxWidth (px 250),
                    padding (px 10)
                ]][]
            ]
        ],
            
         -- Search iPTMnET
         div [id "search_iptmnet_section", css [
                    backgroundColor (hex "#eee"),
                    backgroundColor (hex "#eee"),
                    borderWidth (px 1),
                    borderStyle solid,
                    borderColor (rgb 225 225 232),
                    borderRadius (px 4),
                    Css.width (px 900),
                    margin (px 20),
                    padding (px 10),
                    displayFlex,
                    flexDirection column
                ] ]
            [ 
            h4 [] [text "Search for proteins in iPTMnet database"],
            div [id "search_iptmnet", css [
                    displayFlex,
                    flexDirection row,
                    justifyContent flexStart,
                    marginBottom (px 10)
                ]] [
                select [css[flexGrow (num 0.5)]][
                    option [value "all"] [text "All"],
                    option [value "uniprot"] [text "Uniprot AC/ID"],
                    option [value "name"] [text "Protein/Gene Name"],
                    option [value "pmid"] [text "PMID"]
                ],
                input [maxlength 200, placeholder "Search",css[
                    flexGrow (num 7.5),
                    marginLeft (px 10),
                    marginRight (px 10),
                    paddingLeft (px 10),
                    paddingRight (px 10),
                    paddingTop (px 5),
                    paddingBottom (px 5)
                    ]] [],
                button [
                    css[flexGrow (num 1),
                    marginRight (px 10)
                    ]][text "Submit"],
                button [
                    css[flexGrow (num 1)
                    ]][text "Reset"]
            ] 
        ],
        
        -- Search iPTMnET
         div [id "search_rlimsp_section", css [
                    backgroundColor (hex "#eee"),
                    borderWidth (px 1),
                    borderStyle solid,
                    borderColor (rgb 225 225 232),
                    borderRadius (px 4),
                    Css.width (px 900),
                    margin (px 20),
                    padding (px 10),
                    displayFlex,
                    flexDirection row
                ] ]
            [
                div [css[
                    displayFlex,
                    flexDirection column,
                    flexGrow (num 80)
                ]] [
                    h4 [] [text "Search phosphorylation information in the literature"],
                    span [css[fontSize (px 14)]] [text "Enter Keywords (accepts Boolean operators (AND, OR, NOT))"],
                    div [id "search_rlimsp", css [
                            displayFlex,
                            flexDirection row,
                            justifyContent flexStart,
                            marginBottom (px 10)
                        ]] [
                        input [maxlength 200, placeholder "Search",css[
                            flexGrow (num 7.5),
                            marginRight (px 10),
                            paddingLeft (px 10),
                            paddingRight (px 10),
                            paddingTop (px 5),
                            paddingBottom (px 5)
                            ]] [],
                        button [
                            css[flexGrow (num 1),
                            marginRight (px 10)
                            ]][text "Submit"],
                        button [
                            css[flexGrow (num 1)
                            ]][text "Reset"]
                    ] 
                ],
                img [src "images/rlimsp.jpg", css[
                    maxHeight (px 60),
                    padding (px 10)
                ]][] 
        ],

    
        div[id "filler",css [alignSelf stretch ]][]

        ], -- end all

        div [id "footer", css [
            Css.height (px 100),
            alignSelf stretch,
            backgroundColor (hex "#4169E1")
        ]] []

    ]
