$(function(){
  var renderUI = function(cx){
    //HTML text editor
    tinymce.init({
      selector: ".text-editor",
      menubar: false,
      statusbar: false,
      height : "40",
      autoresize_min_height: 50,
      autoresize_max_height: 500,
      setup: function(editor) {
        editor.on('blur', function(e){         
        });
      },
      plugins: [
        "autoresize advlist autolink link image lists charmap hr anchor pagebreak spellchecker",
        "searchreplace visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
        "table contextmenu directionality emoticons template paste textcolor"
      ],
      toolbar: "bold italic | link image | media fullpage | forecolor backcolor emoticons" , 
      style_formats: [
        {title: 'Bold text', inline: 'b'},
        {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
        {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
        {title: 'Example 1', inline: 'span', classes: 'example1'},
        {title: 'Example 2', inline: 'span', classes: 'example2'},
        {title: 'Table styles'},
        {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
        ]
    });
  }

  $(document).on("renderUI", function(e, context){
    renderUI(context);
  });

  // calling render jquery 
  renderUI(document);
});

