module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )



-- MESSAGES


type Msg
    = NoOp



-- VIEW


view : Model -> Html Msg
view model =
    div [] [
        div []
        [ 
          h2 [] [text "iPTMnet"],
          p [] [text "iPTMnet is a bioinformatics resource for integrated understanding of protein post-translational modifications (PTMs) in systems biology context."],
          p [] [text "It connects multiple disparate bioinformatics tools and systems text mining, data mining, analysis and visualization tools, and databases and ontologies into an integrated cross-cutting research resource to address the knowledge gaps in exploring and discovering PTM networks."],
          ul [] [
              li[][a [href "/browse"] [text "Browse"]],
              li[][a [href "/stats"] [text "Statistics"]],
              li[][a [href "/info"] [text "Project Info"]],
              li[][a [href "/help"] [text "Help"]],
              li[][a [href "/license"] [text "License"]],
              li[][a [href "/citation"] [text "Citation"]]
            ] 
        ],
        div []
        [ 
          h4 [] [text "Search for proteins in iPTMnet database"],
          div [] [
              select [][
                  option [value "all"] [text "All"],
                  option [value "uniprot"] [text "Uniprot AC/ID"],
                  option [value "name"] [text "Protein/Gene Name"],
                  option [value "pmid"] [text "PMID"]
              ],
              input [maxlength 200, placeholder "Search"] [],
              button [][text "Submit"],
              button [][text "Reset"]
          ] 
        ]

    ]
    




-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }