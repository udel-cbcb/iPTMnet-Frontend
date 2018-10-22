export enum TermType {
    ALL = 1,
    UNIPROT = 2,
    PROTEIN_OR_GENE = 3,
    PMID = 4
}

export function termTypeToString(termType: TermType) : string {
    switch (termType) {
        case TermType.ALL:
            return "All";
        case TermType.UNIPROT:
            return "UniprotID";
        case TermType.PROTEIN_OR_GENE:
            return "Protein/Gene Name";
        case TermType.PMID:
            return "PMID";
        default:
            return "";    
    }
}

export function termTypeFromString(term_type_str: string) : TermType {
    switch (term_type_str) {
        case "All":
            return TermType.ALL;
        case "UniprotID":
            console.log("selected")
            return TermType.UNIPROT;
        case "Protein/Gene Name":
            return TermType.PROTEIN_OR_GENE;
        case "PMID":
            return TermType.PMID;
        default:
            return TermType.ALL;    
    }
}