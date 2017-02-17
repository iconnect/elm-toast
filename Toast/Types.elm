module Toast.Types exposing (..)
import Time exposing (Time)


type alias Toast =
    { title : String
    , body : String
    , url : Maybe String
    , style : String
    , expires : Time
    , pendingDelete : Bool
    }


type alias Toasts = List Toast


type alias Model =
    { toasts : Toasts
    , currentTime : Float
    }

type Msg
    = AddToast Toast
    | ClickToast Toast
    | Tick Time
    | FadeOutToast Toast ()
    | DeleteToast Toast ()
