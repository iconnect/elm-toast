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
                newDict =
                    Dict.insert "321" toast model.toastsDict
            in
                ( { model | toastsDict = newDict }, fadeOutToast toast )

        ClickToast toasts ->
            ( model, Cmd.none )
        FadeOutToast toast _ ->
            case model.hovering of
                True ->
                    ( model, Cmd.none)
                False ->
                    let
                        newDict =
                            Dict.update "123" setPendDelete model.toastsDict
                    in
                        ( { model | toastsDict = newDict }, deleteToast toast)
        DeleteToast toast _ ->
            let
                newDict =
                    Dict.remove "123" model.toastsDict
            in
                ( { model | toastsDict = newDict }, Cmd.none )
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



findAndTrashToast : Model -> Toast -> Toasts
findAndTrashToast model toast =
    List.map (maybeTrash toast) model.toasts


maybeTrash : Toast -> Toast -> Toast
maybeTrash toastToDelete toast =
    case toastToDelete == toast of
        True ->
            trashToast toast
        False ->
            toast


cleanupToasts : Model -> Model
cleanupToasts model =
    let
        newToasts =
            List.map (cleanupToast model) model.toasts
    in
        { model | toasts = newToasts }


cleanupToast : Model -> Toast -> Toast
cleanupToast model toast =
    case toastExpired model toast of
        True ->
            trashToast toast
        False ->
            toast


toastExpired : Model -> Toast -> Bool
toastExpired model toast =
    model.currentTime > toast.expires


trashToast : Toast -> Toast
trashToast toast =
    { toast | pendingDelete = True }


bulkTask : Toasts -> List (Cmd Msg)
bulkTask toasts =
    List.map fadeOutToast toasts

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
