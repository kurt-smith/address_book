// Show Officer form input

$('#addCompanyOfficer').on('click', function(){
  $('input[name="company[company_only]"]').val(false);
  $(this).hide();
  $('#officer_info').show();
});
