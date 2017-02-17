port module Toast.Ports exposing (..)

import Toast.Types exposing (..)
import Time exposing (..)

port notify : (Toast -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ notify AddToast
        , every 200 Tick
        ]
