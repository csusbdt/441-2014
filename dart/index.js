(function() {

  var jan = 0, feb = 1, mar = 3, apr = 4, may = 5, jun = 6;

  schedule = [
    ['dart',            20, new Date('2014-04-09T23:59:59'), '<a href="dart.html">Dart</a>'],
    ['canvas',          20, new Date('2014-04-09T23:59:59'), '<a href="canvas.html">Canvas</a>'],
    ['clip-space',      20, new Date('2014-04-16T23:59:59'), '<a href="clip-space.html">Clip Space</a>'],
    ['textures',        20, new Date('2014-04-30T23:59:59'), '<a href="textures.html">Textures</a>'],
    ['anim-loop',       20, new Date('2014-04-09T23:59:59'), '<a href="anim-loop.html">Animation Loop</a>'],
    ['point-light',     20, new Date('2014-04-30T23:59:59'), '<a href="point-light.html">Point Light</a>'],
    ['ui',              20, new Date('2014-04-09T23:59:59'), '<a href="ui.html">UI</a>']
  ];

  app.onload = function() {
    app.buildTable();
    app.loadScript('scores.js?x=' + Math.random());
  };

  app.buildTable = function() {
    var tbody = document.getElementsByTagName('tbody')[0];
    for (var i = 0; i < schedule.length; ++i) {
      var tr = document.createElement('tr');
      var td = document.createElement('td'); // activity column
      td.innerHTML = schedule[i][3];
      td.className = 'activity';
      tr.appendChild(td);
      td = document.createElement('td'); // deadline column
      td.innerHTML = app.extractDate(schedule[i][2]);
      td.className = 'deadline';
      tr.appendChild(td);
      td = document.createElement('td'); // points column
      td.innerHTML = schedule[i][1];
      td.className = 'points';
      tr.appendChild(td);
      td = document.createElement('td'); // score column
      td.innerHTML = '';
      td.className = 'score';
      tr.appendChild(td);
      tbody.appendChild(tr);
    }
  };

  app.setStudentId = function(id) {
    localStorage.setItem('studentId', id);
    document.getElementById('score-column').innerHTML = id;
    // Insert scores in table.
    var rows = document.getElementsByTagName('tbody')[0].children;
    for (var i = 0; i < rows.length; ++i) {
      if (app.scores[id][i] !== null) {
        rows[i].lastChild.innerHTML = app.scores[id][i];
      } else {
        rows[i].lastChild.innerHTML = '';
      }
    }
  }

  app.onloadScores = function() {
    app.computeAverage();
    var id = localStorage.getItem('studentId');
    if (id === null) id = 'Avg';
    app.setStudentId(id);
  };

  app.computeAverage = function() {
    var students = Object.keys(app.scores);
    var avgs = [];
    for (var j = 0; j < app.scores[students[0]].length; ++j) {
      var total = 0;
      var n = 0;
      for (var i = 0; i < students.length; ++i) {
        var id = students[i];
        var score = app.scores[id][j];
        if (score !== null) {
          total += score;
          ++n;
        }
      }
      if (n > 0) avgs.push(Math.round(total/n));
      else avgs.push(null);
    }  
    app.scores.Avg = avgs;
  };

})();

