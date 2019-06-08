module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
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
        , button [ onClick ChoiceRock ] [ text "Rock" ]
        , button [ onClick ChoicePaper ] [ text "Paper" ]
        , button [ onClick ChoiceScissors ] [ text "Scissors" ]
        , h2 [] [ displayResult model ]
        , displayModelContents model
        ]

displayResult : Model -> Html Msg
displayResult  model =
    case model.myHand of
        1-> -- My hand is Rock
            div [] [ createResult model "Draw" "Lose" "Win" ]
        
        2 -> -- My hand is Paper
            div [] [ createResult model "Win" "Draw" "Lose" ]
        
        3 -> --My hand is Scissors
            div [] [ createResult model "Lose" "Win" "Draw" ]

        _ ->
            div [] [ text "Result: " ]

createResult : Model -> String -> String -> String -> Html Msg
createResult model vsRock vsPaper vsScissors =
    text ("Result: " ++ (if model.opponentHand == 1  then  vsRock else (if model.opponentHand == 2 then vsPaper else vsScissors)))

--DEBUG--
displayModelContents : Model -> Html Msg
displayModelContents model =
    div []
        [ text "--debug--"
        , p [] [ text ("opponentHand: " ++ (String.fromInt model.opponentHand)) ] 
        , p [] [ text ("myHand: " ++ (String.fromInt model.myHand)) ]
        ]