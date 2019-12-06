/* eslint-disable require-jsdoc */
import React from 'react';
import makePhone from '../utilities/makePhone';

export default class Card extends React.Component {
  render() {
    const {users, logo} = this.props;
    const card = users.map((element) => {
      const {
        name, surname, group, phone, email, id,
      } = element;
      return (
        <div className="card d-inline-flex mx-1 mb-1 border-dark overflow-auto"
          key={id} style={{width: '10rem', height: '25rem'}}>
          <img src={logo} className="card-img-top" alt="..." />
          <div className="card-body">
            <h5 className="card-title">{`${name} ${surname}`}</h5>
            <p className="card-text">{group}</p>
          </div>
          <ul className="list-group list-group-flush">
            <li className="list-group-item">{email}</li>
            <li className="list-group-item">{makePhone(phone)}</li>
          </ul>
        </div>
      );
    });

    return <div className="row justify-content-center">{card}</div>;
  }
}
