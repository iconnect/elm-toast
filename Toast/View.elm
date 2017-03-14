module Toast.View exposing (..)

import Toast.Types exposing (..)
import Dict as Dict
import Html exposing (..)
import Html.Attributes exposing (class, src, id, classList)
import Html.Events exposing (onClick, onMouseEnter, onMouseLeave)


viewToast : Toast -> Html Msg
viewToast toast =
    div [ classList [ ("toast", True), ("remove", toast.pendingDelete) ] ]
        [ div [ class ("toast-content " ++ toast.class) ]
            [ div [ class "toast-header" ]
                [ text toast.title ]
            , div [ class "toast-body" ]
                [ text toast.body ]
            ]
        ]


viewToasts : Dict.Dict comparable Toast -> List (Html Msg)
viewToasts toasts =
    List.map (\(_, toast) -> viewToast toast) (Dict.toList toasts)


view : Model -> Html Msg
view model =
    div [ class model.position, id "toast-container", onMouseEnter HoverToasts, onMouseLeave UnhoverToasts ]
        <| viewToasts model.toasts
