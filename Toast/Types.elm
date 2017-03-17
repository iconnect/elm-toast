module Toast.Types exposing (..)

import Dict as Dict
import Json.Decode exposing (Decoder, Value, at, bool, field, string, map4, maybe)


type alias Config =
    { position : String
    }


type alias Toast =
    { title : Maybe String
    , body : Maybe String
    , url : Maybe String
    , class : Maybe String
    }


toastDecoder : Decoder Toast
toastDecoder =
    map4 Toast
        (maybe (field "title" string))
        (maybe (field "body" string))
        (maybe (field "url" string))
        (maybe (field "class" string))


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
    | DeleteToast ToastId ()
    | HoverToasts
    | UnhoverToasts
