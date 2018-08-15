import { SearchResultState } from "./SearchResultState";

export class SearchResultPageState {
    public readonly selectedPage: number
    public readonly searchResultData: SearchResultState

    constructor(selectedPage: number = 0, searchResulData: SearchResultState = new SearchResultState()){
        this.selectedPage = selectedPage,
        this.searchResultData = searchResulData
    }
}

export const initialState: SearchResultPageState = new SearchResultPageState();