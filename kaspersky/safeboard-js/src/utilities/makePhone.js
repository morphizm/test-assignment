const makePhone = (phone) => {
  const first = phone.substr(0, 3);
  const last = phone.substr(3);
  return `(${first}) ${last}`;
};

export default makePhone;
