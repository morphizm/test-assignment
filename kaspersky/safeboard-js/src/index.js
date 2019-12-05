/* eslint-disable no-unused-vars */
import React from 'react';
import ReactDOM from 'react-dom';
import * as serviceWorker from './utilities/serviceWorker';
import {BrowserRouter, Route} from 'react-router-dom';
import './css/index.css';
import App from './components/App';
import User from './components/User';
import dataset from './utilities/dataset';

const {users, userKeys} = JSON.parse(dataset());

ReactDOM.render(
    <BrowserRouter>
      <Route exact={true} path="/" component={App} />
      <Route path="/users" render={() => <User users={users}
        userKeys={userKeys} />} />
    </BrowserRouter>,
    document.getElementById('container-fluid'));

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls;
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();

