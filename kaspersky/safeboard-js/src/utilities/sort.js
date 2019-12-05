const sort = (data, fn, direction = 'asc') => {
  const compareResult = direction !== 'desc' ? 1 : -1;
  const comparator = (a, b) => {
    const a1 = fn(a);
    const b1 = fn(b);

    if (a1 > b1) {
      return compareResult;
    }
    if (a1 < b1) {
      return -compareResult;
    }

    return 0;
  };
  return data.sort(comparator);
};

export default sort;

