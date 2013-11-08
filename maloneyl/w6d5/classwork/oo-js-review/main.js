function app(){

  var jack = new Person("Jack", "Lalley", {age: 18});
  var oliver = new Person("Oliver", "Peate", {age: 27});
  var sophie = new Person("Sophie", "Chitty");
  // if we want to debug and get access to jack from the console,
  // change 'var jack' to 'window.jack'

  var classroom = [
    jack,
    oliver,
    sophie
  ];
}

$("document").ready(app) // window.onload
