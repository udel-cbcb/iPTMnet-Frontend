module Main exposing (..)
import Html.Styled exposing (..)
import Home

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
view model = Home.view   


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