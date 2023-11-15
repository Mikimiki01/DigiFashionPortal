document.addEventListener('DOMContentLoaded', function () {
  var signupButton = document.getElementById('signup-button');
  var emailField = document.getElementById('user_email');
  var passwordField = document.getElementById('user_password');
  var passwordConfirmationField = document.getElementById('user_password_confirmation');
  var usernameField = document.getElementById('user_username');
  var togglePasswordButton = document.getElementById('toggle_password');
  var togglePasswordConfirmationButton = document.getElementById('toggle_password_confirmation');

  function updateButtonState() {
    if (emailField.value && passwordField.value && passwordConfirmationField.value && usernameField.value) {
      signupButton.style.backgroundColor = '#708090';
      signupButton.disabled = false;
    } else {
      signupButton.style.backgroundColor = '#CCCCCC';
      signupButton.disabled = true;
    }
  }

  // パスワード表示切り替え処理
  if (passwordField && togglePasswordButton) {
    togglePasswordButton.addEventListener('click', function () {
      togglePasswordVisibility(passwordField, togglePasswordButton);
    });
  }

  if (passwordConfirmationField && togglePasswordConfirmationButton) {
    togglePasswordConfirmationButton.addEventListener('click', function () {
      togglePasswordVisibility(passwordConfirmationField, togglePasswordConfirmationButton);
    });
  }

  emailField.addEventListener('input', updateButtonState);
  passwordField.addEventListener('input', updateButtonState);
  passwordConfirmationField.addEventListener('input', updateButtonState);
  usernameField.addEventListener('input', updateButtonState);

  updateButtonState();
});

function togglePasswordVisibility(passwordField, toggleButton) {
  var fieldType = passwordField.getAttribute('type');
  passwordField.setAttribute('type', fieldType === 'password' ? 'text' : 'password');

  // アイコンの切り替え
  if (fieldType === 'password') {
    toggleButton.innerHTML = '<i class="far fa-eye-slash"></i>'; // Font Awesome closed eye icon
  } else {
    toggleButton.innerHTML = '<i class="far fa-eye"></i>'; // Font Awesome eye icon
  }
}