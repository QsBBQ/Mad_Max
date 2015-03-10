$(function() {
  $('.accordion-class').accordion();

  $(".checkbox").on('click', function(e) {
    if ($(this).prop('checked')) {
      console.log("codeunion rocks!!")
      $(this).closest('tr').find('.enable').prop('disabled', false);
    }
    else {
      console.log("Unchecked!")
      $(this).closest('tr').find('.enable').prop('disabled', true);
    }
  });
});
