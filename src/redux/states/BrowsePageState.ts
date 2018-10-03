import { Role } from "src/models/Role";
import { RequestState } from "./RequestState";
import { SearchResultData } from "../../models/SearchResultData";

export class BrowsePageState {
    public readonly status: RequestState
    public readonly isPTMExpanded : boolean = false
    public readonly isRoleExpanded : boolean = false
    public readonly selectedRole: Role
    public readonly data: SearchResultData
    public readonly error: string
    public readonly url: string
}

