module Toast.Types exposing (..)


import Dict
import Json.Decode exposing (Decoder, Value, field, float, map5, maybe, string)


type alias Config =
    { position : String
    }


type alias Toast =
    { title : Maybe String
    , body : Maybe String
    , url : Maybe String
    , class : Maybe String
    , duration : Duration
    }


toastDecoder : Decoder Toast
toastDecoder =
    map5 Toast
        (maybe (field "title" string))
        (maybe (field "body" string))
        (maybe (field "url" string))
        (maybe (field "class" string))
        (maybe (field "duration" float))


type alias Duration =
    Maybe Float


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
