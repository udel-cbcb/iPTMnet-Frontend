import { State } from "./state";
import * as EntryReducer from "./reducers/EntryReducer";
import * as HomePageReducer from "./reducers/HomePageReducer";
import { combineReducers } from "redux";

export const reducer = combineReducers<State>(
      {
           entryPage: EntryReducer.reducer,
           homePage: HomePageReducer.reducer 
      }
)