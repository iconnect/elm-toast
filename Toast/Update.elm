module Toast.Update exposing (..)

import Toast.Types exposing (..)
import Task exposing (..)
import Process exposing (sleep)
import Dict as Dict
import Json.Decode exposing (decodeValue)
import Result exposing (Result(..))

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddToast value ->
            case decodeValue toastDecoder value of
                Err _ ->
                    (model, Cmd.none)
                Ok inputToast ->
                    let
                        toast =
                            liftToast inputToast

                        toastCount =
                            model.toastCount + 1
                        toastId =
                            toastCount
                        toasts =
                            Dict.insert toastId toast model.toasts
                    in
                        Debug.log "" ( { model | toasts = toasts, toastCount = toastCount }
                        , fadeOutToastCmd toastId
                        )


        ClickToast toasts ->
            ( model, Cmd.none )


        FadeOutToast toastId _ ->
            case model.hovering of
                True ->
                    ( model, Cmd.none)
                False ->
                    let
                        toasts =
                            Dict.update toastId setPendDelete model.toasts
                    in
                        ( { model | toasts = toasts }
                        , deleteToastCmd toastId
                        )


        DeleteToast toastId _ ->
            let
                toasts =
                    Dict.remove toastId model.toasts
            in
                ( { model | toasts = toasts }
                , Cmd.none
                )

        HoverToasts ->
            ( setHovering model True
            , Cmd.none
            )

        UnhoverToasts ->
            ( setHovering model False
            , Cmd.batch (restartTasks model.toasts)
            )

setHovering : Model -> Bool -> Model
setHovering model bool =
    { model | hovering = bool }


fadeOutToastCmd : ToastId -> Cmd Msg
fadeOutToastCmd toastId =
    Task.perform (FadeOutToast toastId) (sleep 3000)


deleteToastCmd : ToastId -> Cmd Msg
deleteToastCmd toastId =
    Task.perform (DeleteToast toastId) (sleep 200)


restartTasks : Toasts -> List (Cmd Msg)
restartTasks toasts =
    List.map (\(toastId, _) -> fadeOutToastCmd toastId) (Dict.toList toasts)

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
