/* eslint-disable require-jsdoc */
import React from 'react';
import makePhone from '../utilities/makePhone';

export default class Table extends React.Component {
  render() {
    const {users} = this.props;
    const vdom = users.map((element) => {
      const {
        id, name, surname, group, phone, email,
      } = element;
      return (
        <tr key={id}>
          <th scope="row">{id}</th>
          <td>{`${name} ${surname}`}</td>
          <td>{group}</td>
          <td>{email}</td>
          <td>{makePhone(phone)}</td>
        </tr>
      );
    });

    const table = (
      <table className="table table-sm">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Name & Surname</th>
            <th scope="col">group</th>
            <th scope="col">email</th>
            <th scope="col">phone</th>
          </tr>
        </thead>
        <tbody>
          {vdom}
        </tbody>
      </table>
    );
    return table;
  }
}
