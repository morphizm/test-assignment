/* eslint-disable no-unused-vars */
/* eslint-disable require-jsdoc */
/* eslint-disable no-invalid-this */
/* eslint-disable valid-jsdoc */
import React from 'react';
import logo from '../images/logo.svg';
import Table from './Table';
import Card from './Card';
import Group from './Group';
import Navbar from './Navbar';
import makeSort from '../utilities/sort';
import makeSearch from '../utilities/search';

/** jsdoc
 * User
 * pathname - "/users"
 */
export default class User extends React.Component {
  constructor(props) {
    super(props);
    const {users} = this.props;
    this.state = {
      theme: 'table',
      search: '',
      sort: '',
      sortDirection: 'asc',
      users,
    };
  }

  onClick = (e) => {
    e.preventDefault();
    const newTheme = e.target.id;
    this.setState({theme: newTheme});
  }

  onSort = (e) => {
    e.preventDefault();
    const {users} = this.state;
    const {value} = e.target;
    makeSort(users, ((user) => user[value]));
    this.setState({sort: value});
  };

  onSearch = (e) => {
    e.preventDefault();
    const {users} = this.props;
    const {value} = e.target;
    const newUsers = value === '' ? this.props.users : makeSearch(users, value);
    this.setState({search: value, users: newUsers});
  }

  renderNavbar() {
    const {sort, search} = this.state;
    const {userKeys} = this.props;
    return <Navbar
      sortKeys={userKeys} sort={sort} search={search}
      onSort={this.onSort} onTheme={this.onClick} onSearch={this.onSearch} />;
  }

  render() {
    const {theme} = this.state;
    const {users} = this.state;
    switch (theme) {
      case 'table':
        return (
          <>
            {this.renderNavbar()}
            <Table users={users} />
          </>
        );
      case 'card':
        return (
          <>
            {this.renderNavbar()}
            <Card users={users} logo={logo} />
          </>
        );
      case 'group':
        return (
          <>
            {this.renderNavbar()}
            <Group users={users} />
          </>
        );
      default:
        throw new Error(`${theme} - unknown state`);
    }
  }
}
