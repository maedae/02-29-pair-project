//show and hide menues
$( ".roomSelector" ).on( "click", function(){
  var selectedFeatures = $(this).attr("value");
    $("#room" + selectedFeatures + "Features").toggle();
});