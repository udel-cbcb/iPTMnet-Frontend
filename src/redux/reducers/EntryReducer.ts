import { EntryAction, ActionTypes } from "../actions/EntryActions";
import { EntryPageState, initialState} from "../states/EntryPage";
import { RequestState } from "../states/RequestState";
import { InfoState } from "../states/InfoState";

export function reducer (state: EntryPageState = initialState, action: EntryAction) : EntryPageState {
    if(state === undefined){
        return new EntryPageState();
    }else{
        switch (action.type) {
            case ActionTypes.LOAD_INFO_STARTED:
                const newInfoStateLoadingStarted = new InfoState(RequestState.LOADING,"");
                return {...state,info: newInfoStateLoadingStarted};
            case ActionTypes.LOAD_INFO_ERROR:
                const newInfoStateLoadingError = new InfoState(RequestState.ERROR,action.payload);
                return {...state,info: newInfoStateLoadingError};
            case ActionTypes.LOAD_INFO_SUCCESS:
                const newInfoStateLoadingSuccess = new InfoState(RequestState.SUCCESS,"",action.payload);
                return {...state,info: newInfoStateLoadingSuccess};
            case ActionTypes.ENTRY_PAGE_ID_UPDATE:
                return {...state,id:action.payload}
            default:
                return new EntryPageState();  
        }
    }
 
}