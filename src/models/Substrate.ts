import {JsonObject, JsonProperty} from "json2typescript";
import { Source } from "src/models/Source";
import { Enzyme } from "src/models/Enzyme";

@JsonObject
export class Substrate {
    @JsonProperty("residue",String)
    public residue? : string = "";

    @JsonProperty("site",String)
    public site?: string = "";

    @JsonProperty("ptm_type",String)
    public ptm_type?: string = "";

    @JsonProperty("score",Number)
    public score: number = 0;

    @JsonProperty("sources",[Source])
    public sources: Source [] = [];

    @JsonProperty("enzymes",[Enzyme])
    public enzymes: Enzyme [] = [];

    @JsonProperty("pmids",[String])
    public pmids: string [] = [];
}


