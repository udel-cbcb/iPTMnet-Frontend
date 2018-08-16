import { ThunkAction, ThunkDispatch } from "redux-thunk";
import { Store, Action } from "redux";
import { State } from "../state";
import axios from "axios";
import { JsonConvert } from "json2typescript/src/json2typescript/json-convert";
import SearchResult from '../../models/SearchResult';
import { SearchResultData } from "src/models/SearchResultData";
import { extractSearchTerm } from '../../misc/Utils';

export enum ActionTypes {
    LOAD_SEARCH_RESULTS_STARTED = "LOAD_SEARCH_RESULTS_STARTED",
    LOAD_SEARCH_RESULTS_SUCCESSFUL = "LOAD_SEARCH_RESULTS_SUCCESSFUL",
    LOAD_SEARCH_RESULTS_ERROR = "LOAD_SEARCH_RESULTS_ERROR",
}

export type SearchResultsAction = ILoadSearchResultsStarted
                                 | ILoadSearchResultsSuccessful
                                 | ILoadSearchResultsError


export interface ILoadSearchResultsStarted {
    type: ActionTypes.LOAD_SEARCH_RESULTS_STARTED,
    payload: string 
}

export interface ILoadSearchResultsSuccessful {
    type: ActionTypes.LOAD_SEARCH_RESULTS_SUCCESSFUL,
    payload: SearchResultData
}

export interface ILoadSearchResultsError {
    type: ActionTypes.LOAD_SEARCH_RESULTS_ERROR,
    payload: string
}

export function loadSearchResultStarted(searchTerm: string) : ILoadSearchResultsStarted {
    return {
        type: ActionTypes.LOAD_SEARCH_RESULTS_STARTED,
        payload: searchTerm
    }
}

export function loadSearchResultSuccessful(searchResultData: SearchResultData): ILoadSearchResultsSuccessful {
    return {
        type: ActionTypes.LOAD_SEARCH_RESULTS_SUCCESSFUL,
        payload: searchResultData
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
        const searchTerm = extractSearchTerm(searchQuery);
        dispatch(loadSearchResultStarted(searchTerm));
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/search?${searchQuery}&paginate=true&start_index=${startIndex}&end_index=${endIndex}`).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const searchResults = jsonConvert.deserializeArray(res.data,SearchResult);
                const totalCount = res.headers.count;
                const searchResultData = new SearchResultData(totalCount,searchResults);
                dispatch(loadSearchResultSuccessful(searchResultData));
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
