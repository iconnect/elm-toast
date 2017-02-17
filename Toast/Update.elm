module Toast.Update exposing (..)

import Toast.Ports exposing (..)
import Toast.Types exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddToast toast ->
            ( { model | toasts = model.toasts ++ [toast] }, Cmd.none )
        ClickToast toasts ->
            ( model, Cmd.none )
