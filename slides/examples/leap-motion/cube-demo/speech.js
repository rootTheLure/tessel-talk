// Generated by CoffeeScript 1.6.3
var Speech;

Speech = (function() {
  function Speech() {
    var _this = this;
    this.log = new Log('pre.log');
    this.recognition = new webkitSpeechRecognition;
    this.recognition.continuous = true;
    this.recognition.interimResults = false;
    this.recognition.onresult = function(event) {
      var length, word;
      length = event.results.length;
      word = event.results[length - 1][0].transcript;
      _this.log.write("" + word + "\r\n");
      return _this.wordHandler(word.replace(/\s/g, '').toUpperCase());
    };
    this.recognition.start();
  }

  Speech.prototype.onword = function(wordHandler) {
    this.wordHandler = wordHandler;
  };

  return Speech;

})();