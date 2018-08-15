import { RequestState } from "./RequestState";
import SearchResult from '../../models/SearchResult';

export class SearchResultState {
    public readonly status: RequestState
    public readonly error: string
    public readonly data: SearchResult[]

    constructor(status: RequestState = RequestState.NOTASKED, error: string = "", searchResult: SearchResult[] = []){
        this.status = status;
        this.error = error;
        this.data = searchResult;
    }
}