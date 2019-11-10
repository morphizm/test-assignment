const compareRowsAsc = (row1, row2) => {
  const testTitle1 = row1.querySelector('td').textContent;
  const testTitle2 = row2.querySelector('td').textContent;
  if (testTitle1 < testTitle2) {
    return -1;
  }
  if (testTitle1 > testTitle2) {
    return 1;
  }
  return 0;
};

const compareRowsDesc = (row1, row2) => {
  const testTitle1 = row1.querySelector('td').textContent;
  const testTitle2 = row2.querySelector('td').textContent;
  if (testTitle1 > testTitle2) {
    return -1;
  }
  if (testTitle1 < testTitle2) {
    return 1;
  }
  return 0;
};


const sortRowsByTitle = ({ target }) => {
  const table = document.querySelector('table');
  const rows = table.querySelectorAll('tr');
  const sortedRows = [];
  // select all table rows except the first one which is the header
  for (let i = 1; i < rows.length; i += 1) {
    sortedRows.push(rows[i]);
  }

  if (target.querySelector('.octicon-arrow-up').classList.contains('hide')) {
    sortedRows.sort(compareRowsAsc);
    target.querySelector('.octicon-arrow-up').classList.remove('hide');
    target.querySelector('.octicon-arrow-down').classList.add('hide');
  } else {
    target.querySelector('.octicon-arrow-down').classList.remove('hide');
    target.querySelector('.octicon-arrow-up').classList.add('hide');
    sortedRows.sort(compareRowsDesc);
  }

  const sortedTable = document.createElement('table');
  sortedTable.classList.add('table');
  sortedTable.appendChild(rows[0]);
  for (let i = 0; i < sortedRows.length; i += 1) {
    sortedTable.appendChild(sortedRows[i]);
  }
  table.parentNode.replaceChild(sortedTable, table);
};

document.addEventListener('turbolinks:load', () => {
  const control = document.querySelector('.sort-by-title');
  if (control) {
    control.addEventListener('click', sortRowsByTitle);
  }
});
