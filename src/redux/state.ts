import { EntryPageState } from "./states/EntryPage";
import { HomePageState } from "./states/HomePageState";

export class State {
    public readonly entryPage: EntryPageState
    public readonly homePage: HomePageState
    constructor(entryPage: EntryPageState, homePage: HomePageState){
        this.entryPage = entryPage;
        this.homePage = homePage;
    }
}

export const initialState: State = {
    entryPage : new EntryPageState(),
    homePage: new HomePageState()
}