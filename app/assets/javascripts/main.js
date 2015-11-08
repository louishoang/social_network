$( document ).ready(function() {
  function getLocation(elm) {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
    } else {
      console.log("Geolocation is not supported by this browser.");
    }
  }
  function showPosition(position) {
    localStorage["longitude"] = position.coords.longitude;
    localStorage["latitude"] = position.coords.latitude; 
  }

  if(!localStorage["longitude"]){
    getLocation();
  }

  var $weather = $("#current-weather");

  if($weather.length > 0){
    $.ajax({
      url: "/weather?longitude=" + localStorage["longitude"] + "&latitude=" + localStorage["latitude"],
      success: function(resp){
        $weather.html(resp);
      }
    });
  }
  
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

  var renderForm = function(){
    $(".comment-form").on("ajax:success", function(e, data, status, xhr){
      postID = $(e.target).find("#comment_post_id").val();
      $currentCommentCount = $($(document).find("#post_" + postID + "_comment"));
      _append_content = data.comment_content;

      if(_append_content !== undefined && $currentCommentCount.text() < data.count){
        $currentCommentCount.text(data.count);
        $append = $($(e.target).data("append-el"));
        $append.append(_append_content);
        $append.attr("loaded", "loaded");
      }
      $(e.target)[0].reset();
    });
  }

  renderForm();
  $formAjax = $(".form-ajax");

  $formAjax.on("ajax:success", function(e, data, status, xhr){
    _message = data.message;
    if(_message !== undefined){
      toastr.success(_message);
    }
  }).on("ajax:error", function(e, xhr, status, error){
    resp = $.parseJSON(xhr.responseText);
    _message = resp.message;
    if(_message !== undefined){
      toastr.error(_message);
    }
  }).on("ajax:complete", function(e, xhr, settings){
    resp = $.parseJSON(xhr.responseText);

    // Redirect if needed
    _location = resp.location;
    if(_location !== undefined && _location.length > 0 ){
      $(location).attr('href', _location);
    }

    //Modify DOM with content
    _prepend_content = resp.prepend_content;
    if(_prepend_content !== undefined){
      $prepend = $($(e.target).data("prepend-el"));
      $(_prepend_content).prependTo($prepend).hide().slideDown( "slow");
      renderForm();
    }

    _append_content = resp.append_content;
    if(_append_content !== undefined){
      $append = $($(e.target).data("append-el"));
      $append.append(_append_content);
    }

    //reset form
    $formAjax[0].reset();
  });


  $(document).on("click", ".get_comments", function(e){
    $this = $(e.target);
    $commentsElm = $($this.data("replace"));
    if(parseInt($this.text()) !== 0){
      url = $this.data("url");
      $.ajax({
        url: url,
        success: function(resp){
          $commentsElm.html(resp);
          renderUI($commentsElm);
        }
      });
    }
  });

  toastr.options = {
    "closeButton": true,
    "debug": false,
    "newestOnTop": false,
    "progressBar": false,
    "positionClass": "toast-top-right",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "7000",
    "hideDuration": "3000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  };

});

