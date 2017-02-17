module Toast.View exposing (..)

import Toast.Types exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src, id)
import Html.Events exposing (onClick)


viewToast : Toast -> Html Msg
viewToast toast =
    div [ class ("toast " ++ (toString toast.pendingDelete))]
        [ div [ class "toast-content green" ]
            [ div [ class "toast-header" ]
                [ text toast.title ]
            , div [ class "toast-body" ]
                [ text toast.body ]
            ]
        ]


viewToasts : Toasts -> List (Html Msg)
viewToasts toasts =
    List.map viewToast toasts


view : Model -> Html Msg
view model =
    div [ class "top-right", id "toast-container" ]
        <| viewToasts model.toasts
