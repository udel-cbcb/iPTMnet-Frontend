export enum Role {
    ENZYME_OR_SUBSTRATE = 1,
    ENYZME = 2,
    SUBSTRATE = 3,
    ENZYME_AND_SUBSTRATE = 4
}

export function toStringLiteral(role: Role) : string {
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