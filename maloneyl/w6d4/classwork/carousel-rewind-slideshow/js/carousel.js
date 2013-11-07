// a class that represents an image carousel
// it encapsulates all data and functions needed

function Carousel(sel, h, w, options) { // upper camel case because we're treating it as a class

	// freeze value of "this" so it is unambiguous in our functions
	// this is a common trick
	var self = this; // the object we're currently in and will add properties to with the functions below

	// initialize an instance of Carousel
	// NOTE: we must call this ourselves (see bottom); this is not ruby
	function initialize(sel, h, w, options) { // passing in: selector, height, width, options like transitionDuration
		self.sel = sel; // or the equvialent: self[sel] = sel;
		self.imageHeight = h;
		self.imageWidth = w;

		// handle options
		var defaultOptions = {
			transitionDuration: 200,
			loop: true,
			slideshow: false,
			waitTime: 1000
		}
		$.extend(self, defaultOptions, options) // $.extend is similar to merging hashes in ruby:
		// the rightmost argument overrides the value of a common key
		// so here we have self overridden by defaultOptions, then overridden by options
		// overriding only applies to keys that are common
		// previously-nonexistent keys will just get the new values

		self.$carousel = $(self.sel); // $carousel to remind ourselves this is a jQuery object
		self.$carousel
			.addClass("carousel")
			.height(self.imageHeight) // method equivalent to .css('height', imageHeight)
			.width(self.imageWidth)
			.append('<a class="carousel-direction previous"><</a><a class="carousel-direction next">></a><a class="carousel-slideshow-control">SLIDESHOW</a>');

		self.$slider = self.$carousel.children(".slider"); // get a set of all sliders we have; direct descendants with the class slider
		self.$slider
			.addClass("carousel-slider")
			.css("left", 0);
		// note that by this point our images are still stacked vertically

		self.$images = self.$slider.children("img") // get a set of all images we have (direct descendants of img type)
		self.$images
			.height(self.imageHeight)
			.width(self.imageWidth)

		// now that we know how many images we have in that set,
		// we can set the slider's width to be that many images' width
		// this is so the images are stacked to the right and not on top of each other
		self.$slider.width(self.imageWidth * self.$images.length);

		self.$next = self.$carousel.children(".carousel-direction.next");
		self.$previous = self.$carousel.children(".carousel-direction.previous");
		self.$next.on("click", self.moveToLeft); // slider shifts left to show the next (image to the right of current image)
 		self.$previous.on("click", self.moveToRight);

		self.$slideshowControl = self.$carousel.children(".carousel-slideshow-control");
		self.$slideshowControl.on("click", self.toggleSlideshow);

		self.$carousel.on("mouseenter", self.slideshowControlFadeIn);
		self.$carousel.on("mouseleave", self.delayedSlideshowControlFadeOut);

 		self.imgIndex = 0;
 		self.lastImgIndex = self.$images.length - 1; // -1 because we're using 0 indexing

 		if (self.slideshow) {
 			self.startSlideshow();
 		} else {
 			self.updateNavVisibility(); // need to hide 'previous' upfront
 		}

	}

	self.slideshowControlFadeOut = function() {
		self.$slideshowControl.stop(true).fadeOut(1000);
		// fadeOut argument: how long it should take to do the fading (changing opacity)
		// stop(true) means to stop any ongoing animation to do this immediately
		// i.e. if we call fadeIn while fadeOut is still happening, fadeOut will be stopped to make room for fadeIn
	}

	self.slideshowControlFadeIn = function() {
		window.clearTimeout(self.slideshowControlFadeOutTimer); // i.e. if delayed fade-out is still happening, kill it
		self.$slideshowControl.stop(true).fadeIn(200);
	}

	self.delayedSlideshowControlFadeOut = function() {
		self.slideshowControlFadeOutTimer = setTimeout(self.slideshowControlFadeOut, 200);
	}

	self.toggleSlideshow = function() {
		if (self.slideshow) {
			self.stopSlideshow();
		} else {
			self.startSlideshow();
		}
	}

	self.startSlideshow = function() {
		self.slideshow = true; // just in case, and allows us to call it on any carousel from the console
		self.$slideshowControl.text("PAUSE");
		self.$next.hide();
		self.$previous.hide();
		self.slideshowWaitTimer = setInterval(self.moveToLeft, self.waitTime);
	}

	self.stopSlideshow = function() {
		self.slideshow = false;
		window.clearInterval(self.slideshowWaitTimer);
		self.$slideshowControl.text("PAUSE");
		self.updateNavVisibility();
	}

	// handle 'next' and 'prev' button visibility
	self.updateNavVisibility = function() {
		// 'next' control
		if (self.imgIndex == self.lastImgIndex) {
			if (self.loop) {
				self.$next.show();
			} else {
				self.$next.hide();
			}
		} else {
			self.$next.show();
		}

		// 'previous' control
		if (self.imgIndex == 0) {
			if (self.loop) {
				self.$previous.show();
			} else {
				self.$previous.hide();
			}
		} else {
			self.$previous.show();
		}
	}

	// move the slider left (i.e. subtract from current position) by one image width
	self.moveToLeft = function() {
		if (self.$slider.is(':animated') == false) {
			if (self.imgIndex < self.lastImgIndex) {
				self.animateTransition(-1)
			} else if (self.loop || self.slideshow) { // slideshow should loop, but once stopped, carousel should go back to its loop/no-loop setting
				self.animateTransition(self.lastImgIndex) // if already at the end, big jump to img0
			}
		}
	}

	// slider the slider right (i.e. add to current position) by one image width
	self.moveToRight = function() {
		if (self.$slider.is(':animated') == false) {
			if (self.imgIndex > 0) {
				self.animateTransition(1)
			} else if (self.loop || self.slideshow) { // slideshow should loop, but once stopped, carousel should go back to its loop/no-loop setting
				self.animateTransition(-self.lastImgIndex) // if already at the beginning, big jump to last img
			}
		}
	}

	// call jQuery's animate function
	// with the directions from moveToLeft and moveToRight
	// and the transitionDuration
	self.animateTransition = function(direction) {
		var currLeft = parseInt(self.$slider.css("left"));
		var nextLeft = currLeft + self.imageWidth * direction; // direction is +1 or -1
		self.$slider.animate(
			{left: nextLeft}, // object to animate to (css attributes)
			self.transitionDuration
		); // number of milliseconds for the animation
		self.imgIndex -= direction;
		if (!self.slideshow) self.updateNavVisibility();
	}

	initialize(sel, h, w, options || {}); // 'options || {}' means pass in empty object if there's no options received
	return self;

};
