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

    public getData = (selectedForm: string): Substrate[] => {
        const substrates = this.data[selectedForm];
        if(substrates){
            return substrates;
        }else{
            return [];
        }
    }

    public getForms = (): string[] => {
        const keys = Array.from(Object.keys(this.data)).sort();
        return keys;
    }

}