module Toast exposing (main)

import Html exposing (..)
import Toast.Model exposing (..)
import Toast.Ports exposing (..)
import Toast.Types exposing (..)
import Toast.Update exposing (..)
import Toast.View exposing (..)


main : Program Config Model Msg
main =
    programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
