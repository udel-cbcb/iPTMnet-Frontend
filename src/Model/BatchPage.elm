module Model.BatchPage exposing (..)

import Model.BatchEnzyme exposing (..)
import Model.Kinase exposing (..)
import Model.BatchPTMPPI exposing (..)

type Output = Enzymes
              | PTMPPI

type alias BatchPage = 
 {
     kinases: List (Kinase),
     outputType: Output,
     batchEnzymeData : BatchEnzymeData,
     batchPTMPPIData : BatchPTMPPIData,
     selectedTab : String,
     inputText : String 
 }

setKinases: (List Kinase) -> BatchPage -> BatchPage
setKinases newKinases batchPage =
    { batchPage | kinases = newKinases }


setBatchOutput: BatchPage -> Output -> BatchPage
setBatchOutput batchPage newOutput =
    { batchPage | outputType = newOutput }

setBatchEnzymeData: BatchPage -> BatchEnzymeData -> BatchPage
setBatchEnzymeData batchPage newData = 
    { batchPage | batchEnzymeData = newData }

setBatchPTMPPIData: BatchPage -> BatchPTMPPIData -> BatchPage
setBatchPTMPPIData batchPage newData = 
    { batchPage | batchPTMPPIData = newData }

setBatchInputText: String -> BatchPage -> BatchPage
setBatchInputText newText batchPage = 
    { batchPage | inputText = newText }

setSelectedBatchTab: BatchPage -> String -> BatchPage
setSelectedBatchTab batchPage newTab =
    {batchPage | selectedTab = newTab }   







