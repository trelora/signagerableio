$(document).ready(function(){
  if($("#device-content")) {
    $.ajax({
      method: "GET",
      url: "/api/v1/signage",
      dataType: "JSON",
      success: renderSign
    });
  }
});

var renderSign = function(listingInfo){
  var device_code = $("#device-content").attr('class');

  if(listingInfo.error){
    $("#device-content").append(
      "<h1>Screen ID: " + device_code + "</h1>"
    );
  } else {
    var firstHouse = listingInfo[0];
    $("#device-content").append(
      "<p>" + firstHouse.title + "</p><p>" + firstHouse.ribbon_color + "</p><p>"+
      firstHouse.ribbon + "</p><p>" + firstHouse.subtitle + "</p>" + "<img src='" + firstHouse.best_large_image +"'>"
    );
  }
};
