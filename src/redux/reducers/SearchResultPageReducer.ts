import { SearchResultPageState, initialState } from "../states/SearchResultPageState";
import { SearchResultsAction } from "../actions/SearchResultsActions";

export function reducer (state: SearchResultPageState = initialState, action: SearchResultsAction) : SearchResultPageState {
    if(state === undefined){
        return new SearchResultPageState();
    }else{
        return state;
    }
 
}