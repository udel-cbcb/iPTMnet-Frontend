export enum Role {
    ENZYME_OR_SUBSTRATE = 1,
    ENYZME = 2,
    SUBSTRATE = 3,
    ENZYME_AND_SUBSTRATE = 4
}

export function roleToString(role: Role) : string {
    switch (role) {
        case Role.ENYZME:
            return "enzyme";
        case Role.ENZYME_AND_SUBSTRATE:
            return "enzyme and substrate";
        case Role.SUBSTRATE:
            return "substrate";
        case Role.ENZYME_OR_SUBSTRATE:
            return "enzyme or substrate";
        default:
            return "";    
    }
}

export function roleFromString(role_str: string) : Role {
    switch (role_str.toLowerCase()) {
        case "enzyme":
            return Role.ENYZME;
        case "enzyme and substrate":
            return Role.ENZYME_AND_SUBSTRATE;
        case "substrate":
            return Role.SUBSTRATE;
        case "enzyme or substrate":
            return Role.ENZYME_OR_SUBSTRATE;
        default:
            return Role.ENYZME;    
    }
}