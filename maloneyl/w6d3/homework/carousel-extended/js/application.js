function setupCarousel() {

  // when you call a function with 'new', you're using the function as a class and creating an instance of that class
  window.carouselA = new Carousel('#carousel-A', 612, 612, {loopOption: true});
  window.carouselB = new Carousel('#carousel-B', 500, 500, {
    transitionDuration: 800,
    loopOption: false
  }); // {} is a js object
}

$('document').ready(setupCarousel);
