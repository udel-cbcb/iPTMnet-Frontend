import { RequestState } from "src/redux/states/RequestState";
import { Info } from "src/models/Info";

export class InfoState {
    public readonly status: RequestState
    public readonly error: string
    public readonly data: Info

    constructor(status: RequestState = RequestState.NOTASKED, error: string = "", info: Info = new Info()){
        this.status = status;
        this.error = error;
        this.data = info;
    }

}