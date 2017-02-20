module Toast.Update exposing (..)

import Toast.Types exposing (..)
import Task exposing (..)
import Process exposing (sleep)
import Dict as Dict

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddToast toast ->
            let
                toasts =
                    Dict.insert "321" toast model.toasts
            in
                ( { model | toasts = toasts }, fadeOutToast toast )

        ClickToast toasts ->
            ( model, Cmd.none )
        FadeOutToast toast _ ->
            case model.hovering of
                True ->
                    ( model, Cmd.none)
                False ->
                    let
                        toasts =
                            Dict.update "321" setPendDelete model.toasts
                    in
                        ( { model | toasts = toasts }, deleteToast toast)
        DeleteToast toast _ ->
            let
                toasts =
                    Dict.remove "321" model.toasts
            in
                ( { model | toasts = toasts }, Cmd.none )
        HoverToasts ->
            ( { model | hovering = True }, Cmd.none )
        UnhoverToasts ->
            ( { model | hovering = False }, Cmd.batch (bulkTask model.toasts) )


fadeOutToast : Toast -> Cmd Msg
fadeOutToast toast =
    Task.perform (FadeOutToast toast) (sleep 3000)

deleteToast : Toast -> Cmd Msg
deleteToast toast =
    Task.perform (DeleteToast toast) (sleep 200)

bulkTask : Toasts -> List (Cmd Msg)
bulkTask toasts =
    List.map (\(_, toast) -> fadeOutToast toast) (Dict.toList toasts)

setPendDelete : Maybe Toast -> Maybe Toast
setPendDelete toast =
    case toast of
        Just toast ->
            let
                newToast =
                    { toast | pendingDelete = True }
            in
                Just newToast
        Nothing ->
            Nothing
