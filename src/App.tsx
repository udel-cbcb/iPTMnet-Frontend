import * as React from 'react';
import {Route, RouteComponentProps} from 'react-router-dom';

import Home from "./pages/Home"
import Browse from "./pages/Browse"
import Entry from "./pages/Entry"
import Statistics from "./pages/Statistics"
import Api from "./pages/Api"
import License from "./pages/License"
import About from "./pages/About"
import Citation from "./pages/Citation"

class App extends React.Component {
  
  public render() {
    return (
      <div>
        <Route path="/" exact={true} component={Home} />
        <Route path="/browse" exact={true} component={Browse} />
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
    return <Entry id={prop.match.params.id}/>;
  }

}

export default App;
