import { RequestState } from "src/redux/states/RequestState";
import { ProteoformPPI } from '../../models/ProteoformPPI';

export class ProteoformPPIState {
    public readonly status: RequestState
    public readonly data: ProteoformPPI[]
    public readonly error: string
    public readonly searchTerm: string

    constructor(status: RequestState = RequestState.NOTASKED ,data: ProteoformPPI[] = [], error: string = "", searchTerm: string = ""){
        this.status = status;
        this.data = data;
        this.error = error;
        this.searchTerm = searchTerm;
    }

}