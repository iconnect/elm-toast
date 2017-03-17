module Toast.View exposing (..)


import Toast.Types exposing (..)
import Dict
import Html exposing (..)
import Html.Attributes exposing (class, href, id)
import Html.Events exposing (onClick, onMouseEnter, onMouseLeave)


view : Model -> Html Msg
view model =
    div [ id "toast-container"
        , class model.position
        , onMouseEnter HoverToasts
        , onMouseLeave UnhoverToasts
        ] <| viewToasts model.toasts


viewToasts : Dict.Dict comparable Toast -> List (Html Msg)
viewToasts toasts =
    List.map (\(_, toast) -> viewToast toast) (Dict.toList toasts)


viewToast : Toast -> Html Msg
viewToast toast =
    div [ class "toast" ]
        [ div
            [ viewContentClass toast ]
            [ viewContentHeader toast
            , viewContentBody toast
            ]
        , viewToastLink toast
        ]


viewContentClass : Toast -> Attribute Msg
viewContentClass toast =
    case toast.class of
        Just toastClass ->
            class ("toast-content " ++ toastClass)
        Nothing ->
            class "toast-content"


viewContentHeader : Toast -> Html Msg
viewContentHeader toast =
    case toast.title of
        Just toastTitle ->
            div [ class "toast-header" ]
                [ text toastTitle ]
        Nothing ->
            text ""


viewContentBody : Toast -> Html Msg
viewContentBody toast =
    case toast.body of
        Just toastBody ->
            div [ class "toast-body" ]
                [ text toastBody ]
        Nothing ->
            text ""


viewToastLink : Toast -> Html Msg
viewToastLink toast =
    case toast.url of
        Just toastUrl ->
            a [ class "link", href toastUrl ] []
        Nothing ->
            text ""
