import { Role } from "src/models/Role";
import { RequestState } from "./RequestState";

export class BrowsePageState {
    public readonly status: RequestState
    public readonly isPTMExpanded : boolean = false
    public readonly isRoleExpanded : boolean = false
    public readonly selectedRole: Role
    public readonly count: number
    public readonly error: string
    public readonly url: string
    public readonly start_index: number
    public readonly end_index: number
}

