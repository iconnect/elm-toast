port module Toast.Ports exposing (..)

import Toast.Types exposing (..)

port notify : (Toast -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ notify AddToast
        ]
