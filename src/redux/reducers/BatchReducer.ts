import { BatchPageState, initialState, BatchResultEnzymeState, BatchResultPPIState } from "../states/BatchPageState";
import { IBatchAction, ActionTypes } from "../actions/BatchActions";
import { RequestState } from "../states/RequestState";

export function reducer (state: BatchPageState = initialState, action: IBatchAction) : BatchPageState {
    if(state === undefined){
        return new BatchPageState();
    }else{
        switch (action.type) {
            case ActionTypes.FETCH_PTM_ENZYMES_STARTED:
                const newStateEnzymesLoading = new BatchResultEnzymeState(RequestState.LOADING,"");
                return {...state,enzymes: newStateEnzymesLoading};
            case ActionTypes.FETCH_PTM_ENZYMES_ERROR:
                const newStateEnzymesError = new BatchResultEnzymeState(RequestState.ERROR,action.payload);
                return {...state,enzymes: newStateEnzymesError};
            case ActionTypes.FETCH_PTM_ENZYMES_SUCCESS:
                const newStateEnzymesSuccess = new BatchResultEnzymeState(RequestState.SUCCESS,"",action.payload);
                return {...state,enzymes: newStateEnzymesSuccess};
            case ActionTypes.FETCH_PTM_DEP_PPI_STARTED:
                const newStatePPILoading = new BatchResultPPIState(RequestState.LOADING,"");
                return {...state,ppi: newStatePPILoading};
            case ActionTypes.FETCH_PTM_DEP_PPI_ERROR:
                const newStatePPIError = new BatchResultPPIState(RequestState.ERROR,action.payload);
                return {...state,ppi: newStatePPIError};
            case ActionTypes.FETCH_PTM_DEP_PPI_SUCCESS:
                const newStatePPISuccess = new BatchResultPPIState(RequestState.SUCCESS,"",action.payload);
                return {...state,ppi: newStatePPISuccess};
                default:
                return new BatchPageState();  
        }
    }
 
}