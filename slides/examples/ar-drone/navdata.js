var util = require('util');
var arDrone = require('ar-drone');
var client  = arDrone.createClient();

client.config('detect:detect_type', '10');
client.on('navdata', function (navdata) {
	console.log('\n\n', util.inspect(navdata, false, null));
});