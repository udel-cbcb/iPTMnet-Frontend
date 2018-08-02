module Msgs exposing (..)

import RemoteData exposing (WebData)
import Navigation
import Dict exposing (..)
import FileReader exposing (NativeFile)
import Array exposing (..)
import Model.Info exposing (..)
import Model.Proteoform exposing (..)
import Model.PTMDependentPPI exposing (..)
import Model.ProteoformPPI exposing (..)
import Model.Substrate exposing (..)
import Model.Statistics exposing (..)
import Model.Alignment exposing (..)
import Model.SearchResult exposing (..)
import Model.BatchEnzyme exposing (..)
import Model.BatchPTMPPI exposing (..)
import Model.BatchPage
import Model.CytoscapeItem exposing (..)


-- MESSAGES
type Msg
    = NoOp
    | ChangeLocation String
    | OnLocationChange Navigation.Location
    | OnFetchInfo (WebData (Info))
    | OnFetchProteoform (WebData (List Proteoform))
    | OnFetchPTMDependentPPI (WebData (List PTMDependentPPI))
    | OnFetchProteoformPPI (WebData (List ProteoformPPI))
    | OnFetchSubstrates (WebData (Dict String (List Substrate )))
    | OnFetchStatistics (WebData (Statistics))
    | OnFetchAlignment (WebData (Array Alignment))
    | OnHomePageSearchInputChange String
    | OnHomePageSearchKeyDown Int
    | OnAdvancedSearchVisibilityChange Bool
    | OnFetchSearchResults SearchData
    | OnFileChange (List NativeFile)
    | OnFileContent (Result FileReader.Error String)
    | OnFetchBatchEnzymes  (WebData (List BatchEnzyme))
    | OnFetchBatchPTMPPI  (WebData (List BatchPTMPPI))
    | SwitchBatchOutput Model.BatchPage.Output
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
    | OnSequenceHover Int Int

