$(document).ready( function() {
  var md = window.markdownit();

  $('#wiki_body').keyup(function() {
    var text = md.render($(this).val());
    $('.wiki_body').html(text);
  });
});
