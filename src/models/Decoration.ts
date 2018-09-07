import {JsonObject, JsonProperty} from "json2typescript";
import { Source } from "./Source";

@JsonObject
export class Decoration {
    @JsonProperty("ptm_type",String)
    public ptm_type : string = "";

    @JsonProperty("source",[Source])
    public alignmentItem: Source[]  = [];
    
    @JsonProperty("pmids",[String])
    public pmids: string[]  = [];

    @JsonProperty("is_conserved",Boolean)
    public is_conserved: boolean  = false;

}