port module Toast.Ports exposing (..)

import Json.Decode exposing (Value)
import Toast.Types exposing (..)

port notify : (Value -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ notify AddToast
        ]
