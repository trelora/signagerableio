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

  if(listingInfo.signs.error){
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
    $("#device-content").fadeOut("slow", function(){
      $("#device-content").html("<div class='ribbon' style='background-color: " + sign.ribbon_color + ";' " + ">" + "<div class='design-line'></div>" + "<p>" + sign.ribbon.toUpperCase() + "</p>"  + "</div>" + "<div style='height: 100vh;width: 100vw;background-image: url(\"" + sign.best_large_image + "\");background-size: cover;'>" + "<div id='title'>"+ "<p>" + sign.title.toUpperCase().split(',')[0] + "</p>" + "</div>" + "</div>"
      );
      $("#device-content").fadeIn("slow", function(){
        window.setTimeout(function(){callback(signNumber + 1, listingInfo, renderSign);}, listingInfo.time);
      });
    });
  }
};
