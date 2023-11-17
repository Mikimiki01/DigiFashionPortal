document.addEventListener("turbolinks:load", function() {
  $('#search-input').on('keyup', function() {
    var input = $(this).val();
    if (input.length > 0) {
      $('#search-button').prop('disabled', false);
    } else {
      $('#search-button').prop('disabled', true);
    }
  });
});