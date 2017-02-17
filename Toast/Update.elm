module Toast.Update exposing (..)

import Toast.Ports exposing (..)
import Toast.Types exposing (..)

import Time exposing (Time, second)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddToast toast ->
            let
                expiresAt =
                    model.currentTime + (5 * second)
                newToast =
                    { toast | expires = expiresAt }
                newToasts =
                    model.toasts ++ [newToast]
            in
                ( { model | toasts = newToasts }, Cmd.none )
        ClickToast toasts ->
            ( model, Cmd.none )
        Tick time ->
            let
                newToasts =
                    List.filterMap (mutateToast time) model.toasts
            in
                ( { model | currentTime = time, toasts = newToasts }, Cmd.none )


mutateToast : Time -> Toast -> Maybe Toast
mutateToast time toast =
      if toast.pendingDelete then
        Nothing
      else if isExpired time toast then
        Just { toast | pendingDelete = True }
      else
        Just toast


isExpired : Time -> Toast -> Bool
isExpired time toast =
    time > toast.expires
