module Main exposing (..)

import Browser
import Html exposing (..)
import Random

--MAIN--
main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

--MODEL--
type alias Model =
    { opponentHand : Int
    , myHand : Int
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1 -1
    , Cmd.none
    )

--UPDATE--
genNumber : Cmd Msg
genNumber =
    Random.generate NewNumber (Random.int 1 3)

type Msg
    = ChoiceRock
    | ChoicePaper
    | ChoiceScissors
    | NewNumber Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ChoiceRock ->
            ( { model | myHand = 1 }
            , genNumber
            )

        ChoicePaper  ->
            ( { model | myHand = 2 }
            , genNumber
            )

        ChoiceScissors  ->
            ( { model | myHand = 3 }
            , genNumber
            )

        NewNumber newNumber ->
            ( { model | opponentHand = newNumber }
            , Cmd.none
            )


--SUBSCRIPTIONS--
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

--VIEW--
view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Rock-paper-scissors" ]
        , h2 [] [ text "Choice your hand" ]
        , button [] [ text "Rock" ]
        , button [] [ text "Paper" ]
        , button [] [ text "Scissors" ]
        , h2 [] [ text "Result: " ]
        ]