import { EntryPageState } from "./states/EntryPage";
import { HomePageState } from "./states/HomePageState";
import { SearchResultPageState } from './states/SearchResultPageState';
import { BatchPageState } from "./states/BatchPageState";

export class State {
    public readonly entryPage: EntryPageState
    public readonly homePage: HomePageState
    public readonly searchResultPage: SearchResultPageState
    public readonly batchPage: BatchPageState;

    constructor(entryPage: EntryPageState, homePage: HomePageState, searchResultPage: SearchResultPageState){
        this.entryPage = entryPage;
        this.homePage = homePage;
        this.searchResultPage = searchResultPage
    }
}

export const initialState: State = {
    entryPage : new EntryPageState(),
    homePage: new HomePageState(),
    searchResultPage: new SearchResultPageState(),
    batchPage: new BatchPageState()
}