import { RequestState } from "src/redux/states/RequestState";
import { PTMDependentPPI } from '../../models/PTMDependentPPI';

export class PTMDependentPPIState {
    public readonly status: RequestState
    public readonly data: PTMDependentPPI[]
    public readonly error: string
    public readonly searchTerm: string

    constructor(status: RequestState = RequestState.NOTASKED ,data: PTMDependentPPI[] = [], error: string = "", searchTerm: string = ""){
        this.status = status;
        this.data = data;
        this.error = error;
        this.searchTerm = searchTerm;
    }

}