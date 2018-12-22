import { BatchPageState, initialState, BatchResultEnzymeState } from "../states/BatchPageState";
import { IBatchAction, ActionTypes } from "../actions/BatchActions";
import { RequestState } from "../states/RequestState";

export function reducer (state: BatchPageState = initialState, action: IBatchAction) : BatchPageState {
    if(state === undefined){
        return new BatchPageState();
    }else{
        switch (action.type) {
            case ActionTypes.FETCH_PTM_ENZYMES_STARTED:
                console.log("started")
                const newStateEnzymesLoading = new BatchResultEnzymeState(RequestState.LOADING,"");
                return {...state,enzymes: newStateEnzymesLoading};
            case ActionTypes.FETCH_PTM_ENZYMES_ERROR:
                console.log("error")
                const newStateEnzymesError = new BatchResultEnzymeState(RequestState.ERROR,action.payload);
                return {...state,enzymes: newStateEnzymesError};
            case ActionTypes.FETCH_PTM_ENZYMES_SUCCESS:
                console.log("success")
                const newStateEnzymesSuccess = new BatchResultEnzymeState(RequestState.SUCCESS,"",action.payload);
                return {...state,enzymes: newStateEnzymesSuccess};
            default:
                return new BatchPageState();  
        }
    }
 
}