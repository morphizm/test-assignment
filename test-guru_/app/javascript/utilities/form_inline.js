const formInlineHandler = (testId) => {
  const link = document.querySelector(`.form-inline-link[data-test-id="${testId}"]`);
  const testTitle = document.querySelector(`.test-title[data-test-id="${testId}"]`);
  const formInline = document.querySelector(`.form-inline[data-test-id="${testId}"]`);

  if (formInline.classList.contains('hide')) {
    testTitle.classList.add('hide');
    formInline.classList.remove('hide');
    link.textContent = 'Cancel';
  } else {
    testTitle.classList.remove('hide');
    formInline.classList.add('hide');
    link.textContent = 'Edit';
  }
};

const formInlineLinkHandler = (event) => {
  event.preventDefault();
  const { testId } = event.target.dataset;
  formInlineHandler(testId);
};

document.addEventListener('turbolinks:load', () => {
  const controls = document.querySelectorAll('.form-inline-link');

  if (controls.length) {
    for (let i = 0; i < controls.length; i += 1) {
      controls[i].addEventListener('click', formInlineLinkHandler);
    }
  }

  const errors = document.querySelector('.resource-errors');
  if (errors) {
    const { resourceId } = errors.dataset;
    formInlineHandler(resourceId);
  }
});
