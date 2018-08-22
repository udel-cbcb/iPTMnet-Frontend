import {JsonObject, JsonProperty} from "json2typescript";

@JsonObject
export class Enzyme {
    @JsonProperty("id",String)
    public id? : string = "";

    @JsonProperty("enz_type",String)
    public enz_type?: string = "";

    @JsonProperty("name",String)
    public name?: string = ""
}