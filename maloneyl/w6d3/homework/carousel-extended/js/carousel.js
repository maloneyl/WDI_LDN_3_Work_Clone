// a class that represents an image carousel
// it encapsulates all data and functions needed

function Carousel(sel, h, w, options) { // upper camel case because we're treating it as a class and put in what it takes here already

	// freeze value of "this" so it is unambiguous in our functions
	// this is a common trick
	var self = this; // the object we're currently in and will add properties to with the functions below

	// initialize an instance of Carousel
	// NOTE: we must call this ourselves (see bottom); this is not ruby
	function initialize(sel, h, w, options) { // passing in: selector, height, width, options like transitionDuration
		self.sel = sel; // or the equvialent: self[sel] = sel;
		self.imageHeight = h;
		self.imageWidth = w;

		self.transitionDuration = options.transitionDuration || 200; // '|| 200' means use 200 as default if none passed

		self.loopOption = options.loopOption;
		if(typeof(self.loopOption)==='undefined') self.loopOption = true;
		// apparently "||" doesn't work if you want to pass a false value
		// so this doesn't work:
		// self.loopOption = options.loopOption || true;

		self.$carousel = $(self.sel); // $carousel to remind ourselves this is a jQuery object
		self.$carousel
			.addClass("carousel")
			.height(self.imageHeight) // method equivalent to .css('height', imageHeight)
			.width(self.imageWidth)
			.append('<a class="carousel-direction previous"><</a><a class="carousel-direction next">></a>');

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

 		self.imgIndex = 0;
 		self.lastImgIndex = self.$images.length - 1; // -1 because we're using 0 indexing

	}

	// move the slider left (i.e. subtract from current position) by one image width
	// until current image is already at the maximum image index IF looping is false (hide right arrow at the end)
	// otherwise if looping is true, go back to 0 to start again
	self.moveToLeft = function() {
		if (self.imgIndex < self.lastImgIndex) {
			self.animateTransition(-1);
		}
		else {
			switch(self.loopOption) {
				case false:
					self.animateTransition(0);
					$(".carousel-direction previous").remove();
					break;
				case true:
					self.animateTransition(self.lastImgIndex);
					break;
			}
		}
	}

	// slider the slider right (i.e. add to current position) by one image width
	// only if current image index is greater than 0 IF looping is false (hide left arrow at the end)
	// otherwise if looping is true, go back to lastImgIndex to start again
	self.moveToRight = function() {
		if (self.imgIndex > 0) {
			self.animateTransition(1);
		}
		else {
			switch(self.loopOption) {
				case false:
					self.animateTransition(0);
					break;
				case true:
					self.animateTransition(-self.lastImgIndex);
					break;
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
			{left: nextLeft},
			self.transitionDuration
		);
		self.imgIndex -= direction;
	}

	initialize(sel, h, w, options || {}); // 'options || {}' means pass in empty object if there's no options received
	return self;

};
