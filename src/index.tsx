import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { BrowserRouter} from "react-router-dom";
import App from './App';
import './index.css';
import registerServiceWorker from './registerServiceWorker';
import store from 'src/redux/store';
import { Provider } from 'react-redux';

ReactDOM.render(
    <Provider store={store}>
       <BrowserRouter>
       <App />
       </BrowserRouter> 
    </Provider>,
  document.getElementById('root') as HTMLElement
);
registerServiceWorker();
