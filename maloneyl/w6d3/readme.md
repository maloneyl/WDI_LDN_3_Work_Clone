QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================

* It took me a long time before I realized that "self.loopOption = options.loopOption || true;" didn't work because "||" cannot be used to set boolean values as anything falsey. I also made the mistake of not checking in the console whether my carouselB's loopOption was set to false as I'd wanted it to, so I spent a long, long time mistakenly thinking that my no-looping version of the code was all wrong… 

* The logic took a bit of work to figure out, and it took some testing in the browser before I figured out when to hide and show the 'next' and 'previous' buttons.

* And for some reason it also didn't occur to me until really late that I could simply use 'show' and 'hide' methods for the 'next' and 'previous' buttons. I think because we added those buttons there by 'append'-ing those classes, I misled myself into thinking that 'this means we should un-append or remove the relevant class in a similar fashion…' 

* Haven't got the time to dive into the extra timed-slideshow feature…

CLASS NOTES
============

* All within classwork programs