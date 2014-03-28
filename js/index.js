(function() {

  var jan = 0, feb = 1, mar = 3, apr = 4, may = 5, jun = 6;

  schedule = [
    ['git',             20, new Date('2014-04-06T23:59:59'), '<a href="git.html">Git</a>'],
    ['lua',             20, new Date('2014-04-13T23:59:59'), '<a href="lua.html">Lua</a>'],
    ['sdl',             20, new Date('2014-04-20T23:59:59'), '<a href="sdl.html">SDL</a>'],
    ['embed',           20, new Date('2014-04-27T23:59:59'), '<a href="embed.html">Embed</a>'],
    ['bp',              20, new Date('2014-05-04T23:59:59'), '<a href="bp.html">Boilerplate</a>'],
    ['tba3',            20, new Date('2014-05-11T23:59:59'), '<a href="">TBA</a>'],
    ['tba4',            20, new Date('2014-05-18T23:59:59'), '<a href="">TBA</a>'],
    ['tba5',            20, new Date('2014-05-25T23:59:59'), '<a href="">TBA</a>'],
    ['tba6',            20, new Date('2014-06-01T23:59:59'), '<a href="">TBA</a>'],
    ['final',           20, new Date('2014-06-10T23:59:59'), '<a href="">Final</a>'],
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

