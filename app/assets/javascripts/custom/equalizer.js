function setEh(what) {
  var mh = 0;
  var bdesc = what;
  bdesc.each(function () {
    if ($(this).height() > mh) {
      mh = $(this).height();
    }
  });
  if (mh > 0) {
    bdesc.height(mh);
  }
  return mh;
}
$(document).on('page:change', function () {
  var custom_phases_tabs = $("#custom_phases_tabs li");
  if (custom_phases_tabs.length > 0) {
    if ($(window).width() > 575) {
      if (custom_phases_tabs.length == 3) {
        $(".custom-phases-nav .tabs li").css({
          width: "32.8%"
        })
      }
    }
  }
  $("body").css({
    "padding-bottom": $(".footer").height()
  });

  if ($(".budget-investments .budget-investment-holder").length > 0) {
    setEh($(".budget-investments .budget-investment-holder .budget-investment"));
  }

  if ($(".welcome-column .linkable").length > 0) {
    if ($(window).width() > 575) {
      if($($(window).height()) > $("body").height()) {
        $(".welcome-column .linkable").height($("body").height());
      }
      setEh($(".welcome-columns .column-content h2"));
      var mh = setEh($(".welcome-columns .column-content .abtom4"));
      $(".action-button.large").css({
        "margin-top": (mh / 2) - $(".action-button.large").height()
      })
    }
  }



  /*
  if ($(".landings").length > 0) {
    $(".qs").each(function () {
      var himg = $(this).find("img").height();
      var it = $(this).find(".js-padt");
      it.css({
        "padding-top": ((himg - it.height()) / 2)
      })
    });
  }
  */
});
