import { createStore, applyMiddleware } from "redux";
import { State } from "./state";
import * as RootReducer from "./RootReducer";
import { Action } from "./actions/action";
import thunk from 'redux-thunk';

const store = createStore<State,Action,{},{}>(RootReducer.reducer,applyMiddleware(thunk));
export default store;