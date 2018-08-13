import { Role } from "../../models/Role";

export class HomePageState {
    public readonly searchTerm: string
    public readonly selectedPTMs: string[]
    public readonly selectedOrganisms: string[]
    public readonly selectedRole: Role

    constructor(){
        this.searchTerm = ""
        this.selectedPTMs = []
        this.selectedOrganisms = []
        this.selectedRole = Role.ENZYME_OR_SUBSTRATE
    }

}

export const initialState: HomePageState = new HomePageState();