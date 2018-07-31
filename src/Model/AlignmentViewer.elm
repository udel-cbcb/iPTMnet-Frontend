module Model.AlignmentViewer exposing (..)
import Array exposing (..)
import Model.Misc exposing (..)
import Model.Alignment exposing (..)

type alias AlignmentViewer = 
    {
        rowIndex : Int,
        columnIndex : Int,
        status: RequestState,
        error: String,
        alignments: Array Alignment
    }

defaultAlignmentViewer : AlignmentViewer
defaultAlignmentViewer = 
    {
        rowIndex = -1,
        columnIndex = -1,
        status =  Loading,
        error = "",
        alignments = Array.fromList []    
    }

setSelectedAlignmentRowIndex : Int -> AlignmentViewer -> AlignmentViewer
setSelectedAlignmentRowIndex newRowIndex alignmentViewer =
    {alignmentViewer | rowIndex = newRowIndex }

setSelectedAlignmentColumnIndex : Int -> AlignmentViewer -> AlignmentViewer
setSelectedAlignmentColumnIndex newColumnIndex alignmentViewer =
    {alignmentViewer | columnIndex = newColumnIndex }

