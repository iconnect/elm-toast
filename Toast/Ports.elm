port module Toast.Ports exposing (..)


import Toast.Types exposing (..)
import Json.Decode exposing (Value)


port notify : (Value -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ notify AddToast
        ]
