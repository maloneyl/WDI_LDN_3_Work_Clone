// CONSTRUCTOR FUNCTION
// basically just creates a new empty object: this = {};
// then adds key-and-value pairs based on what's given: this.x = something, this.y = somethingElse
// then returns the completed this
// BUT before we even start, we should
// - lock the value of this by assigning it to self (or _this)
// - make sure it's 'var self = this' instead of 'self = this'...

function Person(firstName, lastName, options){

  var self = this; // MUST-do

  // reminder: this is really just a manually-created function
  // we just write here what a initialize method typically does
  // that's why we must call this function, pass what it needs
  function initialize(firstName, lastName, options){
    self.firstName = firstName;
    self.lastName = lastName;

    defaultOptions = {
      age: 25,
      os: "Mac"
    }
    _.extend(self, defaultOptions, options);
    // jQuery's equivalent: $.extend(self, defaultOptions, options);
  }

  self.sayMyName = function(){
    alert(self.firstName + " " + self.lastName + "!");
  }

  initialize(firstName, lastName, options || {});
  return self;

}
