$(document).on('ready turbolinks:load ajax:complete', function() {
  var clearBtn = $('#search_form a');
  $('#search_form input').on('keyup', function() {
    if ($(this).val()) {
      clearBtn.show();
    } else {
      clearBtn.hide();
    }
  });
});
