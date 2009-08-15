function wt_start() {
    // $('.folders .add').ajaxForm({
    //   beforeSubmit: function(formData, jqForm, options) {
    //     options['url'] = '/resources/' + formData[1].value + '/';
  wt_hash2analyzed();

  wt_analyzed2hash();
  //Loaded!
  $('main_interface').removeClassName('hidden');
  $('noticebar').removeClassName('loading');
  wt_message('Loaded', 'error');
}

function wt_hash2analyzed() {
  try {
    wt_analyzed = location.hash.substring(1).evalJSON(true);
  } catch(err) {
    wt_analyzed = [];
  }
}

function wt_analyzed2hash() {
  location.hash = wt_analyzed.toJSON();
}

// 
// function wt_add_analyzed(filename) {
//   wt_analyzed.push(filename);
// }
// 
// function wt_remove_analyzed(filename) {
//   var pos = $.inArray(filename, wt_analyzed);
//   if(pos > 0) {
//     wt_analyzed.splice(pos, 1);
//   }
// }
// 

function wt_message(string, status) {
  $('noticebar').update(string);
  if(status == 'error') {
    $('noticebar').removeClassName('error');
    $('noticebar').addClassName('notice');
  } else {
    $('noticebar').removeClassName('notice');
    $('noticebar').addClassName('error');
  }
}