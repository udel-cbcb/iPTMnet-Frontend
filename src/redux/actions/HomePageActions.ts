import { Role } from "src/models/Role";

export enum ActionTypes {
    SELECT_ALL_PTM_TYPES = 'SELECT_ALL_PTM_TYPES',
    DESELECT_ALL_PTM_TYPES = 'DESELECT_ALL_PTM_TYPES',
    SELECT_PTM_TYPE = 'SELECT_PTM_TYPE',
    DESELECT_PTM_TYPE = 'DESELECT_PTM_TYPE',
    SELECT_ALL_ORGANISMS="SELECT_ALL_ORGANISMS",
    DESELECT_ALL_ORGANISMS="DESELECT_ALL_ORGANISMS",
    SELECT_ORGANISM="SELECT_ORGANISM",
    DESELECT_ORGANISM="DESELECT_ORGANISM",
    SELECT_ROLE="SELECT_ROLE"
}

export type HomePageAction = ISelectAllPTMTypes
                                | IDeSelectAllPTMTypes
                                | ISelectPTMType
                                | IDeSelectPTMType
                                | ISelectAllOrganisms
                                | IDeselectAllOrganisms
                                | ISelectOrganism
                                | IDeSelectOrganism
                                | ISelectRole

export interface ISelectAllPTMTypes {
    type: ActionTypes.SELECT_ALL_PTM_TYPES
}

export interface IDeSelectAllPTMTypes {
    type: ActionTypes.DESELECT_ALL_PTM_TYPES
}

export interface ISelectPTMType {
    type: ActionTypes.SELECT_PTM_TYPE,
    payload: string
}

export interface IDeSelectPTMType {
    type: ActionTypes.DESELECT_PTM_TYPE,
    payload: string
}

export interface ISelectAllOrganisms {
    type: ActionTypes.SELECT_ALL_ORGANISMS
}

export interface IDeselectAllOrganisms {
    type: ActionTypes.DESELECT_ALL_ORGANISMS
}

export interface ISelectOrganism {
    type: ActionTypes.SELECT_ORGANISM,
    payload: string
}

export interface IDeSelectOrganism {
    type: ActionTypes.DESELECT_ORGANISM,
    payload: string
}

export interface ISelectRole {
    type: ActionTypes.SELECT_ROLE,
    payload: Role
}

export function selectAllPTMTypes() : ISelectAllPTMTypes {
    return {
        type: ActionTypes.SELECT_ALL_PTM_TYPES,
    }
}

export function deselectAllPTMTypes() : IDeSelectAllPTMTypes {
    return {
        type: ActionTypes.DESELECT_ALL_PTM_TYPES,
    }
}

export function selectPTMType(ptmType: string) : ISelectPTMType {
    return {
        type: ActionTypes.SELECT_PTM_TYPE,
        payload: ptmType
    }
}

export function deselectPTMType(ptmType: string) : IDeSelectPTMType {
    return {
        type: ActionTypes.DESELECT_PTM_TYPE,
        payload: ptmType
    }
}

export function selectAllOrganisms() : ISelectAllOrganisms {
    return {
        type: ActionTypes.SELECT_ALL_ORGANISMS
    }
}


export function deselectAllOrganisms() : IDeselectAllOrganisms {
    return {
        type: ActionTypes.DESELECT_ALL_ORGANISMS
    }
}

export function selectOrganism(organism: string) {
    return {
        type: ActionTypes.SELECT_ORGANISM,
        payload: organism
    }
}

export function deselectOrganism(organism: string) {
    return {
        type: ActionTypes.DESELECT_ORGANISM,
        payload: organism
    }
}

export function selectRole(role: Role) {
    return {
        type: ActionTypes.SELECT_ROLE,
        payload: role
    }
}