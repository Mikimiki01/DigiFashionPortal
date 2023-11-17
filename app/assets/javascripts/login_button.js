document.addEventListener('DOMContentLoaded', function () {
  var loginButton = document.getElementById('login-button');
  var emailField = document.getElementById('user_email');
  var passwordField = document.getElementById('user_password');
  var usernameField = document.getElementById('user_username');
  var togglePasswordButton = document.getElementById('toggle_password');

  function updateButtonState() {
    if (emailField.value && passwordField.value && usernameField.value) {
      loginButton.style.backgroundColor = '#708090';
      loginButton.disabled = false;
    } else {
      loginButton.style.backgroundColor = '#CCCCCC';
      loginButton.disabled = true;
    }
  }

  // パスワード表示切り替え処理
  if (passwordField && togglePasswordButton) {
    togglePasswordButton.addEventListener('click', function () {
      togglePasswordVisibility(passwordField, togglePasswordButton);
    });
  }

  emailField.addEventListener('input', updateButtonState);
  passwordField.addEventListener('input', updateButtonState);
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