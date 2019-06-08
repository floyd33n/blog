module Main exposing (..)

import Browser
import Html exposing (..)

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
    ()

init : () -> ( Model, Cmd Msg )
init _ =
    ( (), Cmd.none )

--UPDATE--
type alias Msg =
    Never

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

--SUBSCRIPTIONS--
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

--VIEW--
view : Model -> Html Msg
view model =
    div [] []