import {JsonObject, JsonProperty} from "json2typescript";

@JsonObject
export class Entity {
    @JsonProperty("name",String)
    public name : string = "";

    @JsonProperty("uniprot_id",String)
    public uniprot_id: string = ""; 

}