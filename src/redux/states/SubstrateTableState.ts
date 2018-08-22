import { RequestState } from "src/redux/states/RequestState";
import { Substrate } from "src/models/Substrate";

export class SubstrateTableState {
    public readonly status: RequestState
    public readonly data: Map<string,Substrate[]>
    public readonly error: string
    public readonly searchTerm: string
    public readonly selectedForm: string

    constructor(status: RequestState = RequestState.NOTASKED ,data: Map<string,Substrate[]> = new Map<string,Substrate[]>(), selectedForm: string = "" ,searchTerm: string = "", error: string = "", ){
        this.status = status;
        this.data = data;
        this.error = error;
        this.selectedForm = selectedForm;
        this.searchTerm = searchTerm;
    }

    public getSelectedData = (): Substrate[] => {
        const substrates = this.data[this.selectedForm];
        if(substrates){
            return substrates;
        }else{
            return [];
        }
    }

}