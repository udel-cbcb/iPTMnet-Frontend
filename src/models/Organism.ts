import {JsonObject, JsonProperty} from "json2typescript";

@JsonObject
export class Organism {
    @JsonProperty("taxon_code",String)
    public taxon_code : string = "";

    @JsonProperty("species",String)
    public species: string = "";

    @JsonProperty("common_name",String)
    public common_name: string = ""
}