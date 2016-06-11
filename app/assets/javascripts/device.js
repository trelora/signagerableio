$(document).ready(function(){
  if($("#device-content")) {
    pullSlides();
  }
});

var pullSlides = function() {
  $.ajax({
    method: "GET",
    url: "/api/v1/signage",
    dataType: "JSON",
    success: renderContent
  });
};


var renderContent = function(listingInfo){
  var deviceCode = $("#device-content").attr('class');

  if(listingInfo.error){
    $("#device-content").html("<h1>Screen ID: " + deviceCode + "</h1>");
    window.setTimeout(function(){pullSlides();}, 10000);
  } else {
    renderSign(0, listingInfo, renderSign);
    console.log(listingInfo);
  }
};

var renderSign = function(signNumber, listingInfo, callback) {
  if(signNumber == listingInfo.signs.length -1) {
    pullSlides();
  } else {
    var sign = listingInfo.signs[signNumber];
    $("#device-content").html("<p>" + sign.title + "</p><p>" + sign.ribbon_color + "</p><p>" + sign.ribbon + "</p><p>" + sign.subtitle + "</p>" + "<img src='" + sign.best_large_image +"'>"
    );
    window.setTimeout(function(){callback(signNumber + 1, listingInfo, renderSign);}, listingInfo.time);
  }
};
