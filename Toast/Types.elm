module Toast.Types exposing (..)
import Dict as Dict


type alias Toast =
    { title : String
    , body : String
    , url : Maybe String
    , class : String
    , pendingDelete : Bool
    }


type alias ToastId =
    Int


type alias Toasts = Dict.Dict ToastId Toast


type alias Model =
    { toasts : Toasts
    , toastCount : Int
    , hovering : Bool
    }

type Msg
    = AddToast Toast
    | ClickToast Toast
    | FadeOutToast ToastId ()
    | DeleteToast ToastId ()
    | HoverToasts
    | UnhoverToasts
