import { RequestState } from "./RequestState";
import { SearchResultData } from "../../models/SearchResultData";

export class SearchResultState {
    public readonly status: RequestState
    public readonly error: string
    public readonly data: SearchResultData

    constructor(status: RequestState = RequestState.NOTASKED, error: string = "", searchResultData: SearchResultData = new SearchResultData()){
        this.status = status;
        this.error = error;
        this.data = searchResultData;
    }
}