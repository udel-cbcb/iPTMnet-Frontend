import { EntryPageState } from "./states/EntryPage";

export class State {
    public readonly entryPage: EntryPageState
    constructor(entryPage: EntryPageState){
        this.entryPage = entryPage;
    }
}

export const initialState: State = {
    entryPage : new EntryPageState()
}