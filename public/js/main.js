function wt_start() {
  $.getScript("/libs/visualize.js");
  $.getScript("/libs/jquery.form.js", function() {
    $('.folders .add').ajaxForm({
      beforeSubmit: function(formData, jqForm, options) {
        options['url'] = '/resources/' + formData[1].value + '/';
    }});
    $('.files .add').ajaxForm({
      beforeSubmit: function(formData, jqForm, options) {
        options['url'] = '/resources/' + formData[1].value;
    }});
  });
  wt_build_analyzed();
  $('.notice').fadeTo(500, 0);
  $('.main').show("fast");
}

function wt_make_add_form(elem) {
  elem.ajaxForm();
}

function wt_build_analyzed() {
  var s = location.hash || '';
  wt_analyzed = s.split("+");
}

function wt_add_analyzed(filename) {
  wt_analyzed.push(filename);
}

function wt_remove_analyzed(filename) {
  for (var i = wt_analyzed.length - 1; i >= 0; i--){
    if(filename == wt_analyzed[i]) wt_analyzed.splice(i, 1);
    break;
  };
}

function wt_error(string) {
  $('.notice').css("background-color","red").html(string).fadeTo("fast", 0).fadeTo("fast", 1);
}

function wt_info(string) {
  $('.notice').css("background-color","#008040").html(string).fadeTo("fast", 0).fadeTo("fast", 1);
}