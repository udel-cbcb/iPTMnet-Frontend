module Msgs exposing (..)

import RemoteData exposing (WebData)
import Model exposing (..)
import Navigation
import Dict exposing (..)

-- MESSAGES
type Msg
    = NoOp
    | ChangeLocation String
    | OnLocationChange Navigation.Location
    | OnFetchInfo (WebData (Info))
    | OnFetchProteoform (WebData (List (Proteoform Enzyme Source)))
    | OnFetchPTMDependentPPI (WebData (List (PTMDependentPPI Entity Source)))
    | OnFetchProteoformPPI (WebData (List (ProteoformPPI Protein Source)))
    | OnFetchSubstrates (WebData (Dict String (List (Substrate Source SubstrateEnzyme))))
