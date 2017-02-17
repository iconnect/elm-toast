module Toast.Model exposing (..)

import Toast.Ports exposing (..)
import Toast.Types exposing (..)

init : ( Model, Cmd Msg )
init =
    ( Model [], Cmd.none )
