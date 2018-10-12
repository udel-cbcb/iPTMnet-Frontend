import * as React from 'react';
import {Route, RouteComponentProps} from 'react-router-dom';

import Home from "./pages/Home"
import Browse from "./pages/Browse"
import Statistics from "./pages/Statistics"
import Api from "./pages/Api"
import License from "./pages/License"
import About from "./pages/About"
import Citation from "./pages/Citation"
import store from './redux/store';
import * as EntryActions from "./redux/actions/EntryActions";
import * as SearchResultsActions from "./redux/actions/SearchResultsActions";
import { ThunkDispatch } from 'redux-thunk';
import { Action } from './redux/actions/action';
import { Store } from 'redux';
import Entry from './pages/Entry';
import { SearchResultsConnected } from './pages/SearchResults';


class App extends React.Component {
  
  public render() {
    return (
      <div style={{margin: 0,height: "100%"}} >
        <Route path="/" exact={true} component={Home} />
        <Route path="/search/:search_query" exact={true} render={this.buildSearchResults} />
        <Route path="/home" exact={true} component={Home} />
        <Route path="/browse/:query" exact={true} render={this.buildBrowsePage} />
        <Route path="/statistics" exact={true} component={Statistics} /> 
        <Route path="/api" exact={true} component={Api} /> 
        <Route path="/license" exact={true} component={License} />
        <Route path="/citation" exact={true} component={Citation} />
        <Route path="/about" exact={true} component={About} /> 
        <Route path="/entry/:id" exact={true} render={this.buildEntry} /> 
      </div>
    );
  }

  private buildEntry(prop:RouteComponentProps<any>) {
    const thunkDispatch : ThunkDispatch<Store,void,Action> = store.dispatch; 
    thunkDispatch(EntryActions.loadInfo(prop.match.params.id));
    thunkDispatch(EntryActions.loadProteoforms(prop.match.params.id));
    return <Entry id={prop.match.params.id}/>;
  }

  private buildSearchResults(prop:RouteComponentProps<any>) {
    const thunkDispatch : ThunkDispatch<Store,void,Action> = store.dispatch;
    thunkDispatch(SearchResultsActions.loadSearchResults(prop.match.params.search_query,0,28));
    return <SearchResultsConnected/>;
  }

  private buildBrowsePage(prop:RouteComponentProps<any>) {
    const query = prop.match.params.query;
    return <Browse query={query} history={prop.history}/>
  }

}

export default App;
