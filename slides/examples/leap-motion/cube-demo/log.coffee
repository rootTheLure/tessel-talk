class Log
    constructor: (selector) ->
        @element = document.querySelector selector

    write: (message) ->
        if @element
            @element.textContent += "#{message}\n"
            @element.scrollTop = @element.scrollHeight