import {JsonObject, JsonProperty} from "json2typescript";

@JsonObject
export class Source {
    @JsonProperty("name",String)
    public name : string = "";

    @JsonProperty("label",String)
    public label: string = "";

    @JsonProperty("url",String)
    public url: string = "";
}