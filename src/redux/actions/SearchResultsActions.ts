import { ThunkAction, ThunkDispatch } from "redux-thunk";
import { Store, Action } from "redux";
import { State } from "../state";
import axios from "axios";
import { JsonConvert } from "json2typescript/src/json2typescript/json-convert";
import SearchResult from '../../models/SearchResult';

export enum ActionTypes {
    LOAD_SEARCH_RESULTS_STARTED = "LOAD_SEARCH_RESULTS_STARTED",
    LOAD_SEARCH_RESULTS_SUCCESSFUL = "LOAD_SEARCH_RESULTS_SUCCESSFUL",
    LOAD_SEARCH_RESULTS_ERROR = "LOAD_SEARCH_RESULTS_ERROR",
}

export type SearchResultsAction = ILoadSearchResultsStarted
                                 | ILoadSearchResultsSuccessful
                                 | ILoadSearchResultsError


export interface ILoadSearchResultsStarted {
    type: ActionTypes.LOAD_SEARCH_RESULTS_STARTED 
}

export interface ILoadSearchResultsSuccessful {
    type: ActionTypes.LOAD_SEARCH_RESULTS_SUCCESSFUL,
    payload: SearchResult[]
}

export interface ILoadSearchResultsError {
    type: ActionTypes.LOAD_SEARCH_RESULTS_ERROR,
    payload: string
}

export function loadSearchResultStarted() : ILoadSearchResultsStarted {
    return {
        type: ActionTypes.LOAD_SEARCH_RESULTS_STARTED
    }
}

export function loadSearchResultSuccessful(searchResults: SearchResult[]): ILoadSearchResultsSuccessful {
    return {
        type: ActionTypes.LOAD_SEARCH_RESULTS_SUCCESSFUL,
        payload: searchResults
    }
}

export function loadSearchResultError(errorMsg: string) : ILoadSearchResultsError {
    return {
        type: ActionTypes.LOAD_SEARCH_RESULTS_ERROR,
        payload: errorMsg
    }
}

export function loadSearchResults(searchQuery: string, startIndex: number, endIndex: number) : ThunkAction<void,Store,void,Action> {
    return async (dispatch: ThunkDispatch<State,void,Action>) => {
        dispatch(loadSearchResultStarted());
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/search?${searchQuery}&paginate=true&start_index=${startIndex}&end_index=${endIndex}`).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const searchResults = jsonConvert.deserializeArray(res.data,SearchResult);
                console.log(searchResults);
                dispatch(loadSearchResultSuccessful(searchResults));
            }else{
                console.log(res.statusText + ":" + res.data);
                dispatch(loadSearchResultError(res.statusText + ":" + res.data))
            }    
        }).catch((err)=>{
            console.log(err);
            dispatch(loadSearchResultError(err));
        });
    }
}
