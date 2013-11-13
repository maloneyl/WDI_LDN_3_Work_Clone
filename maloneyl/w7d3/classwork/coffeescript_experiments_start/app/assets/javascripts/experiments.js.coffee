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

  # #######################################################
  # drawHeader "you owe Jeremy Ashkenas a beer"

  # jeremyAshkenas = """
  #   ###################################################################
  #   ################################+##################################
  #   ###########################,    .     ``+##########################
  #   #################''####;    `  `;,,.`    ``.#######################
  #   #################+'##    `'#+;##;##''#+#,...  ;##########+'########
  #   ###################    +#####++;+'+;#####;;#.   '#;######''########
  #   #################   ,#########;'#';###########;  `##########'######
  #   #########'#####+  `######;;:''++##+''::++#######;  `###############
  #   ##############`  +############;++;'+########;+####`  ##############
  #   ####;########`  #############+;#'#':############+++' `;############
  #   ####;####### `:#############:+##;###,####;;########+'  '###########
  #   ##'######## `,####'########;####;####+'##++#####;##++;` '##'####;##
  #   #########,` ',##;:##############;################+'++''  ;+########
  #   ######### ,:+:+,+###############:##################;''''; #########
  #   ########. ,::+#:################+''''''+'+#########'';;';  ########
  #   #####+#.,,,####+,,,,.##########++++''''+++++##,+,;;:++#+:;,,#:#####
  #   #######  ##,;+;:##############+++'+'+++''++#+######';;;;'#` #######
  #   ######. '#,;:;::;###########+#'+'+'''+''+####+#####;';';;##  ######
  #   ######  +;###,##:+#########+++++++'':'+#++++##+##+;##'+##;#; :#####
  #   #####` #####+,#############++++###'::,::'++#++++#####''#####  #####
  #   ##### `++###+.####+########++####';:,,,,:,,,::'#+####''####+' ;####
  #   ###'. #######:###################';:::::,.,,,::######++######  #;##
  #   ####` ####################+#####+';;::::,``,,,:'#############, ####
  #   ###.``+###################+#####++;;;;::,.`.,,:;#############+,`###
  #   ###.`+###############::###+######+';::::,.`.,::;##############, ###
  #   ###  #################,#########++';;';:,...,,,;##############, ###
  #   ### .###;###########+;:###,,####''''''#+':,,,,:;##########'#### ;##
  #   ### '###'###########+,,##+##'##+''+'++##+;:::'+'##########+#### `##
  #   ##:`####,####''#####++:##'''###';;:;'''##+::##+;####+.####;####  ##
  #   ##  `+##,###,#######+',##+:###'':::,:;:,;',;:++'######.+##;###;` ##
  #   ##  #;,#,#;,+########;,#+#,++##+;;::,..,:;:,;:;########+;#;#;'+. ##
  #   ##  #+;;;,;;#########;,+##+:##+#+'::,.`,:::,,::########+''+;'+#, ##
  #   #+``;;;;#+;;;;;++####;,'+##'##+##';::,.,;;:,,,:####++++'''##''+;.#'
  #   ##  ##,;+;,########+#;,.;'#..'+##+';:::;:':.,,:#########;;++;##; ##
  #   ##  #;+,+,+;#+#######':,#''.,;#+++';:::+##':,,;########++;+,#;#: ##
  #   ##  #,+#,#+;'###+####',++#..,+##+'';;;:;:#+:::+########;+#;#+'', ##
  #   ##  ;###,+##;###++###;'#''..;+##+'':;'';:,;::'########'###;###+` ##
  #   ##``####,+#+#++######'##:..,'+###''::###++;;:########,####;####  ##
  #   ##; ####+#+###+#+######',,,:;####+'::;::+##;;########++###+####  ##
  #   ### '#+#######+#+#+###',..,';####+':::':,:::##############+#### `##
  #   ### `+##+##+#######+##;,..,:+#####+;::,::::;##########+#'#+###+ +##
  #   ###  #+##+##+######+##:,..,:+####+#';:,.,,:+###+##########'+##, ###
  #   ###, +######+#++;##+##:,..,.''####+++';,::;###+#############+'..###
  #   ###'`,##+#####+#+#####:,,....''#####++';;;############++;##### .###
  #   ####` +##++#+,##+#+##+::,:,,.,;'##+######;#########+#'+######. ####
  #   ####, ++###++,++##'##+;::.,..`::#+######+;###########++####+#  ####
  #   ##'##  ++++++;+++,;###';`.....,,,++######';#####;####++####'; +####
  #   #####, ++,#+,,`.,,'+#+'.`.`..,##;;+#+#'#;#+#++###+:##++##:+#  #####
  #   ######` +#:,,,,,.+;'';:,````,##;';;+#:;;;#+``+#####:+''':+#. +#####
  #   ######; ,,.,,.,,:+;;:,,````.#+++++,,.,;'#;#,.````,'''::''##  ######
  #   #####++,:,,,.``,:::,,,`.`.,.,'#++''....;+##+```.::,,;+#+:::,#:#####
  #   ########  ,,,..:+;;:,,`..,,,...+#++;'..;,,#;``.....`,:''+. ,#######
  #   ########; :+:,,;';;,,,..,,+..,..;+++'..;..,#'```...,.,:':  ########
  #   #########.`.#,;+;;:,,,..,,+;..,..,##;`.;..,#+.``..,`.`.` ,#########
  #   ##########  `:'+';:,,....,.#......,';..,.,,,.,.`....```  ##########
  #   ###########  ,++';:,,..,....;,..,..,'`.,.,..',.,,.....` ###########
  #   ############```';;:,,,......,...,...;.......+..,....`  ############
  #   #############` `;:,,:.......+,..:..,+.......#..:...   #############
  #   ##############;  .,,;.......,+.,.,.`+.......+.,,.`  `##############
  #   ################   ,,;.......+,,..,,;`......:;,.   ;########+######
  #   #######;;########, ` ',.......:,.,:',......`.#`   ########:,,;#####
  #   ##################;``  .......':`,';'..`....    ##''#######++######
  #   ##########;########;#,    `..,,,:.:;+.```    `####;################
  #   ########################`   `   `   `     `,``#####################
  #   ###########################,,`  ,    `.'###########################
  #   ###################################################################
  #   ################################,##################################
  # """

  # log jeremyAshkenas



