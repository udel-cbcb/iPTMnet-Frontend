import {JsonObject, JsonProperty} from "json2typescript";
import { Organism } from "./Organism";

@JsonObject
class SearchResult {
    @JsonProperty("iptm_id",String)
    public iptm_id : string = "";
    
    @JsonProperty("uniprot_ac",String)
    public uniprot_ac : string = "";

    @JsonProperty("protein_name",String)
    public protein_name : string = "";

    @JsonProperty("gene_name",String)
    public gene_name : string = "";

    @JsonProperty("synonyms",[String])
    public synonyms : string[] = [];

    @JsonProperty("organism",Organism)
    public organism : Organism = new Organism();

    @JsonProperty("substrate_role",Boolean)
    public substrate_role : boolean = false;

    @JsonProperty("substrate_num",Number)
    public substrate_num : number = 0;

    @JsonProperty("enzyme_role",Boolean)
    public enzyme_role : boolean = false;
    
    @JsonProperty("enzyme_num",Number)
    public enzyme_num : number = 0;

    @JsonProperty("ptm_dependent_ppi_role",Boolean)
    public ptm_dependent_ppi_role : boolean = false;
    
    @JsonProperty("ptm_dependent_ppi_num",Number)
    public ptm_dependent_ppi_num : number = 0;

    @JsonProperty("sites",Number)
    public sites : number = 0;

    @JsonProperty("isoforms",Number)
    public isoforms : number = 0;
}

export default SearchResult