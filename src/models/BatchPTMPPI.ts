import {JsonObject, JsonProperty} from "json2typescript";
import { Entity } from "./Entity";
import { Source } from "./Source";

@JsonObject
export class BatchPTMPPI {
   
    @JsonProperty("ptm_type",String)
    public ptm_type : string = "";

    @JsonProperty("site",String)
    public site: string = "";

    @JsonProperty("site_position",Number)
    public site_position: number = 0;

    @JsonProperty("association_type",String)
    public association_type: string = "";

    @JsonProperty("interactant",Entity)
    public interactant: Entity = new Entity();

    @JsonProperty("substrate",Entity)
    public substrate: Entity = new Entity();

    @JsonProperty("source",Source)
    public source: Source = new Source() ;

    @JsonProperty("pmids",[String])
    public pmids: string[] = [];

}