import { HomePageAction, ActionTypes } from "../actions/HomePageActions";
import { HomePageState, initialState } from "../states/HomePageState";


export function reducer (state: HomePageState = initialState, action: HomePageAction) : HomePageState {
    if(state === undefined){
        return new HomePageState();
    }else{
        switch (action.type) {
            case ActionTypes.SET_SEARCH_TERM: {
                return {...state,searchTerm:action.payload}
            }
            case ActionTypes.SET_SEARCH_TERM_TYPE: {
                return {...state,searchTermType:action.payload}
            }
            case ActionTypes.SELECT_ALL_PTM_TYPES:{
                const ptms = ["Acetylation",
                              "N-Glycosylation",
                              "O-Glycosylation",
                              "C-Glycosylation",
                              "S-Glycosylation",
                              "Methylation",
                              "Myristoylation",
                              "Phosphorylation",
                              "Sumoylation",
                              "Ubiquitination",
                              "S-Nitrosylation"  
                            ]
                return {...state,selectedPTMs: ptms};
            }
            case ActionTypes.DESELECT_ALL_PTM_TYPES:
                return {...state,selectedPTMs: []};
            case ActionTypes.SELECT_PTM_TYPE: {
                const new_ptms = state.selectedPTMs.slice(0,state.selectedPTMs.length)
                new_ptms.push(action.payload);
                return {...state,selectedPTMs: new_ptms};
            }
            case ActionTypes.DESELECT_PTM_TYPE: {
                const new_ptms = state.selectedPTMs.slice(0,state.selectedPTMs.length)
                const index = new_ptms.indexOf(action.payload, 0);
                if (index > -1) {
                    new_ptms.splice(index, 1);
                }
                return {...state,selectedPTMs: new_ptms};
            }
            case ActionTypes.SELECT_ALL_ORGANISMS: {
                const organisms = ["9606","9913","7215","4896","3880","10090",
                                    "9031","124036","344310","35790","10114","7955",
                                    "4932","4577"];
                return {...state,selectedOrganisms: organisms};
            }
            case ActionTypes.DESELECT_ALL_ORGANISMS: {
                return {...state,selectedOrganisms: []};
            }
            case ActionTypes.SELECT_ORGANISM: {
                const new_organisms = state.selectedOrganisms.slice(0,state.selectedOrganisms.length)
                new_organisms.push(action.payload);
                console.log(new_organisms);
                return {...state,selectedOrganisms: new_organisms};
            }
            case ActionTypes.DESELECT_ORGANISM: {
                const new_organisms = state.selectedOrganisms.slice(0,state.selectedOrganisms.length)
                const index = new_organisms.indexOf(action.payload, 0);
                if (index > -1) {
                    new_organisms.splice(index, 1);
                }
                return {...state,selectedOrganisms: new_organisms};
            }
            case ActionTypes.SELECT_ROLE: {
                return {...state,selectedRole: action.payload}
            }
            case ActionTypes.RESET_OPTIONS: {
                return initialState;
            }
            default:
                return state;  
        }
    }
 
}