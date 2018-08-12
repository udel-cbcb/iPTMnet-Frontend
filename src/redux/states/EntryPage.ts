import { InfoState } from "./InfoState";

export class EntryPageState {
    public readonly id: string
    public readonly info: InfoState

    constructor(){
        this.id = "",
        this.info = new InfoState();
    }

}

export const initialState: EntryPageState = new EntryPageState();
