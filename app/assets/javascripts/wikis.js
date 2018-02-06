$(document).ready( function() {
  $('#wiki_body').keyup(function() {
    var $this = $(this);
    $('.'+$this.attr('id')+'').html($this.val());
  });
});
