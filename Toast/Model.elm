module Toast.Model exposing (..)


import Toast.Types exposing (..)
import Dict


init : Config -> ( Model, Cmd Msg )
init config =
    let
        model =
            { toasts = Dict.empty
            , toastCount = 0
            , hovering = False
            , position = config.position
            }
    in
        ( model, Cmd.none )
