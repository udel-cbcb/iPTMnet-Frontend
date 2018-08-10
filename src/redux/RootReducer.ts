import { State } from "./state";
import * as EntryReducer from "./reducers/EntryReducer";
import { combineReducers } from "redux";

export const reducer = combineReducers<State>(
      {
           entryPage: EntryReducer.reducer 
      }
)