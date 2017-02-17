module Main exposing (main)

import Html exposing (..)
import Toast.Model exposing (..)
import Toast.Ports exposing (..)
import Toast.Types exposing (..)
import Toast.Update exposing (..)
import Toast.View exposing (..)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }