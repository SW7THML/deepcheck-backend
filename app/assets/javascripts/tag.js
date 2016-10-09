$(function(){
    $('.attendance .tag').on("mouseenter", function(){
      var user_id = $(this).data("user-id");
      var grid_id = '#grid-' + user_id;
      
      $(grid_id)
        .removeClass('tag-leaved')
        .addClass('tag-selected');
    });

    $('.attendance .tag').on("mouseleave", function(){
      var user_id = $(this).data("user-id");
      var grid_id = '#grid-' + user_id;

      $(grid_id)
        .removeClass('tag-selected')
        .addClass('tag-leaved');
    });
});