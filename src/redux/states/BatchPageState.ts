import { RequestState } from "./RequestState";
import { BatchEnzyme } from "src/models/BatchEnzyme";

export enum BatchOutputType {
    PTM_ENZYMES,
    PTM_DEP_PPI
}

export class BatchPageState {
    public readonly enzymes : BatchResultEnzymeState 
    constructor() {
        this.enzymes = new BatchResultEnzymeState();
    }
}

export class BatchResultEnzymeState {
    public readonly status: RequestState
    public readonly error: string
    public readonly data: BatchEnzyme[] 
    constructor(status: RequestState =  RequestState.NOTASKED, error: string = "", data: BatchEnzyme[] = []){
        this.status = status;
        this.error = error;
        this.data = data;
    }
}



export const initialState: BatchPageState = new BatchPageState();

