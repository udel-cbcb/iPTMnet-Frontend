import {JsonObject, JsonProperty} from "json2typescript";
import { Organism } from "./Organism";
import { Pro } from "./Pro";

@JsonObject
export class Info {
    @JsonProperty("gene_name",String)
    public gene_name: string = "";

    @JsonProperty("uniprot_ac",String)
    public uniprot_ac: string = "";

    @JsonProperty("uniprot_id",String)
    public uniprot_id: string = "";

    @JsonProperty("protein_name",String)
    public protein_name: string = "";

    @JsonProperty("synonyms",[String])
    public synonyms: string [] = [];

    @JsonProperty("organism",Organism)    
    public organism: Organism = new Organism()

    @JsonProperty("pro",Pro)    
    public pro?: Pro = undefined

}