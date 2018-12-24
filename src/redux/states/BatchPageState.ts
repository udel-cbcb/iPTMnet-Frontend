import { RequestState } from "./RequestState";
import { BatchEnzyme } from "src/models/BatchEnzyme";
import { BatchPTMPPI } from "src/models/BatchPTMPPI";

export enum BatchOutputType {
    PTM_ENZYMES,
    PTM_DEP_PPI
}

export class BatchPageState {
    public readonly enzymes : BatchResultEnzymeState 
    public readonly ppi: BatchResultPPIState;
    constructor() {
        this.enzymes = new BatchResultEnzymeState();
        this.ppi = new BatchResultPPIState();
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

export class BatchResultPPIState {
    public readonly status: RequestState
    public readonly error: string
    public readonly data: BatchPTMPPI[] 
    constructor(status: RequestState =  RequestState.NOTASKED, error: string = "", data: BatchPTMPPI[] = []){
        this.status = status;
        this.error = error;
        this.data = data;
    }
}



export const initialState: BatchPageState = new BatchPageState();

