module Toast.Update exposing (..)

import Toast.Ports exposing (..)
import Toast.Types exposing (..)
import Task exposing (..)
import Process exposing (sleep)
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
                ( { model | toasts = newToasts }, Cmd.batch [ fadeOutToast newToast, deleteToast newToast ] )
        ClickToast toasts ->
            ( model, Cmd.none )
        Tick time ->
            ( { model | currentTime = time }, Cmd.none )
        FadeOutToast toast _ ->
            let
                newToasts =
                    List.map (changeClass toast) model.toasts
            in
                ( { model | toasts = newToasts }, Cmd.none )

        DeleteToast toast _ ->
            let
                newToasts =
                    List.filter (\t -> t.expires /= toast.expires) model.toasts
            in
                ( { model | toasts = newToasts }, Cmd.none )

fadeOutToast : Toast -> Cmd Msg
fadeOutToast toast =
    Task.perform (FadeOutToast toast) (sleep 4800)

deleteToast : Toast -> Cmd Msg
deleteToast toast =
    Task.perform (DeleteToast toast) (sleep 5000)

changeClass : Toast -> Toast -> Toast
changeClass newToast toast =
    if newToast == toast then
        { toast | pendingDelete = True }
    else
        toast
