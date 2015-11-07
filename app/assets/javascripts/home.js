$(function(){
  if($('#infinite-scrolling').size() > 0){
    $(window).on("scroll", function(){
      var more_posts_url = $('.pagination .next_page a').attr('href');
      if(more_posts_url !== undefined && $(window).scrollTop() > $(document).height() - $(window).height() - 200){
        $('.pagination').html('<img class="loading-sign" src="/assets/loading.gif" alt="Loading..." title="Loading..." />');
        setTimeout(function() {   
          $.getScript(more_posts_url);
        }, 500);      
      }
    });
  }
});