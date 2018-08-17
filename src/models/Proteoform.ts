import {JsonObject, JsonProperty} from "json2typescript";
import { Source } from "src/models/Source";
import { PTMEnzyme } from "src/models/PTMEnzyme";

@JsonObject
export class Proteoform {
    @JsonProperty("pro_id",String)
    public pro_id : string = "";

    @JsonProperty("label",String)
    public label: string = "";

    @JsonProperty("sites",[String])
    public sites: string[] = []
    
    @JsonProperty("pmids",[String])
    public pmids: string[] = []

    @JsonProperty("source",Source)
    public source: Source = new Source()

    @JsonProperty("ptm_enzyme",PTMEnzyme)
    public ptm_enzyme: PTMEnzyme = new PTMEnzyme()

}