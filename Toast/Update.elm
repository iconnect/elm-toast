module Toast.Update exposing (..)


import Toast.Types exposing (..)
import Dict
import Json.Decode exposing (decodeValue)
import Process exposing (sleep)
import Task exposing (perform)
import Time exposing (millisecond)


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
                        , deleteToastCmd toastId toast.duration
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


deleteToastCmd : ToastId -> Duration -> Cmd Msg
deleteToastCmd toastId duration =
    perform (DeleteToast toastId) (sleep (toastDuration duration))


toastDuration : Duration -> Time.Time
toastDuration duration =
    millisecond * (Maybe.withDefault 5000 duration)


restartTasks : Toasts -> List (Cmd Msg)
restartTasks toasts =
    List.map (\(toastId, t) -> deleteToastCmd toastId t.duration) (Dict.toList toasts)


setHovering : Model -> Bool -> Model
setHovering model bool =
    { model | hovering = bool }
