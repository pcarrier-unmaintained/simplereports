function wt_start() {
  $.getScript("/libs/visualize.js");
  $('.notice').fadeOut(500);
}

function wt_error(string) {
  $('.notice').css("background-color","red").html(string).show();
}

function wt_info(string) {
  $('.notice').css("background-color","#008040").html(string).show();
}