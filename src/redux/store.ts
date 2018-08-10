import { createStore, applyMiddleware } from "redux";
import { State } from "src/redux/state";
import * as RootReducer from "src/redux/RootReducer";
import { Action } from "src/redux/action";
import thunk from 'redux-thunk';

const store = createStore<State,Action,{},{}>(RootReducer.reducer,applyMiddleware(thunk));
export default store;