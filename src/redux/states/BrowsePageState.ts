import { Role } from "src/models/Role";
import { RequestState } from "./RequestState";

export class BrowsePageState {
    public readonly status: RequestState
    public readonly isPTMExpanded : boolean = false
    public readonly isRoleExpanded : boolean = false
    public readonly selectedRole: Role = Role.ENYZME
    public readonly selectedPTMs: string[] = []
    public readonly selectedOrganisms: number[] = []
    public readonly count: number = 0
    public readonly error: string = ""
    public readonly url: string = ""
    public readonly start_index: number = 0
    public readonly end_index: number = 0
}

