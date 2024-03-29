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

type Hand
    = Rock
    | Paper
    | Scissors

type alias Model =
    { opponentHand : Hand
    , myHand : Hand
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Rock Rock
    , Cmd.none
    )


--UPDATE--

genHand : Cmd Msg
genHand =
    Random.generate NewHand (Random.uniform Rock [Paper, Scissors])

type Msg
    = ChoiceRock
    | ChoicePaper
    | ChoiceScissors
    | NewHand Hand

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChoiceRock ->
            ( { model | myHand = Rock }
            , genHand
            )
        
        ChoicePaper ->
            ( { model | myHand = Paper }
            , genHand
            )
        
        ChoiceScissors ->
            ( { model | myHand = Scissors }
            , genHand
            )

        NewHand newHand ->
            ( { model | opponentHand = newHand }
            , Cmd.none
            )


--subscriptions--

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


--VIEW--

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Rock-paper-scissors" ]
        , h2 [] [ text "Choice Hand" ]
        , button [ onClick ChoiceRock ] [ text "Rock" ]
        , button [ onClick ChoicePaper ] [ text "Paper" ]
        , button [ onClick ChoiceScissors ] [ text "Scissors" ]
        , h2 [] [ text ("Result: " ++ (createResult model)) ]
        ]

createResult : Model -> String
createResult model =
    case (model.myHand, model.opponentHand) of
        (Rock, Rock) ->
            "Draw"

        (Rock, Paper) ->
            "Lose"

        (Rock, Scissors) ->
            "Win"
        
        (Paper, Rock) ->
            "Win"
        
        (Paper, Paper) ->
            "Draw"

        (Paper, Scissors) ->
            "Lose"
        
        (Scissors, Rock) ->
            "Lose"

        (Scissors, Paper) ->
            "Win"
        
        (Scissors, Scissors) ->
            "Draw"