# Our first play with CoffeeScript... EXCITING!

# NOTE: these comments use '#' rather than JS-style //

###
We can do block comments too with 3 hash characters
###

###
let's create a drawHeader functin to make our console output pretty...
here's the old JS code...
  function drawHeader(name) {
    console.info("\n************** " + name + " **************\n")
  }
###

drawHeader = (name) ->
  console.info "\n************** #{name} **************\n"
###
  * concise function notation with ->
  * lack of parentheses on call to console.info
  * ruby-style string interpolation
###

# create a super concise log func while we're at it
###
log = (msgs...) -> # splat: (msgs...) means get all args into an array, then pass as indiv arg
  console.log msgs... # this basically does msgs[0], msgs[1], etc.
###
# or we must have at least one thing to be passed:
log = (first, others...) ->
  console.log first, others...

###
Use jQuery's doc ready method:
* plain JS form is:
    $(function(){
      // code here
    })
* coffeescript equivalent is:
    $ ->
      # code here
  reminder: indenting is important in coffeescript!
###

# doc ready from here on
$ ->

  ##############################
  drawHeader "variables"

  # basic assignment
  x = 99
  window.y = 100 # equivalent: window["y"] = 100 because window is an object (hash)

  # variable safety
  y += 1

  log "Try looking for x in the Chrome console... Won't find it."
  log "Now look for y. Note: It's been incremented by 1"

  # 'this' keyword
  this.foo = "bar"
  @whizz = "bang"

  log "@foo and @whizz are #{@foo} and #{@whizz}." # we can access this.foo with @foo

  ##############################
  drawHeader "numbers"

  log "There is nothing special about numbers."

  myInt = 42
  myFloat = 99.99

  ##############################
  drawHeader "strings"

  # simple
  myString = "Hello, foo with double quotes."
  myOtherString = 'Hello, bar with single quotes.'

  # interpolation
  # like ruby, need double quotes to work
  name = "Jon"
  log 'Hello, #{name} with single quotes.'
  log "Hello, #{name} with double quotes."

  multiLineString = "I started writing this on one line
  but finished on another!" # but there will be an extra space: "one line  but"
  log multiLineString

  anotherMultiLineString = "I started writing this on one line
 but finished on another!" # super weird-looking code but now there's no extra space: "one line but"
  log anotherMultiLineString

  blockStr1 = """
              \nThis is a double-quoted block string,
              according to #{name}, double quotes

               - preserve whitespace
               - do string interpolation

              """

  blockStr2 = '''
              \nThis is a single-quoted block string,
              according to #{name}, single quotes

               - preserve whitespace
               - BUT DO NOT DO string interpolation

              '''

  log blockStr1
  log blockStr2

  ##############################
  drawHeader "arrays"

  log "Pretty standard array stuff."

  # literal syntax
  arr = [1, 2, 3, 4, 5, 6]
  log "arr is #{arr}."

  # slicing
  log "arr[0..4] is #{arr[0..4]}." # 1,2,3,4,5
  log "arr[0..4] is #{arr[0...4]}." # 1,2,3,4

  # splicing
  arr[2..3] = ["foo", "bar"]
  log "arr is now #{arr}." # 1,2,foo,bar,5,6


  ##############################
  drawHeader "objects"

  # all 3 syntaxes below are the same
  obj1 = {a: 1, b: 2}
  obj2 = a: 1, b: 2 # still works
  obj3 = # coffeescript will deduce from the hanging = that what follows is related
    a: 1 # doesn't even need a comma
    b: 2
  log "obj1 is", obj1
  log "obj2 is", obj2
  log "obj3 is", obj3


  ##############################
  drawHeader "functions"

  # implicit return like in ruby
  sum = (num1, num2) ->
    num1 + num2

  log "sum(2,2) returns #{sum(2,2)}"

  # more splat examples
  args = ["foo", "bar", "baz"]

  splatDemo = (firstArg, otherArgs...) ->
    log firstArg # returns ["foo", "bar", "baz"]
    log otherArgs # returns []; "otherArgs..." sans dots would've made this 'undefined'
  splatDemo args

  splatDemo2 = (firstArg, otherArgs...) ->
    log firstArg # returns foo
    log otherArgs # returns ["bar", "baz"]
  splatDemo2 args... # the dots here means to treat that array not as a whole but as each of its items

  # fat arrow
  @page = "experiments"

  # js version:
  #   $("body").on("dblclick", function(){})

  $("body").on "dblclick", =>
    alert "Welcome from the #{@page} page. This message is brought to you by the fat arrow (=>), who has 'this' as #{this}." # returns @page as the right page and 'this' as [objectHTMLDocument]

  $("body").on "dblclick", ->
    alert "@page (also this.page) is #{@page}. This message is brought to you by the thin arrow (->), who has 'this' as #{this}." # returns @page as undefined and 'this' as [objectHTMLBodyElement]

  compiledCode = '''
    var _this = this;

    $("body").on("dblclick", function() {
      return alert("Welcome from the " + _this.page + " page. This message is brought to you by the fat arrow (=>).");
    });
    return $("body").on("dblclick", function() {
      return alert("@page (also this.page) is " + this.page + ". This message is brought to you by the thin arrow (->).");
    });
  '''
  # IMPORTANT!!!
  # fat version: _this is frozen in the current page ([objectHTMLDocument])
  # thin version: this is set dynamically, which in this case will be the body element ([objectHTMLBodyElement])
  # SO USE FAT ARROWS!

  log "fat- and thin-arrow compiled JS is: ", compiledCode


  ##############################
  drawHeader "operators and aliases"

  # forget about == and ===
  # == will still get automagically converted to === anyway
  log "true is true: #{true is true}" # equivalent to true === true
  log "true isnt true: #{true isnt true}" # yes, not isn't
  log "not true: #{not true}"

  # existential operator (similar to .nil? in ruby)
  arr = [true, 100, 0, false, "", NaN, null, undefined] # only 'true' and 100 are true

  # double-not trick is what we use to find out whether something is true-y or false-y:
  # e.g. !true returns false, so !!true will return true
  isTrue = _(arr).map (element) -> !!element # underscore syntax: _.map(list, iterator, [context]); coffeescript methods can be in 1 line
  log isTrue
  isNil = _(arr).map (element) -> element? # ? is the existential operator; only null and undefined would return false
  log isNil

  someVal = 0
  unless someVal
    log "I'm printing this because 0 is falsy in JS"
  if someVal?
    log "I'm printing this because 0 is a value - duh!"

  # existential also gives us something like ruby's ||=
  # assign if missing:
  someVal ?= 100
  log "After running 'someVal ?= 100', someVal is #{someVal} because someVal was already defined earlier." # will still be 0

  newVal = undefined # can't skip this because newVal is not an object (objects can be asked things that don't exist)
  newVal ?= 100
  log "After running 'newVal ?= 100', newVal is #{newVal} because newVal was previously undefined."

  obj = {}
  obj.newVal ?= 100 # objects can be asked things that don't exist
  log obj


  ##############################
  drawHeader "conditionals"

  if true
    log "we have if"
  else
    log "this will never be printed"

  unless false
    log "we have unless"

  log "we have inline if" if true

  log "we have inline unless" unless false

  # there's no ternary but you can still put things in one line
  if true then log("it was true") else log("this will never been run")

  # and == &&, or == ||
  if true and true
    log("True and true is true, and never a truer word was said.")

  # switch statement
  # we say 'when' like in ruby instead of 'case' in pure js
  # and we don't need to 'break' after every clause anymore
  # can use in-line then or indented block
  # can have multiple values per 'when'
  day = "Wed"
  tooMuchCoffeeDuringWeek = true
  hoursSleep = switch day
    when "Mon" then 4 # 'when', not 'case'; use 'then' if all on one line -- both very ruby
    when "Tue" then 3
    when "Wed" then 2
    when "Thu" then 1
    when "Fri", "Sat" # can have multiple values per 'when'; no 'then' if multi-line
      if tooMuchCoffeeDuringWeek # can nest more if/else
        5
      else
        7
    when "Sun" then 0
    else "#{day} is not a recognized day." # 'else' as final catch-all
  log "Jon has #{hoursSleep} hours of sleep. This is a cry for help."


  ##############################
  drawHeader "loops"
  # comprehensions (borrowed from python)

  instructors = ["Jon", "Julien", "Gerry", "David"]
  sortedInstructors = _(instructors).sortBy (element) -> element
  log sortedInstructors

  log "My alphabetically-sorted instructors are:"
  log(instructor) for instructor in sortedInstructors
  ###
  same as:
    for instructor in sortedInstructors
      log(instructor)
  ###

  log "My alphabetically-sorted instructors and their indices in sortedInstructors are:"
  log "#{i} #{instructor}" for instructor, i in sortedInstructors

  log "We can print key-and-value pairs too:"
  log "#{key} => #{val}" for key, val of {a: 1, b: 2, c: 3} # 'of', not 'in'

  # while
  counter = 10
  while counter < 15
    log counter += 1
  # returns: 11, ..., 15

  log counter += 1 while counter < 11 # inline while

  log counter -= 1 until counter < 1 # inline until


  ##############################
  drawHeader "classes and inheritance"

  class Person

    # syntax is object/hash-like
    # must use THIN ARROW for the constructor (FAT for other methods)
    constructor: (@firstName, @lastName, @gender, @title, options={}) -> # this already does this.firstName = @firstName, etc.
      @title ?= switch @gender
        when "male" then "Mr"
        when "female" then "Ms"
        else null
      log "Constructing #{@name()}" if options.verbose # @name() - the parentheses suggest it's a method...that we'll write below!

    # fat arrows for methods because we want to be sure that our @ vars are frozen appropriately, referring to what we set up in the constructor
    name: =>
      if @title
        "#{@title} #{@firstName} #{@lastName}"
      else
        "#{@firstName} #{@lastName}"

    describe: =>
      log "#{@name()} is a Person" # must have () when no args because otherwise there's no way for coffeescript (or us) to know it's a function...

    getsEnoughSleep: =>
      "probably"

  window.alice = new Person "Alice", "Foo", "female" # window.alice just so we can play with this var in the console
  log alice
  alice.describe()

  class Developer extends Person # i.e. extends means inherits from

    getsEnoughSleep: =>
      "no"

    describe: =>
      super # like in ruby, call parent version of the same method
      log "#{@name()} is also a Developer"

  gerry = new Developer "Gerry", "Mathe", "male"
  jon = new Developer("Jon", "Chambers", "male", "Dr", verbose: true, foo: 99) # parentheses still not required but won't throw an error; extra keys won't throw an error, just won't be used
  log gerry, jon

  gerry.describe()
  jon.describe()
  log "jon.getsEnoughSleep?: #{jon.getsEnoughSleep()}"


  #######################################################
  drawHeader "you owe Jeremy Ashkenas a beer"

  jeremyAshkenas = """
    ###################################################################
    ################################+##################################
    ###########################,    .     ``+##########################
    #################''####;    `  `;,,.`    ``.#######################
    #################+'##    `'#+;##;##''#+#,...  ;##########+'########
    ###################    +#####++;+'+;#####;;#.   '#;######''########
    #################   ,#########;'#';###########;  `##########'######
    #########'#####+  `######;;:''++##+''::++#######;  `###############
    ##############`  +############;++;'+########;+####`  ##############
    ####;########`  #############+;#'#':############+++' `;############
    ####;####### `:#############:+##;###,####;;########+'  '###########
    ##'######## `,####'########;####;####+'##++#####;##++;` '##'####;##
    #########,` ',##;:##############;################+'++''  ;+########
    ######### ,:+:+,+###############:##################;''''; #########
    ########. ,::+#:################+''''''+'+#########'';;';  ########
    #####+#.,,,####+,,,,.##########++++''''+++++##,+,;;:++#+:;,,#:#####
    #######  ##,;+;:##############+++'+'+++''++#+######';;;;'#` #######
    ######. '#,;:;::;###########+#'+'+'''+''+####+#####;';';;##  ######
    ######  +;###,##:+#########+++++++'':'+#++++##+##+;##'+##;#; :#####
    #####` #####+,#############++++###'::,::'++#++++#####''#####  #####
    ##### `++###+.####+########++####';:,,,,:,,,::'#+####''####+' ;####
    ###'. #######:###################';:::::,.,,,::######++######  #;##
    ####` ####################+#####+';;::::,``,,,:'#############, ####
    ###.``+###################+#####++;;;;::,.`.,,:;#############+,`###
    ###.`+###############::###+######+';::::,.`.,::;##############, ###
    ###  #################,#########++';;';:,...,,,;##############, ###
    ### .###;###########+;:###,,####''''''#+':,,,,:;##########'#### ;##
    ### '###'###########+,,##+##'##+''+'++##+;:::'+'##########+#### `##
    ##:`####,####''#####++:##'''###';;:;'''##+::##+;####+.####;####  ##
    ##  `+##,###,#######+',##+:###'':::,:;:,;',;:++'######.+##;###;` ##
    ##  #;,#,#;,+########;,#+#,++##+;;::,..,:;:,;:;########+;#;#;'+. ##
    ##  #+;;;,;;#########;,+##+:##+#+'::,.`,:::,,::########+''+;'+#, ##
    #+``;;;;#+;;;;;++####;,'+##'##+##';::,.,;;:,,,:####++++'''##''+;.#'
    ##  ##,;+;,########+#;,.;'#..'+##+';:::;:':.,,:#########;;++;##; ##
    ##  #;+,+,+;#+#######':,#''.,;#+++';:::+##':,,;########++;+,#;#: ##
    ##  #,+#,#+;'###+####',++#..,+##+'';;;:;:#+:::+########;+#;#+'', ##
    ##  ;###,+##;###++###;'#''..;+##+'':;'';:,;::'########'###;###+` ##
    ##``####,+#+#++######'##:..,'+###''::###++;;:########,####;####  ##
    ##; ####+#+###+#+######',,,:;####+'::;::+##;;########++###+####  ##
    ### '#+#######+#+#+###',..,';####+':::':,:::##############+#### `##
    ### `+##+##+#######+##;,..,:+#####+;::,::::;##########+#'#+###+ +##
    ###  #+##+##+######+##:,..,:+####+#';:,.,,:+###+##########'+##, ###
    ###, +######+#++;##+##:,..,.''####+++';,::;###+#############+'..###
    ###'`,##+#####+#+#####:,,....''#####++';;;############++;##### .###
    ####` +##++#+,##+#+##+::,:,,.,;'##+######;#########+#'+######. ####
    ####, ++###++,++##'##+;::.,..`::#+######+;###########++####+#  ####
    ##'##  ++++++;+++,;###';`.....,,,++######';#####;####++####'; +####
    #####, ++,#+,,`.,,'+#+'.`.`..,##;;+#+#'#;#+#++###+:##++##:+#  #####
    ######` +#:,,,,,.+;'';:,````,##;';;+#:;;;#+``+#####:+''':+#. +#####
    ######; ,,.,,.,,:+;;:,,````.#+++++,,.,;'#;#,.````,'''::''##  ######
    #####++,:,,,.``,:::,,,`.`.,.,'#++''....;+##+```.::,,;+#+:::,#:#####
    ########  ,,,..:+;;:,,`..,,,...+#++;'..;,,#;``.....`,:''+. ,#######
    ########; :+:,,;';;,,,..,,+..,..;+++'..;..,#'```...,.,:':  ########
    #########.`.#,;+;;:,,,..,,+;..,..,##;`.;..,#+.``..,`.`.` ,#########
    ##########  `:'+';:,,....,.#......,';..,.,,,.,.`....```  ##########
    ###########  ,++';:,,..,....;,..,..,'`.,.,..',.,,.....` ###########
    ############```';;:,,,......,...,...;.......+..,....`  ############
    #############` `;:,,:.......+,..:..,+.......#..:...   #############
    ##############;  .,,;.......,+.,.,.`+.......+.,,.`  `##############
    ################   ,,;.......+,,..,,;`......:;,.   ;########+######
    #######;;########, ` ',.......:,.,:',......`.#`   ########:,,;#####
    ##################;``  .......':`,';'..`....    ##''#######++######
    ##########;########;#,    `..,,,:.:;+.```    `####;################
    ########################`   `   `   `     `,``#####################
    ###########################,,`  ,    `.'###########################
    ###################################################################
    ################################,##################################
  """

  log jeremyAshkenas
