$(document).ready(function(){
  if($("#device-content")) {
    $.ajax({
      method: "GET",
      url: "/api/v1/signage",
      dataType: "JSON",
      success: renderContent
    });
  }
});

var renderContent = function(listingInfo){
  var device_code = $("#device-content").attr('class');

  if(listingInfo.error){
    $("#device-content").append(
      "<h1>Screen ID: " + device_code + "</h1>"
    );
  } else {
    renderSign(0, listingInfo, renderSign);
  }
};

var renderSign = function(signNumber, listingInfo, callback) {
  var sign = listingInfo[signNumber];
  $("#device-content").html("");
  $("#device-content").append(
    "<p>" + sign.title + "</p><p>" + sign.ribbon_color + "</p><p>"+
    sign.ribbon + "</p><p>" + sign.subtitle + "</p>" + "<img src='" + sign.best_large_image +"'>"
  );
  window.setTimeout(function(){callback(signNumber + 1, listingInfo, renderSign);}, 4000);
};
