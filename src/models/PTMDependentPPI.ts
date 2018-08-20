import {JsonObject, JsonProperty} from "json2typescript";
import { Source } from "src/models/Source";
import { Entity } from './Entity';

@JsonObject
export class PTMDependentPPI {
    @JsonProperty("ptm_type",String)
    public ptm_type : string = "";

    @JsonProperty("site",String)
    public site: string = "";

    @JsonProperty("association_type",String)
    public association_type: string = "";
    
    @JsonProperty("pmid",String)
    public pmid: string = ""

    @JsonProperty("source",Source)
    public source: Source = new Source()

    @JsonProperty("interactant",Entity)
    public interactant: Entity = new Entity()

    @JsonProperty("substrate",Entity)
    public substrate: Entity = new Entity()

}