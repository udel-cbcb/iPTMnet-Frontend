module Msgs exposing (..)

import RemoteData exposing (WebData)
import Model exposing (..)
import Navigation


-- MESSAGES
type Msg
    = NoOp
    | OnFetchInfo (WebData (Info))
    | OnFetchProteoform (WebData (List (Proteoform Entity Source)))
    | ChangeLocation String
    | OnLocationChange Navigation.Location
