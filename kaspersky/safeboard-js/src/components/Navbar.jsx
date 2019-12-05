/* eslint-disable require-jsdoc */
import React from 'react';
import _ from 'lodash';
import {Link} from 'react-router-dom';

export default class Navbar extends React.Component {
  renderOptions() {
    const {sortKeys} = this.props;
    const vdom = sortKeys.map((element) => {
      return (
        <React.Fragment key={_.uniqueId()}>
          <option value={element}>{element}</option>
        </React.Fragment>
      );
    });
    return vdom;
  }

  render() {
    const {search, sort, onSort, onSearch, onTheme} = this.props;

    const nav = (
      <nav className="navbar navbar-expand-lg navbar-light bg-white">
        <Link className="navbar-brand" to="/">SafeBoard</Link>
        <button className="navbar-toggler" type="button" data-toggle="collapse"
          data-target="#navbarNav" aria-controls="navbarNav"
          aria-expanded="false" aria-label="Toggle navigation">
          <span className="navbar-toggler-icon"></span>
        </button>
        <div className="collapse navbar-collapse" id="navbarNav">
          <ul className="navbar-nav">
            <li className="nav-item">
              <a href="#table" onClick={onTheme}
                className="nav-link" id="table">Table</a>
            </li>
            <li className="nav-item">
              <a href="#card" onClick={onTheme}
                className="nav-link" id="card">Cards</a>
            </li>
            <li className="nav-item">
              <a href="#group" onClick={onTheme}
                className="nav-link" id="group">Groups</a>
            </li>
          </ul>
        </div>
        <form className="form-inline my-2 my-lg-0">
          <div className="form-group mr-1">
            <select value={sort} onChange={onSort}
              id="sort" className="form-control">
              <option>Sort by</option>
              {this.renderOptions()}
            </select>
          </div>
          <div className="form-group">
            <input value={search} onChange={onSearch}
              id="search" className="form-control mr-sm-2" type="search"
              placeholder="Search" aria-label="Search" />
          </div>
        </form>
      </nav>
    );

    return nav;
  }
}
