import { Role } from "src/models/Role";

export class HomePageState {
    public readonly selectedPTMs: string[]
    public readonly selectedOrganisms: string[]
    public readonly selectedRole: Role

    constructor(){
        this.selectedPTMs = []
        this.selectedOrganisms = []
        this.selectedRole = Role.ENZYME_OR_SUBSTRATE
    }

}

export const initialState: HomePageState = new HomePageState();