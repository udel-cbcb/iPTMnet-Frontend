import { Role } from "src/models/Role";

export class BrowsePageState {
    public readonly isPTMExpanded : boolean = false
    public readonly isRoleExpanded : boolean = false
    public readonly selectedRole: Role
}

