/* eslint-disable require-jsdoc */
import React from 'react';
import _ from 'lodash';

export default class Group extends React.Component {
  renderGroup(items) {
    const vdom = items.map((element) => {
      const {name, surname, group, id} = element;
      const result = (
        <React.Fragment key={id}>
          <li className="list-group-item">
            {`${name} ${surname}`}, {group}
          </li>
        </React.Fragment>
      );
      return result;
    });
    return <ul className="list-group list-group-flush">{vdom}</ul>;
  }

  render() {
    const {users} = this.props;
    const parseGroups = users.reduce((acc, element) => {
      const {group} = element;
      if (!acc.has(group)) {
        return acc.set(group, [element]);
      }
      const elements = acc.get(group);
      return acc.set(group, [...elements, element]);
    }, new Map());

    const keys = Array.from(parseGroups.keys());
    const vdom = keys.map((key) => {
      const values = parseGroups.get(key);
      return (
        <div key={_.uniqueId()}
          className="card col-4 col-md-4 col-xl-3 mt-1 mx-1 px-1
                    border-danger">
          <div className="card-header">{key}</div>
          {this.renderGroup(values)}
        </div>
      );
    });
    return (
      <div className="row justify-content-center">
        {vdom}
      </div>
    );
  }
}
