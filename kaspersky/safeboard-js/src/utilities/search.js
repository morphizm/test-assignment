const hasValue = (item, value) => {
  const keys = Object.keys(item);
  const iter = (elements) => {
    if (elements.length === 0) {
      return false;
    }
    const [key, ...rest] = elements;
    const unit = item[key].toString().toLowerCase();
    if (unit.includes(value.toLowerCase())) {
      return true;
    }
    return iter(rest);
  };
  return iter(keys);
};

const search = (data, value) => {
  const newData = data.reduce((acc, element) => {
    if (hasValue(element, value)) {
      return [...acc, element];
    }
    return acc;
  }, []);
  return newData;
};

export default search;
