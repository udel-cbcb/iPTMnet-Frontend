import {JsonObject, JsonProperty} from "json2typescript";
import { PTMEnzyme } from "src/models/PTMEnzyme";
import { Source } from "src/models/Source";

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

    @JsonProperty("enzymes",[PTMEnzyme])
    public enzymes: PTMEnzyme [] = [];

    @JsonProperty("pmid",[String])
    public pmid: string [] = [];

}

