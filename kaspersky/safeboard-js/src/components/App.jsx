/* eslint-disable no-unused-vars */
/* eslint-disable require-jsdoc */
import React from 'react';
import '../css/App.css';
import {Link} from 'react-router-dom';

/** jsdoc
 * App
 * pathname - "/"
 */
export default class App extends React.Component {
  render() {
    const vdom = (
      <div className="App">
        <header className="App-header">
          <p>
            Users page
          </p>
          <Link className="App-link" to='/users'>Users</Link>
        </header>
      </div>
    );
    return vdom;
  }
}
