$( ".list-group-item" ).each(function( i ) {
  var itemCondition = $( this ).attr("value");
    if ( itemCondition == 5 || itemCondition == 4 ) {
      $( this ).addClass("list-group-item-success");
    } else if (itemCondition == 3){
      $( this ).addClass("list-group-item-warning");
     } else if( itemCondition == 2 || itemCondition == 1 ){ 
      $( this ).addClass("list-group-item-danger");
    } else {
    };
  });


$('.icon').click(function () {
  if($(this).hasClass('icon-chevron-down')){
      $(this).removeClass("icon-chevron-down");
      $(this).addClass("icon-chevron-up");
      event.preventDefault()
  } else {      
      $(this).removeClass("icon-chevron-up");
      $(this).addClass("icon-chevron-down");
      event.preventDefault()
  }
}); 

$("#menu-toggle").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
});