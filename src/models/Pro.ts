import {JsonObject, JsonProperty} from "json2typescript";

@JsonObject
export class Pro {
    @JsonProperty("id",String)
    public id : string = "";

    @JsonProperty("name",String)
    public name : string = "";

    @JsonProperty("definition",String)
    public definition : string = "";

    @JsonProperty("short_label",String)
    public short_label : string = "";

    @JsonProperty("category",String)
    public category: string = "";
}