import {JsonObject, JsonProperty} from "json2typescript";

@JsonObject
export class PTMEnzyme {
    @JsonProperty("pro_id",String)
    public pro_id : string = "";

    @JsonProperty("label",String)
    public label: string = "";
}