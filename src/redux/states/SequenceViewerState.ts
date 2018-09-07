import { RequestState } from "src/redux/states/RequestState";
import { Alignment } from "../../models/Alignment";

export class SequenceViewerState {
    public readonly status: RequestState
    public readonly data: Alignment[]
    public readonly error: string
    public readonly selectedRow: number 

    constructor(status: RequestState = RequestState.NOTASKED ,data: Alignment[] = [], error: string = "", selectedRow: number = 0){
        this.status = status;
        this.data = data;
        this.error = error;
        this.selectedRow = selectedRow
    }

}