import { EntryPageState } from "./states/EntryPage";
import { HomePageState } from "./states/HomePageState";
import { SearchResultPageState } from './states/SearchResultPageState';

export class State {
    public readonly entryPage: EntryPageState
    public readonly homePage: HomePageState
    public readonly searchResultPage: SearchResultPageState

    constructor(entryPage: EntryPageState, homePage: HomePageState, searchResultPage: SearchResultPageState){
        this.entryPage = entryPage;
        this.homePage = homePage;
        this.searchResultPage = searchResultPage
    }
}

export const initialState: State = {
    entryPage : new EntryPageState(),
    homePage: new HomePageState(),
    searchResultPage: new SearchResultPageState()
}