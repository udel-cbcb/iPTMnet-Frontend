import { Kinase } from "src/models/Kinase";

export class BatchPageState {
    public static defaultKinases(): Kinase[] {
        return [
            {
                substrate_ac: "Q15796",
                residue: "K",
                position: 19
            },
            {
                substrate_ac: "Q15796",
                residue: "T",
                position: 8
            },
            {
                substrate_ac: "P04637",
                residue: "K",
                position: 120
            },
            {
                substrate_ac: "P04637",
                residue: "S",
                position: 140
            },
            {
                substrate_ac: "P04637",
                residue: "S",
                position: 378
            },
            {
                substrate_ac: "P04637",
                residue: "S",
                position: 392
            },
            {
                substrate_ac: "P04637",
                residue: "S",
                position: 199
            },
        ];
    }

    public readonly kinases: Kinase[];

    constructor() {
        this.kinases = BatchPageState.defaultKinases();
    }
   
}

