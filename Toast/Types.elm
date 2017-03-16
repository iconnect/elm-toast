module Toast.Types exposing (..)

import Dict as Dict
import Json.Decode exposing (Decoder, Value, at, bool, field, string, map4, maybe)


type alias Config =
    { position : String
    }


type alias Toast =
    { title : String
    , body : String
    , url : Maybe String
    , class : String
    , pendingDelete : Bool
    }


type alias InputToast =
    { title : String
    , body : String
    , url : Maybe String
    , class : String
    }


liftToast : InputToast -> Toast
liftToast input =
    { title = input.title
    , body = input.body
    , url = input.url
    , class = input.class
    , pendingDelete = False
    }


toastDecoder : Decoder InputToast
toastDecoder =
    map4 InputToast
        (field "title" string)
        (field "body" string)
        (maybe (field "url" string))
        (field "class" string)


type alias ToastId =
    Int


type alias Toasts =
    Dict.Dict ToastId Toast


type alias Model =
    { toasts : Toasts
    , toastCount : Int
    , hovering : Bool
    , position : String
    }


type Msg
    = AddToast Value
    | ClickToast Toast
    | FadeOutToast ToastId ()
    | DeleteToast ToastId ()
    | HoverToasts
    | UnhoverToasts
