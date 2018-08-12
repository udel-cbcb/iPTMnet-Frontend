import { Info } from "src/models/Info";
import axios from "axios";
import { State } from "src/redux/state";
import { Action } from "src/redux/action";
import { ThunkAction, ThunkDispatch } from "redux-thunk";
import { Store } from "redux";
import { JsonConvert } from "json2typescript";

export enum ActionTypes {
    LOAD_INFO_STARTED = 'LOAD_INFO_STARTED',
    LOAD_INFO_ERROR = 'LOAD_INFO_ERROR',
    LOAD_INFO_SUCCESS = 'LOAD_INFO_SUCCESS',
    ENTRY_PAGE_ID_UPDATE = 'ENTRY_PAGE_ID_UPDATE'
}

export type EntryAction = ILoadInfoStarted
                          | ILoadInfoError
                          | ILoadInfoSuccess
                          | IEntryPageIDUpdate

export interface ILoadInfoStarted {
    type: ActionTypes.LOAD_INFO_STARTED
}

export interface ILoadInfoError {
    type: ActionTypes.LOAD_INFO_ERROR,
    payload: string
}

export interface ILoadInfoSuccess {
    type: ActionTypes.LOAD_INFO_SUCCESS,
    payload: Info
}

export interface IEntryPageIDUpdate {
    type: ActionTypes.ENTRY_PAGE_ID_UPDATE,
    payload: string
}

export function changeEntryPageID(id: string) : IEntryPageIDUpdate {
    return {
        type: ActionTypes.ENTRY_PAGE_ID_UPDATE,
        payload: id
    }
}

export function loadInfoStarted() : ILoadInfoStarted {
    return {
        type: ActionTypes.LOAD_INFO_STARTED
    }
}

export function loadInfoError(error: string) : ILoadInfoError {
    return {
        type: ActionTypes.LOAD_INFO_ERROR,
        payload: error
    }
}

export function loadInfoSuccess(info: Info) : ILoadInfoSuccess {
    return {
        type: ActionTypes.LOAD_INFO_SUCCESS,
        payload: info
    }
}

export function loadInfo(id: string) : ThunkAction<void,Store,void,Action> {
    return async (dispatch: ThunkDispatch<State,void,Action>) => {
        dispatch(loadInfoStarted());
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/${id}/info`).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const info = jsonConvert.deserializeObject(res.data,Info);
                dispatch(loadInfoSuccess(info));
            }else{
                console.log(res.statusText + ":" + res.data);
                dispatch(loadInfoError(res.statusText + ":" + res.data))
            }    
        }).catch((err)=>{
            console.log(err);
            dispatch(loadInfoError(err));
        });
    }
}




