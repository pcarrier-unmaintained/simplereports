function message (type, text) {
  var mb = $('messagebar');
  mb.hide();
  mb.update(text);
  switch(type) {
    case "notice":
      mb.addClassName('notice').removeClassName('error');
      break;
    case "error":
      mb.addClassName('error').removeClassName('notice');
      break;
  }
  mb.show();
}
//$('messagebar').removeClassName('loading').hide();
//message("notice", "Hello!");