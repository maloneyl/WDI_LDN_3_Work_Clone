variable_storing_value_of_confirm = confirm("sure?");
// response: "ok" = true, "cancel" = "false"

variable_storing_value_of_prompt = prompt("what's yo name?");

alert("Hi " + variable_storing_value_of_prompt + ", you said " + variable_storing_value_of_confirm);
// alert: in the window object
// there's no string interpolation in javascript


// conditionals
if(variable_storing_value_of_prompt < 10){
  alert("you kid")
}
else if(variable_storing_value_of_prompt < 18){
  alert("teenager")
}
else{
  alert("rude boy")
}

switch(variable_storing_value_of_prompt){
  case 17:
    alert("something");
    break;
  case 35:
    alert("ok");
    break;
}

switch(true){
  case (variable_storing_value_of_prompt > 17):
    alert("something");
    break;
  case (variable_storing_value_of_prompt > 35):
    alert("ok");
    break;
}

// simple 'while'
var count = 0;
while(count < 10){
  console.log(count);
  count++;
}

// 'do...while'
// this will execute at least once AND THEN evaluate that the condition to see if it should do it again
var count = 0;
do{
  console.log(count + "logging");
  count++;
}while(count < 0)


// for loops
my_array = ["apple", "banana", "orange", "mango"]
for(i = 0; i < my_array.length; i++){
  console.log("fruit is ->" + my_array[i], i)
}

// this exists but not very usable
for(value in my_array){
  console.log("2 - fruit is ->" + value)
}

for(i = 0; i < 5; i++){
  console.log(i)
}




// // no semi-colons required after curly braces for conditional statements
// if(variable_storing_value_of_confirm == true){
//   alert("nice!")
// }
// else{
//   alert("gtfo!")
// }

// a_key = "a_value";
// var another_key = "another_value";

// // primitive types:
// a_variable_with_a_number = 2000;
// a_variable_with_a_string = "a string";
// a_variable_with_a_boolean = false;


// window.onload = function() {
//   console.log(document.getElementById("container"))
// }
// console.log(document.getElementById("container"))
