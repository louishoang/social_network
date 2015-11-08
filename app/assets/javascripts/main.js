$(function(){
  var $trendings = $("#trendings");

  function getLocation(elm) {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        $trendings.innerHTML = "Geolocation is not supported by this browser.";
    }
  }
  function showPosition(position) {
      $trendings.find("#longitude").val(position.coords.latitude);
      $trendings.find()
      $trendings.innerHTML = "Latitude: " + position.coords.latitude + 
      "<br>Longitude: " + position.coords.longitude; 
  }


  getLocation();

  var renderUI = function(cx){
    //HTML text editor
    tinymce.init({
      selector: ".text-editor",
      menubar: false,
      statusbar: false,
      height : "40",
      convert_urls: false,
      autoresize_min_height: 50,
      autoresize_max_height: 500,
      setup: function(editor) {
        editor.on("keyup change", function(e){
          e.preventDefault();
          // copy content to the selector for validation;
          _content = tinyMCE.activeEditor.getContent();
          $(".text-editor").text(tinyMCE.activeEditor.getContent()); 
          tinyMCE.triggerSave();
        });
        editor.on('blur', function(e){         
        });
        // Set placeholder
        var placeholder = $('#' + editor.id).attr('placeholder');
        if (typeof placeholder !== 'undefined' && placeholder !== false) {
          var is_default = false;
          editor.on('init', function() {
            // get the current content
            var cont = editor.getContent();

            // If its empty and we have a placeholder set the value
            if (cont.length === 0) {
              editor.setContent(placeholder);
              // Get updated content
              cont = placeholder;
            }
            // convert to plain text and compare strings
            is_default = (cont == placeholder);

            // nothing to do
            if (!is_default) {
              return;
            }
          })
          .on('focus', function() {
            // replace the default content on focus if the same as original placeholder
            if (is_default) {
              editor.setContent('');
            }
          })
          .on('blur', function() {
            if (editor.getContent().length === 0) {
              editor.setContent(placeholder);
            }
          });
        }
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

  $(document).on("click", ".get_comments", function(e){
    $this = $(e.target);
    $commentsElm = $($this.data("replace"));
    if(parseInt($this.text()) !== 0 && $commentsElm.html().length == 0){
      url = $this.data("url");
      $.ajax({
        url: url,
        success: function(resp){
          $commentsElm.html(resp);
          renderUI($commentsElm);
        }
      });
    }else if(parseInt($this.text()) !== 0 && $commentsElm.html().length > 0 && $commentsElm.is(":hidden")){
      $commentsElm.show();
    }else{
      $commentsElm.hide();
    }
  });
});

