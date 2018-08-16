import { SearchResultPageState, initialState } from "../states/SearchResultPageState";
import { SearchResultsAction, ActionTypes } from "../actions/SearchResultsActions";
import { SearchResultState } from '../states/SearchResultState';
import { RequestState } from "../states/RequestState";

export function reducer (state: SearchResultPageState = initialState, action: SearchResultsAction) : SearchResultPageState {
    if(state === undefined){
        return new SearchResultPageState();
    }else{
        switch(action.type){
            case ActionTypes.LOAD_SEARCH_RESULTS_STARTED: {
                const searchResultPageState = new SearchResultPageState();
                const searchResultState = {...new SearchResultState(),status: RequestState.LOADING}
                return {...searchResultPageState,searchResultData:searchResultState,searchTerm:action.payload};
            }
            case ActionTypes.LOAD_SEARCH_RESULTS_SUCCESSFUL : {
                const searchResultState = new SearchResultState(RequestState.SUCCESS,"",action.payload);
                return {...state,searchResultData: searchResultState}
            }
            default: {
                return state;
            }
        }
    }
 
}