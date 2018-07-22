// Add wait icon while loading third party request

$('form#company_search').on('submit', function(){
  $('#searchResults').html('').append(
    $('<div>', {
      class: 'fa-3x text-center'
    }).append(
      $('<i>', {
        class: 'fas fa-circle-notch fa-spin'
      })
    )
  );
});

// Add wait icon to company info modal load
$('#searchResults').on('click', '.company-link', function(){
  $('body').append($('<div>', {
    class: 'modal-backdrop fade show'
  }))

  $('body').append(
    $('<div>', {
      class: 'fa-3x companyLoader'
    }).append(
      $('<i>', {
        class: 'fas fa-circle-notch fa-spin',
        'z-index': '1000'
      })
    )
  );
});
