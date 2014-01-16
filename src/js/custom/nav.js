/* =============================================================================
   Navigation
========================================================================== */

function Nav() {
    var self = this;
    this.nav = $('.menu--primary');
    this.ul = this.nav.children('ul');
    this.toggle = $('.js--toggle-menu');
    this.hero = $('.hero--fixed');
    this.setHeroHeight = function() {
        if(this.hero.length > 0) {
            $('.content').css({
                marginTop: self.hero.height()
            });
        }
    };
    //this.setHeroHeight();
    this.getSecondaryNav = function() {
        if(G.BodyTag.hasClass('fixed-hero')) {
            return {
                elem: $('.menu--secondary'),
                rect: $('.menu--secondary')[0].getBoundingClientRect(),
                primaryHeight: $('.masthead').height(),
                status: null,
                whiteStatus: null
            };
        } else {
            return null;
        }
    };
    this.secondaryNav = this.getSecondaryNav();
    this.getWaypoints = function() {
        var w1 = $('[data-idx="1"]'),
            w2 = $('[data-idx="2"]'),
            w3 = $('[data-idx="3"]');
        if(w1.length > 0) {
            return {
                1: w1[0].getBoundingClientRect(),
                2: w2[0].getBoundingClientRect(),
                3: w3[0].getBoundingClientRect()
            };
        } else {
            return null;
        }
    };
    this.waypoints = this.getWaypoints();
    this.waypointsStatus = null;
    this.onToggleClick = function(event) {
        this.nav.toggleClass('js--visible');
        return event.preventDefault();
    };

    this.onSecondaryMenuClick = function(idx){
        var target = $('[data-idx="'+idx+'"]'),
            targetOffset = target.offset().top,
            offset = $('.masthead').height() + $('.menu--secondary').height();
        $('html, body').animate({
            scrollTop:targetOffset - offset + 1
        }, 1000, 'easeInOutExpo', function() {

        });
    };

    this.init = function() {
        //console.log(this.waypoints);
    };
    this.init();

    this.animate = function() {

        if(self.secondaryNav !== null) {
            if(G.Scroll.st + self.secondaryNav.primaryHeight >= self.secondaryNav.rect.top) {
            //if(G.Scroll.st > 0) {
                if(self.secondaryNav.rect.status !== 'sticky') {
                    G.HtmlTag.addClass('js--sticky');
                    self.secondaryNav.rect.status = 'sticky';
                }
            } else {
                if(self.secondaryNav.rect.status !== 'non-sticky') {
                    G.HtmlTag.removeClass('js--sticky');
                    self.secondaryNav.rect.status = 'non-sticky';
                }
            }
            if(G.Scroll.st > 0) {
                if(self.secondaryNav.rect.whiteStatus !== 'white') {
                    G.HtmlTag.addClass('js--white');
                    self.secondaryNav.rect.whiteStatus = 'white';
                }
            } else {
                if(self.secondaryNav.rect.whiteStatus !== 'not-white') {
                    G.HtmlTag.removeClass('js--white');
                    self.secondaryNav.rect.whiteStatus = 'not-white';
                }
            }
        }

        if(self.waypoints !== null) {
            var offset = $('.masthead').height() + $('.menu--secondary').height();
            if(self.waypoints[3].top < offset + (G.Size.BrowserHeight * 0.25)) {
                if(self.waypointsStatus !== 3) {
                    $('.menu__link--secondary').removeClass('js--active');
                    $('[data-idx-link="3"]').addClass('js--active');
                    self.waypointsStatus = 3;
                }
            } else if(self.waypoints[2].top < offset) {
                if(self.waypointsStatus !== 2) {
                    $('.menu__link--secondary').removeClass('js--active');
                    $('[data-idx-link="2"]').addClass('js--active');
                    self.waypointsStatus = 2;
                }
            } else {
                if(self.waypointsStatus !== 1) {
                    $('.menu__link--secondary').removeClass('js--active');
                    $('[data-idx-link="1"]').addClass('js--active');
                    self.waypointsStatus = 1;
                }
            }
        }
    };

    $(document).on('click', '.js--toggle-menu', function(e) {
        self.onToggleClick(e);
    });

    $(document).on('click', '.js--scroll-to-section', function(e) {
        var idx = $(this).attr('data-idx-link');
        self.onSecondaryMenuClick(idx);
        e.preventDefault();
    });

    G.Window.on('scroll', function() {
        self.waypoints = self.getWaypoints();
        self.animate();
    });

    G.Window.on('resize', function() {


        self.secondaryNav = self.getSecondaryNav();

        //self.setHeroHeight();
    });
}