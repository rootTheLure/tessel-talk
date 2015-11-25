dgram = require 'dgram'
socket = dgram.createSocket 'udp4'
seq = 0

flying = false
emergency = false

setInterval ->
	ref = (flying << 9) | (emergency << 8)

	commands = [
		"AT*REF=#{seq++},#{ref}"
		"AT*PCMD=#{seq++},0,0,0,0,0"
	].join('\r') + '\r'

	console.log JSON.stringify commands

	buffer = new Buffer commands

	socket.send buffer, 0, buffer.length, 5556, '192.168.1.1'
, 30


setTimeout ->
	emergency = false
, 1000

setTimeout ->
	flying = true
, 2000

setTimeout ->
	flying = false
, 6000