! function(o) {
    "use strict";

    function e(n) {
        n.each(function() {
            var n = o(this),
                e = n.data("animation");
            n.addClass(e).one("webkitAnimationEnd animationend", function() {
                n.removeClass(e)
            })
        })
    }
    o("[data-toggle='tooltip']").tooltip({
        container: "body"
    }), o("[data-toggle='popover']").popover(), o(window).scroll(function() {
        40 < o(this).scrollTop() ? o("body").addClass("header-scroll") : o("body").removeClass("header-scroll")
    }), o("[data-toggle='fixed-header']").click(function() {
        return o("body").toggleClass("fixed-header"), !1
    }), o(".bar").click(function() {
        o("body").toggleClass("nav-open"), o("#body").click(function() {
            o("body").removeClass("nav-open")
        })
    }), o("section.background-image.full-height").each(function() {
        o(this).css("height", o(window).height())
    }), o(window).resize(function() {
        o("section.background-image.full-height").each(function() {
            o(this).css("height", o(window).height())
        })
    }), o(document).ready(function() {
        var i = o(window);
        o(".parallax").each(function() {
            var e = o(this);
            o(window).scroll(function() {
                var n = "50% " + -i.scrollTop() / "3" + "px";
                e.css({
                    backgroundPosition: n
                })
            })
        })
    }), o("nav .dropdown > a").click(function() {
        return !1
    }), o("nav .dropdown-submenu > a").click(function() {
        return !1
    }), o("nav ul li.dropdown").hover(function() {
        o(this).addClass("open");
        var n = o(this).data("effect");
        n ? o(this).find(".dropdown-menu").addClass("animated " + n) : o(this).find(".dropdown-menu").addClass("animated fast fadeIn")
    }, function() {
        o(this).removeClass("open");
        var n = o(this).data("effect");
        n ? o(this).find(".dropdown-menu").removeClass("animated " + n) : o(this).find(".dropdown-menu").removeClass("animated fast fadeIn")
    }), o("nav .dropdown-submenu").hover(function() {
        o(this).addClass("open")
    }, function() {
        o(this).removeClass("open")
    });
    var n = o("#full-carousel");
    e(n.find(".item:first").find("[data-animation ^= 'animated']")), n.carousel("pause"), n.on("slide.bs.carousel", function(n) {
        e(o(n.relatedTarget).find("[data-animation ^= 'animated']"))
    }), o(".full-carousel .item").each(function() {
        o(this).css("height", o(window).height() - o("header").outerHeight())
    }), o(window).resize(function() {
        o(".full-carousel .item").each(function() {
            o(this).css("height", o(window).height() - o("header").outerHeight())
        })
    }), o(".inactiveUntilOnLoad").removeClass("inactiveUntilOnLoad"), o(".full-height").each(function() {
        o(this).css("height", o(window).height() - o("header").outerHeight())
    }), o(window).resize(function() {
        o(".full-height").each(function() {
            o(this).css("height", o(window).height() - o("header").outerHeight())
        })
    })
}(jQuery);