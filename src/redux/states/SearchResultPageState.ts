import { SearchResultState } from "./SearchResultState";

export class SearchResultPageState {
    public readonly searchTerm: string
    public readonly selectedPage: number
    public readonly searchResultData: SearchResultState

    constructor(selectedPage: number = 0, searchResulData: SearchResultState = new SearchResultState(),searchTerm: string = ""){
        this.selectedPage = selectedPage,
        this.searchResultData = searchResulData,
        this.searchTerm = searchTerm
    }
}

export const initialState: SearchResultPageState = new SearchResultPageState();