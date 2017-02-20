module Toast.Types exposing (..)
import Time exposing (Time)
import Dict as Dict


type alias Toast =
    { title : String
    , body : String
    , url : Maybe String
    , style : String
    , expires : Time
    , pendingDelete : Bool
    }


type alias ToastId =
    String


type alias Toasts = Dict.Dict ToastId Toast


type alias Model =
    { toasts : Toasts
    , currentTime : Float
    , hovering : Bool
    }

type Msg
    = AddToast Toast
    | ClickToast Toast
    | FadeOutToast Toast ()
    | DeleteToast Toast ()
    | HoverToasts
    | UnhoverToasts
