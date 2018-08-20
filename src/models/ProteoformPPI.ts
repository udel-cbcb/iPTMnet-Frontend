import {JsonObject, JsonProperty} from "json2typescript";
import { Source } from "src/models/Source";
import { Protein } from "src/models/Protein";

@JsonObject
export class ProteoformPPI {
    @JsonProperty("protein_1",Protein)
    public protein_1: Protein = new Protein()

    @JsonProperty("protein_2",Protein)
    public protein_2: Protein = new Protein()

    @JsonProperty("source",Source)
    public source: Source = new Source()

    @JsonProperty("pmids",[String])
    public pmids : string[] = [];

    @JsonProperty("relation",String)
    public relation: string = "";

}