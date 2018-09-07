import {JsonObject, JsonProperty} from "json2typescript";
import { AlignmentItem } from "src/models/AlignmentItem";

@JsonObject
export class Alignment {
    @JsonProperty("id",String)
    public id : string = "";

    @JsonProperty("sequence",[AlignmentItem])
    public sequence: AlignmentItem[] = []; 

}