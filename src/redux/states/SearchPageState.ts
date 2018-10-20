import { RequestState } from "./RequestState";

export class SearchPageState {
    public readonly status: RequestState
    public readonly count: number = 0
    public readonly error: string = ""
    public readonly url: string = ""
    public readonly search_term: string = ""
    public readonly start_index: number = 0
    public readonly end_index: number = 0
}

