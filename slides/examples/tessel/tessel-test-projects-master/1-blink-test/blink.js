// Import the interface to Tessel hardware
var tessel = require('tessel');

// Set the led pins as outputs with initial states
// Truthy initial state sets the pin high
// Falsy sets it low.
//var led1 = tessel.led[0].output(1);

setTimeout(function() {tessel.led[0].output(1);}, 1000);
setTimeout(function() {tessel.led[1].output(1);}, 3000);
setTimeout(function() {tessel.led[0].output(0);}, 5000);
setTimeout(function() {tessel.led[1].output(0);}, 7000);

// setInterval(function () {
//     console.log("I'm blinking! (Press CTRL + C to stop)");
//     // Toggle the led states
//     //led1.toggle();
//     led1.toggle();
//     led2.toggle();
//     led3.toggle();
//     led4.toggle();
// }, 100);