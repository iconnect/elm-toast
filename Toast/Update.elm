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
                Ok toast ->
                    let
                        toastCount =
                            model.toastCount + 1
                        toastId =
                            toastCount
                        toasts =
                            Dict.insert toastId toast model.toasts
                    in
                        ( { model | toasts = toasts, toastCount = toastCount }
                        , deleteToastCmd toastId
                        )


        DeleteToast toastId _ ->
            case model.hovering of
                True ->
                    ( model, Cmd.none)
                False ->
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


deleteToastCmd : ToastId -> Cmd Msg
deleteToastCmd toastId =
    Task.perform (DeleteToast toastId) (sleep 5000)


restartTasks : Toasts -> List (Cmd Msg)
restartTasks toasts =
    List.map (\(toastId, _) -> deleteToastCmd toastId) (Dict.toList toasts)
