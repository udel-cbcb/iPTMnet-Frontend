import {JsonObject, JsonProperty} from "json2typescript";
import { Entity } from "./Entity";
import { Source } from "./Source";

@JsonObject
export class BatchEnzyme {

    @JsonProperty("enzyme",Entity)
    public enzyme: Entity = new Entity();

    @JsonProperty("substrate",Entity)
    public substrate: Entity = new Entity();

    @JsonProperty("ptm_type",String)
    public ptm_type : string = "";

    @JsonProperty("site",String)
    public site: string = "";

    @JsonProperty("site_position",Number)
    public site_position: number = 0;

    @JsonProperty("score",Number)
    public score: number = 0;

    @JsonProperty("source",[Source])
    public source: Source[] = [] ;

    @JsonProperty("pmids",[String])
    public pmids: string[] = [];

}