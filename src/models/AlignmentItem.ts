import {JsonObject, JsonProperty} from "json2typescript";
import { Decoration } from "src/models/Decoration";

@JsonObject
export class AlignmentItem {
    @JsonProperty("site",String)
    public site : string = "";

    @JsonProperty("position", Number)
    public position: number = 0;
    
    @JsonProperty("decorations", [Decoration])
    public decorations: Decoration[] = [];

}