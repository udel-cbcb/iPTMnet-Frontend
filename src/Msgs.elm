module Msgs exposing (..)

import RemoteData exposing (WebData)
import Model exposing (..)
import Navigation
import Dict exposing (..)
import FileReader exposing (NativeFile)

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
    | OnFetchStatistics (WebData (Statistics))
    | OnHomePageSearchInputChange String
    | OnAdvancedSearchVisibilityChange Bool
    | OnFetchSearchResults (WebData (List (SearchResult Organism)))
    | OnFileChange (List NativeFile)
    | OnFileContent (Result FileReader.Error String)
    | OnFetchBatchEnzymes  (WebData (List BatchEnzyme))
    | OnFetchBatchPTMPPI  (WebData (List BatchPTMPPI))
    | SwitchBatchOutput Model.Output
    | OnBatchInputChanged String
    | OnBatchInputExampleClicked
    | OnBatchClearClicked
    | OnSearchResultErrorButtonClicked
    | OnInfoErrorButtonClicked
    | OnSubstrateErrorButtonClicked
    | OnProteoformsErrorButtonClicked
    | OnPTMDepPPIErrorButtonClicked
    | OnProteoformsPPIErrorButtonClicked
    | OnSubstrateTabClick String
    | ScrollToElement String
    | OnSubstrateSearch String
    | OnProteoformSearch String
    | OnPTMPPISearch String
    | OnProteoformPPISearch String
    | ToggleCytoscapeItem CytoscapeItem
    | RemoveCytoscapeItem CytoscapeItem
    | CytoscapeClearClicked
    | SetSelectedPTMTypes (List String)
    | SearchRoleChanged String
    | SetSelectedTaxons (List String)
    | OnTermTypeSelected String
    | OnTaxonsUserInput String
    | OnBatchTabClick String

