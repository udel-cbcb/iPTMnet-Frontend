module Msgs exposing (..)

import RemoteData exposing (WebData)
import Model exposing (Info)
import Navigation
import UrlParser

-- MESSAGES
type Msg
    = NoOp
    | OnFetchInfo (WebData (Info))
    | ChangeLocation String
    | OnLocationChange Navigation.Location
