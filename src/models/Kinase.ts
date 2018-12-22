import {JsonObject, JsonProperty} from "json2typescript";

@JsonObject
export class Kinase {
    @JsonProperty("substrate_ac",String)
    public substrate_ac? : string = "";

    @JsonProperty("site_residue",String)
    public site_residue?: string = "";

    @JsonProperty("site_position",String)
    public site_position?: string = ""   

}