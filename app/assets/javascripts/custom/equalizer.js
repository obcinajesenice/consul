$(document).on('page:change', function () {
  var c = $("#custom_phases_tabs li");
  if (c.length == 3) {
    $(".custom-phases-nav .tabs li").css({
      width: "32.8%"
    })
  }

  if ($(".budget-investments .budget-investment-holder").length > 0) {
    var mh = 0;
    var bdesc = $(".budget-investments .budget-investment-holder .budget-investment-content");
    bdesc.each(function () {
      if ($(this).height() > mh) {
        mh = $(this).height();
      }
    });
    if (mh > 0) {
      bdesc.height(mh);
    }
  }
  if ($(".welcome-column .linkable").length > 0) {
    $(".welcome-column .linkable").height($(".welcome-column").height());
  }

  $(".wrapper").css({
    //  "padding-bottom":$(".footer").height()
  });

  if ($(".landings").length > 0) {
    $(".qs").each(function () {
      var himg = $(this).find("img").height();
      var it = $(this).find(".js-padt");
      it.css({
        "padding-top": ((himg - it.height()) / 2)
      })
    });
  }
});
