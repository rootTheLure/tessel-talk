class Speech
    constructor: ->
        @log = new Log 'pre.log'
        @recognition = new webkitSpeechRecognition
        @recognition.continuous = yes
        @recognition.interimResults = no
        @recognition.onresult = (event) =>
            length = event.results.length
            word = event.results[length-1][0].transcript
            @log.write "#{word}\r\n"
            @wordHandler do word.replace(/\s/g, '').toUpperCase
        do @recognition.start

    onword: (@wordHandler) ->
