import { RequestState } from "src/redux/states/RequestState";
import { Proteoform } from "src/models/Proteoform";

export class ProteoformTableState {
    public readonly status: RequestState
    public readonly data: Proteoform[]
    public readonly error: string

    constructor(status: RequestState = RequestState.NOTASKED ,data: Proteoform[] = [], error: string = ""){
        this.status = status;
        this.data = data;
        this.error = error;
    }

}