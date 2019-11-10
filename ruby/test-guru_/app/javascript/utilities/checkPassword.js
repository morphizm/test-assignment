const checkPassword = () => {
  const passwordConfirmationElement = document.getElementById('user_password_confirmation');
  const passwordElement = document.getElementById('user_password');
  const passwordConfirmation = passwordConfirmationElement.value;
  const password = passwordElement.value;
  if (passwordConfirmation === '') {
    return;
  }
  if (passwordConfirmation === password) {
    passwordConfirmationElement.classList.remove('is-invalid');
    passwordElement.classList.remove('is-invalid');
    passwordConfirmationElement.classList.add('is-valid');
    passwordElement.classList.add('is-valid');
  } else {
    passwordConfirmationElement.classList.remove('is-valid');
    passwordElement.classList.remove('is-valid');
    passwordConfirmationElement.classList.add('is-invalid');
    passwordElement.classList.add('is-invalid');
  }
};

document.addEventListener('turbolinks:load', () => {
  const registrationForm = document.querySelector('form.registration');
  if (registrationForm) {
    registrationForm.addEventListener('input', checkPassword);
  }
});
