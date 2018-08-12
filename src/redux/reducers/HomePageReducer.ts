import { HomePageAction, ActionTypes } from "../actions/HomePageActions";
import { HomePageState, initialState } from "src/redux/states/HomePageState";

export function reducer (state: HomePageState = initialState, action: HomePageAction) : HomePageState {
    if(state === undefined){
        return new HomePageState();
    }else{
        switch (action.type) {
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
            default:
                return new HomePageState();  
        }
    }
 
}