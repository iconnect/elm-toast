module Toast.Types exposing (..)


type alias Toast =
    { title : String
    , body : String
    , url : Maybe String
    , style : String
    }


type alias Toasts = List Toast


type alias Model =
    { toasts : Toasts
    }

type Msg
    = AddToast Toast
    | ClickToast Toast
