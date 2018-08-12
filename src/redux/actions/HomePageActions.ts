export enum ActionTypes {
    SELECT_ALL_PTM_TYPES = 'SELECT_ALL_PTM_TYPES',
    DESELECT_ALL_PTM_TYPES = 'DESELECT_ALL_PTM_TYPES',
    SELECT_PTM_TYPE = 'SELECT_PTM_TYPE',
    DESELECT_PTM_TYPE = 'DESELECT_PTM_TYPE'
}

export type HomePageAction = ISelectAllPTMTypes
                                | IDeSelectAllPTMTypes
                                | ISelectPTMType
                                | IDeSelectPTMType

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

export function deSelectPTMType(ptmType: string) : IDeSelectPTMType {
    return {
        type: ActionTypes.DESELECT_PTM_TYPE,
        payload: ptmType
    }
}