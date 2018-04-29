module Msgs exposing (..)

import RemoteData exposing (WebData)
import Model exposing (Info)

-- MESSAGES
type Msg
    = NoOp
    | OnFetchInfo (WebData (Info))
