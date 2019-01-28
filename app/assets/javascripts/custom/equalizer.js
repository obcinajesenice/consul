!function (e, t) {
  "function" == typeof define && define.amd ? define("ev-emitter/ev-emitter", t) : "object" == typeof module && module.exports ? module.exports = t() : e.EvEmitter = t()
}("undefined" != typeof window ? window : this, function () {
  function e() {
  }

  var t = e.prototype;
  return t.on = function (e, t) {
    if (e && t) {
      var i = this._events = this._events || {}, n = i[e] = i[e] || [];
      return n.indexOf(t) == -1 && n.push(t), this
    }
  }, t.once = function (e, t) {
    if (e && t) {
      this.on(e, t);
      var i = this._onceEvents = this._onceEvents || {}, n = i[e] = i[e] || {};
      return n[t] = !0, this
    }
  }, t.off = function (e, t) {
    var i = this._events && this._events[e];
    if (i && i.length) {
      var n = i.indexOf(t);
      return n != -1 && i.splice(n, 1), this
    }
  }, t.emitEvent = function (e, t) {
    var i = this._events && this._events[e];
    if (i && i.length) {
      i = i.slice(0), t = t || [];
      for (var n = this._onceEvents && this._onceEvents[e], o = 0; o < i.length; o++) {
        var r = i[o], s = n && n[r];
        s && (this.off(e, r), delete n[r]), r.apply(this, t)
      }
      return this
    }
  }, t.allOff = function () {
    delete this._events, delete this._onceEvents
  }, e
}), function (e, t) {
  "use strict";
  "function" == typeof define && define.amd ? define(["ev-emitter/ev-emitter"], function (i) {
    return t(e, i)
  }) : "object" == typeof module && module.exports ? module.exports = t(e, require("ev-emitter")) : e.imagesLoaded = t(e, e.EvEmitter)
}("undefined" != typeof window ? window : this, function (e, t) {
  function i(e, t) {
    for (var i in t) e[i] = t[i];
    return e
  }

  function n(e) {
    if (Array.isArray(e)) return e;
    var t = "object" == typeof e && "number" == typeof e.length;
    return t ? d.call(e) : [e]
  }

  function o(e, t, r) {
    if (!(this instanceof o)) return new o(e, t, r);
    var s = e;
    return "string" == typeof e && (s = document.querySelectorAll(e)), s ? (this.elements = n(s), this.options = i({}, this.options), "function" == typeof t ? r = t : i(this.options, t), r && this.on("always", r), this.getImages(), h && (this.jqDeferred = new h.Deferred), void setTimeout(this.check.bind(this))) : void a.error("Bad element for imagesLoaded " + (s || e))
  }

  function r(e) {
    this.img = e
  }

  function s(e, t) {
    this.url = e, this.element = t, this.img = new Image
  }

  var h = e.jQuery, a = e.console, d = Array.prototype.slice;
  o.prototype = Object.create(t.prototype), o.prototype.options = {}, o.prototype.getImages = function () {
    this.images = [], this.elements.forEach(this.addElementImages, this)
  }, o.prototype.addElementImages = function (e) {
    "IMG" == e.nodeName && this.addImage(e), this.options.background === !0 && this.addElementBackgroundImages(e);
    var t = e.nodeType;
    if (t && u[t]) {
      for (var i = e.querySelectorAll("img"), n = 0; n < i.length; n++) {
        var o = i[n];
        this.addImage(o)
      }
      if ("string" == typeof this.options.background) {
        var r = e.querySelectorAll(this.options.background);
        for (n = 0; n < r.length; n++) {
          var s = r[n];
          this.addElementBackgroundImages(s)
        }
      }
    }
  };
  var u = {1: !0, 9: !0, 11: !0};
  return o.prototype.addElementBackgroundImages = function (e) {
    var t = getComputedStyle(e);
    if (t) for (var i = /url\((['"])?(.*?)\1\)/gi, n = i.exec(t.backgroundImage); null !== n;) {
      var o = n && n[2];
      o && this.addBackground(o, e), n = i.exec(t.backgroundImage)
    }
  }, o.prototype.addImage = function (e) {
    var t = new r(e);
    this.images.push(t)
  }, o.prototype.addBackground = function (e, t) {
    var i = new s(e, t);
    this.images.push(i)
  }, o.prototype.check = function () {
    function e(e, i, n) {
      setTimeout(function () {
        t.progress(e, i, n)
      })
    }

    var t = this;
    return this.progressedCount = 0, this.hasAnyBroken = !1, this.images.length ? void this.images.forEach(function (t) {
      t.once("progress", e), t.check()
    }) : void this.complete()
  }, o.prototype.progress = function (e, t, i) {
    this.progressedCount++, this.hasAnyBroken = this.hasAnyBroken || !e.isLoaded, this.emitEvent("progress", [this, e, t]), this.jqDeferred && this.jqDeferred.notify && this.jqDeferred.notify(this, e), this.progressedCount == this.images.length && this.complete(), this.options.debug && a && a.log("progress: " + i, e, t)
  }, o.prototype.complete = function () {
    var e = this.hasAnyBroken ? "fail" : "done";
    if (this.isComplete = !0, this.emitEvent(e, [this]), this.emitEvent("always", [this]), this.jqDeferred) {
      var t = this.hasAnyBroken ? "reject" : "resolve";
      this.jqDeferred[t](this)
    }
  }, r.prototype = Object.create(t.prototype), r.prototype.check = function () {
    var e = this.getIsImageComplete();
    return e ? void this.confirm(0 !== this.img.naturalWidth, "naturalWidth") : (this.proxyImage = new Image, this.proxyImage.addEventListener("load", this), this.proxyImage.addEventListener("error", this), this.img.addEventListener("load", this), this.img.addEventListener("error", this), void(this.proxyImage.src = this.img.src))
  }, r.prototype.getIsImageComplete = function () {
    return this.img.complete && this.img.naturalWidth
  }, r.prototype.confirm = function (e, t) {
    this.isLoaded = e, this.emitEvent("progress", [this, this.img, t])
  }, r.prototype.handleEvent = function (e) {
    var t = "on" + e.type;
    this[t] && this[t](e)
  }, r.prototype.onload = function () {
    this.confirm(!0, "onload"), this.unbindEvents()
  }, r.prototype.onerror = function () {
    this.confirm(!1, "onerror"), this.unbindEvents()
  }, r.prototype.unbindEvents = function () {
    this.proxyImage.removeEventListener("load", this), this.proxyImage.removeEventListener("error", this), this.img.removeEventListener("load", this), this.img.removeEventListener("error", this)
  }, s.prototype = Object.create(r.prototype), s.prototype.check = function () {
    this.img.addEventListener("load", this), this.img.addEventListener("error", this), this.img.src = this.url;
    var e = this.getIsImageComplete();
    e && (this.confirm(0 !== this.img.naturalWidth, "naturalWidth"), this.unbindEvents())
  }, s.prototype.unbindEvents = function () {
    this.img.removeEventListener("load", this), this.img.removeEventListener("error", this)
  }, s.prototype.confirm = function (e, t) {
    this.isLoaded = e, this.emitEvent("progress", [this, this.element, t])
  }, o.makeJQueryPlugin = function (t) {
    t = t || e.jQuery, t && (h = t, h.fn.imagesLoaded = function (e, t) {
      var i = new o(this, e, t);
      return i.jqDeferred.promise(h(this))
    })
  }, o.makeJQueryPlugin(), o
});


var shortenShareLink = function () {
  if ($("#shortner").length < 1) {
    return false;
  }
  var tl = document.location.href;
  $.ajax({
    type: 'GET',
    url: 'https://pp.djnd.si/shortener/generate?url=' + encodeURIComponent(tl),
  }).done(function (data) {
    $('#shortner').val(data);
  }).fail(function (d) {
    console.log(d);
  })
};

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
    $(".image-holder img").imagesLoaded(function () {
      setEh($(".budget-investments .budget-investment-holder .budget-investment"));
    });
  }
  if ($(".technical-issues .inner").length > 0) {
    setEh($(".technical-issues .inner"));
  }

  if ($(".welcome-column .linkable").length > 0) {
    if ($(window).width() > 575) {
      if ($($(window).height()) > $("body").height()) {
        $(".welcome-column .linkable").height($("body").height());
      }
      setEh($(".welcome-columns .column-content h2"));
      var mh = setEh($(".welcome-columns .column-content .abtom4"));
      $(".action-button.large").css({
        "margin-top": (mh / 2) - $(".action-button.large").height()
      });

      $(".hoverlinkable").height($(".footer").offset().top - $("header").outerHeight());
      $(".linkable").height($(".footer").offset().top - $("header").outerHeight());

    }
  }

  if($(".akkordion").length > 0){
    $(".akkordion .title").on("click", function () {

      $(this).parent().toggleClass("active");

    })
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
  shortenShareLink();
});
