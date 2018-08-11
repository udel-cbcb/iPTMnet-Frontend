module Model.EntryPage exposing (..)
import Model.Info as Info exposing (..)
import Model.Proteoform as Proteoform exposing (..)
import Model.CytoscapeItem exposing (..)
import Model.PTMDependentPPI as PTMDependentPPI exposing (..)
import Model.ProteoformPPI as ProteoformPPI exposing (..)
import Model.Substrate as Substrate exposing (..)


type alias EntryPage = 
    {
        cytoscapeItems: List CytoscapeItem,
        infoData: InfoData,
        showInfoErrorMsg: Bool,
        proteoformsData: ProteoformsData,
        showProteoformsErrorMsg: Bool,
        ptmDependentPPIData: PTMDependentPPIData,
        showPTMDepPPIErrorMsg: Bool,
        proteoformPPIData: ProteoformPPIData,
        showProteoformsPPIErrorMsg: Bool,
        substrateData: SubstrateData,
        showSubstrateErrorMsg: Bool
    }

setInfo : EntryPage -> InfoData -> EntryPage
setInfo entryPage newInfo =
    { entryPage | infoData = newInfo }

setSubstrateData: EntryPage -> SubstrateData -> EntryPage
setSubstrateData entryPage newData = 
    { entryPage | substrateData = newData }

setCytoscapeItems: EntryPage -> List (CytoscapeItem) -> EntryPage 
setCytoscapeItems entryPage newCytoscapeItems =
   {entryPage | cytoscapeItems= newCytoscapeItems}

setProteoformsData: EntryPage -> ProteoformsData -> EntryPage
setProteoformsData entryPage newProteoformsData = 
    { entryPage | proteoformsData = newProteoformsData}

setPTMDependentPPIData: EntryPage -> PTMDependentPPIData -> EntryPage
setPTMDependentPPIData entryPage newData = 
    { entryPage | ptmDependentPPIData = newData}

setProteoformPPIData: EntryPage -> ProteoformPPIData -> EntryPage
setProteoformPPIData entryPage newData = 
    { entryPage | proteoformPPIData = newData}

setShowInfoErrorMsg: Bool -> EntryPage -> EntryPage
setShowInfoErrorMsg newValue entryPage = 
    { entryPage | showInfoErrorMsg = newValue}

setShowSubstrateErrorMsg: Bool -> EntryPage -> EntryPage
setShowSubstrateErrorMsg newValue entryPage = 
    { entryPage | showSubstrateErrorMsg = newValue}

setShowProteoformsErrorMsg: Bool -> EntryPage -> EntryPage
setShowProteoformsErrorMsg newValue entryPage = 
    { entryPage | showProteoformsErrorMsg = newValue}

setShowPTMDepPPIErrorMsg: Bool -> EntryPage -> EntryPage
setShowPTMDepPPIErrorMsg newValue entryPage = 
    { entryPage | showPTMDepPPIErrorMsg = newValue}

setShowProteoformsPPIErrorMsg: Bool -> EntryPage -> EntryPage
setShowProteoformsPPIErrorMsg newValue entryPage = 
    { entryPage | showProteoformsPPIErrorMsg = newValue}


initialModel : EntryPage 
initialModel = 
    {
        cytoscapeItems = [],
        infoData = Info.initialData,
        showInfoErrorMsg = False,
        proteoformsData = Proteoform.initialData,
        showProteoformsErrorMsg = False,
        ptmDependentPPIData = PTMDependentPPI.initialData,
        showPTMDepPPIErrorMsg = False,
        proteoformPPIData = ProteoformPPI.initialData,
        showProteoformsPPIErrorMsg = False,
        substrateData = Substrate.initialData,
        showSubstrateErrorMsg = False
    }
