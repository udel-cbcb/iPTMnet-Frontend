import { RequestState } from "./RequestState";
import { SearchResultData } from "../../models/SearchResultData";

export class SearchResultState {
    public readonly status: RequestState
    public readonly error: string
    public readonly data: SearchResultData
    public readonly selectedIDs: string[]

    constructor(status: RequestState = RequestState.NOTASKED, error: string = "", searchResultData: SearchResultData = new SearchResultData(), selectedIDs:string[] = []){
        this.status = status;
        this.error = error;
        this.data = searchResultData;
        this.selectedIDs = []
    }
}