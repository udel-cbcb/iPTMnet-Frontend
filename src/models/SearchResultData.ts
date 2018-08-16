import SearchResult from "src/models/SearchResult";

export class SearchResultData {
    public readonly totalCount : number;
    public readonly searchResults: SearchResult[];

    constructor(totalCount: number = 0, searchResults: SearchResult[] = []){
        this.totalCount = totalCount,
        this.searchResults = searchResults
    }
}
