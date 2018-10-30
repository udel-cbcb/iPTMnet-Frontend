import {JsonObject, JsonProperty} from "json2typescript";

@JsonObject
export class Kinase {
    @JsonProperty("substrate_ac",String)
    public substrate_ac? : string = "";

    @JsonProperty("residue",String)
    public residue?: string = "";

    @JsonProperty("position",Number)
    public position?: number = 0   

}