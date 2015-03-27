$('#na_empty').on("click", function() {
  $('.survey_question').filter( function(index, element) {
    var na_checkbox = $('.na-checkbox', element);
    return naCheckbox && (naCheckbox.prop === false);
  }).each(function(index, element){
    if ( $( ".value-field" ).val().trim() === "" ){
      $( ".na-checkbox", element ).prop === true;
    }
  });
});