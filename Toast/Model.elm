module Toast.Model exposing (..)

import Toast.Types exposing (..)

import Dict as Dict

init : ( Model, Cmd Msg )
init =
    ( Model [] 0 False Dict.empty, Cmd.none )
