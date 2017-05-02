/* global $ */

$(function() {
  var $imageDisplay = $('#image_display');
  var $imageSelect = $('#image_select');
  var $imageInput = $('#image');
  var $emailInput = $('#email');
  var $submitInput = $('input[type="submit"]');

  function displayAndConvert(input) {
    if (!filePresent()) {
      return;
    }

    var reader = new FileReader();
    reader.onload = function(e) {
      $imageDisplay.removeClass('hidden');
      $imageDisplay.attr('src', e.target.result);
    };
    reader.onloadend = function() {
      $imageInput.val(reader.result);
    };

    reader.readAsDataURL(input.files[0]);
  }

  function filePresent() {
    return $imageSelect[0].files && $imageSelect[0].files[0];
  }

  function emailPresent() {
    return $emailInput.val() != null && $emailInput.val() != '';
  }

  function enableSubmit() {
    $submitInput.prop('disabled', !(filePresent() && emailPresent()));
  }

  $imageSelect.change(function() {
    displayAndConvert(this);
    enableSubmit();
  });

  $emailInput.keyup(function() {
    enableSubmit();
  });

  $('form').submit(function() {
    $('#image-select-group').remove();
  });
});
