import { Info } from "../../models/Info";
import axios from "axios";
import { State } from "../state";
import { Action } from "./action";
import { ThunkAction, ThunkDispatch } from "redux-thunk";
import { Store } from "redux";
import { JsonConvert } from "json2typescript";

export enum ActionTypes {
    ENTRY_PAGE_ID_UPDATE = 'ENTRY_PAGE_ID_UPDATE',

    LOAD_INFO_STARTED = 'LOAD_INFO_STARTED',
    LOAD_INFO_ERROR = 'LOAD_INFO_ERROR',
    LOAD_INFO_SUCCESS = 'LOAD_INFO_SUCCESS',

    LOAD_PROTEOFORM_STARTED = 'LOAD_PROTEOFORM_STARTED',
    LOAD_PROTEOFORM_ERROR = 'LOAD_PROTEOFORM_ERROR',
    LOAD_PROTEOFORM_SUCCESS = 'LOAD_PROTEOFORM_SUCCESS',
}

export type EntryAction = IEntryPageIDUpdate
                          | ILoadInfoStarted
                          | ILoadInfoError
                          | ILoadInfoSuccess
                          | ILoadProteoformStarted

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

export interface ILoadProteoformStarted {
    type: ActionTypes.LOAD_INFO_STARTED
}

export interface ILoadProteoformError {
    type: ActionTypes.LOAD_INFO_ERROR,
    payload: string
}

export interface ILoadProteoformSuccess {
    type: ActionTypes.LOAD_INFO_SUCCESS,
    payload: Info
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

export function loadProteoforms(id: string) : ThunkAction<void,Store,void,Action> {
    return async (dispatch: ThunkDispatch<State,void,Action>) => {
        // dispatch(loadInfoStarted());
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/${id}/proteoforms`).then((res)=> {
            if(res.status === 200){
                // const jsonConvert: JsonConvert = new JsonConvert();
                // const info = jsonConvert.deserializeObject(res.data,Info);
                // dispatch(loadInfoSuccess(info));
            }else{
                console.log(res.statusText + ":" + res.data);
                // dispatch(loadInfoError(res.statusText + ":" + res.data))
            }    
        }).catch((err)=>{
            console.log(err);
            // dispatch(loadInfoError(err));
        });
    }
}




