$('#page_form').submit(function(event) {
  //event.preventDefault();
  alert();

  let valid = true;
  let title = $.trim($('#wiki_title').val());

  if (title.length < 1) {
    $('#wiki_title_error').html('Please enter a title.');
    event.preventDefault();
  }
})