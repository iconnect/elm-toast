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


type alias Toasts = List Toast

type alias ToastDict = Dict.Dict ToastId Toast

type alias Model =
    { toasts : Toasts
    , currentTime : Float
    , hovering : Bool
    , toastsDict : ToastDict
    }

type Msg
    = AddToast Toast
    | ClickToast Toast
    | FadeOutToast Toast ()
    | DeleteToast Toast ()
    | HoverToasts
    | UnhoverToasts
