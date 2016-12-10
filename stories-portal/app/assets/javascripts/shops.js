$('.front_shops.index, .front_shops.show').ready(function(){
  $("#range_price").ionRangeSlider({
    type: "double",
    min: 1,
    max: 370,
    step: 0.1,
    prefix: "R$"
  });
});