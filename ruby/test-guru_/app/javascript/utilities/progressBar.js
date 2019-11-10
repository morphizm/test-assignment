document.addEventListener('turbolinks:load', () => {
  const test = document.querySelector('.test-passage');
  if (test) {
    const { currentQuestionId } = test.dataset;
    const { totalQuestions } = test.dataset;
    const percentProgress = (currentQuestionId / totalQuestions) * 100;
    const progressBar = test.querySelector('.progress-bar');
    progressBar.setAttribute('aria-valuenow', currentQuestionId);
    progressBar.setAttribute('aria-valuemax', totalQuestions);
    progressBar.setAttribute('style', `width: ${percentProgress}%`);
  }
});
