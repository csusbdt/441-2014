(function() {

  function attachShowButton(elem) {
    var button = document.createElement('button');
    button.innerHTML = 'Show answer';
    button.className = 'answer-btn';
    elem.parentNode.insertBefore(button, elem.nextSibling);
    button.onclick = function() {
      if (elem.style.display === 'block') {
        elem.style.display = 'none';
        button.innerHTML = 'Show answer';
      } else {
        elem.style.display = 'block';
        button.innerHTML = 'Hide answer';
      }
    };
  }

  var answers = document.getElementsByTagName('pre');
  for (var i = 0; i < answers.length; ++i) {
    var answer = answers[i];
    if ((' ' + answer.className + ' ').indexOf('answer') > -1) {
      attachShowButton(answer);
    }
  }
})();

