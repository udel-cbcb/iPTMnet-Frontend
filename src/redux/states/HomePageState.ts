import { Role } from "../../models/Role";
import { TermType } from "src/models/TermType";

export class HomePageState {
    public readonly searchTerm: string
    public readonly searchTermType: TermType
    public readonly selectedPTMs: string[]
    public readonly selectedOrganisms: string[]
    public readonly selectedRole: Role

    constructor(){
        this.searchTerm = ""
        this.searchTermType = TermType.ALL
        this.selectedPTMs = []
        this.selectedOrganisms = []
        this.selectedRole = Role.ENZYME_OR_SUBSTRATE
    }

}

export const initialState: HomePageState = new HomePageState();