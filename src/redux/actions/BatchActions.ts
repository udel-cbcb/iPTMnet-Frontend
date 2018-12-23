import { ThunkAction, ThunkDispatch } from "redux-thunk";
import axios from "axios";
import { State } from "../state";
import { Action } from "./action";
import { Store } from "redux";
import { Kinase } from "src/models/Kinase";
import { BatchEnzyme } from "src/models/BatchEnzyme";
import { JsonConvert } from "json2typescript";

export enum ActionTypes {
    FETCH_PTM_ENZYMES_STARTED = "FETCH_PTM_ENZYMES_STARTED",
    FETCH_PTM_ENZYMES_ERROR = "FETCH_PTM_ENZYMES_ERROR",
    FETCH_PTM_ENZYMES_SUCCESS = "FETCH_PTM_ENZYMES_SUCCESS",

    FETCH_PTM_DEP_PPI_STARTED = "FETCH_PTM_DEP_PPI_STARTED",
    FETCH_PTM_DEP_PPI_ERROR = "FETCH_PTM_DEP_PPI_ERROR",
    FETCH_PTM_DEP_PPI_SUCCESS = "FETCH_PTM_DEP_PPI_SUCCESS"
}

export interface IBatchAction {
    type: ActionTypes,
    payload: any
}

export function FetchPTMEnzymesStarted() : IBatchAction {
    return {type: ActionTypes.FETCH_PTM_ENZYMES_STARTED, payload: ""}
}

export function FetchPTMEnzymesError(payload: string): IBatchAction {
    return {
        type: ActionTypes.FETCH_PTM_ENZYMES_ERROR,
        payload: payload
    }
}

export function FetchPTMEnzymesSuccess(payload: BatchEnzyme[]) : IBatchAction {
    return {
        type: ActionTypes.FETCH_PTM_ENZYMES_SUCCESS,
        payload: payload
    }
}

export function FetchPTMDepPPIStarted() :IBatchAction {
    return {type: ActionTypes.FETCH_PTM_DEP_PPI_STARTED, payload: ""}
}

export function FetchPTMDepPPIError(payload: string): IBatchAction {
    return {type: ActionTypes.FETCH_PTM_DEP_PPI_ERROR, payload: payload}
}

export function FetchPTMDepPPISuccess(payload: any) : IBatchAction {
    return {type: ActionTypes.FETCH_PTM_DEP_PPI_SUCCESS, payload: payload}
}

export function loadPTMEnzymes(kinase_csv: string) : ThunkAction<void,Store,void,Action> {
    return async (dispatch: ThunkDispatch<State,void,Action>) => {
        dispatch(FetchPTMEnzymesStarted());

        //convert csv values to kinase objects
        const kinases = csvToKinases(kinase_csv);
        axios.post(`https://research.bioinformatics.udel.edu/iptmnet/api/batch_ptm_enzymes`,kinases).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const batchEnzymes = jsonConvert.deserializeArray(res.data,BatchEnzyme);
                console.log(batchEnzymes)
                dispatch(FetchPTMEnzymesSuccess(batchEnzymes));
            }else{
                dispatch(FetchPTMEnzymesError(res.statusText + ":" + res.data))
            }    
        }).catch((err)=>{
            console.log(err)
            console.log(JSON.stringify(err.response));
            dispatch(FetchPTMEnzymesError(JSON.stringify(err.response)));
        });
    }
}

function csvToKinases(csv: string) : Kinase[] {

    const lines=csv.split("\n");
   
    const kinases = [];

    for(let i=1;i<lines.length;i++){
   
        const currentline=lines[i].split(",");
         
        const kinase = new Kinase();
        kinase.substrate_ac = currentline[0];
        kinase.site_residue = currentline[1];
        kinase.site_position = currentline[2];
        
        kinases.push(kinase);
  
    }

    return kinases;

}


