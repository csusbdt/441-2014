(function() {
  window.app = { onload: function() {} };
  if (window.onload) {
    var originalOnload = window.onload;
    window.onload = function() {
      originalOnload();
      app.onload();
    };
  } else {
    window.onload = function() {
      app.onload();
    }
  }
})();

app.getUrlRequestParams = function() {
  var qs = document.location.search.split("+").join(" ");
  var params = {};
  var tokens;
  var re = /[?&]?([^=]+)=([^&]*)/g;
  while (tokens = re.exec(qs)) {
    params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);
  }
  return params;
}

app.loadScript = function(url) {
  var s = document.getElementsByTagName('script')[0];
  var ss = document.createElement('script');
  ss.type = 'text/javascript';
  ss.async = true;
  ss.src = url;
  s.parentNode.insertBefore(ss,s);
};

app.extractDate = function(date) {
  var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return months[date.getMonth()] + ' ' + date.getDate();
};

///////////////////////////////////////////////////////////////////////////////////////////////////
//
// polyfills
//
///////////////////////////////////////////////////////////////////////////////////////////////////

// From https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys
if (!Object.keys) {
  Object.keys = (function () {
    'use strict';
    var hasOwnProperty = Object.prototype.hasOwnProperty,
        hasDontEnumBug = !({toString: null}).propertyIsEnumerable('toString'),
        dontEnums = [
          'toString',
          'toLocaleString',
          'valueOf',
          'hasOwnProperty',
          'isPrototypeOf',
          'propertyIsEnumerable',
          'constructor'
        ],
        dontEnumsLength = dontEnums.length;

    return function (obj) {
      if (typeof obj !== 'object' && (typeof obj !== 'function' || obj === null)) {
        throw new TypeError('Object.keys called on non-object');
      }

      var result = [], prop, i;

      for (prop in obj) {
        if (hasOwnProperty.call(obj, prop)) {
          result.push(prop);
        }
      }

      if (hasDontEnumBug) {
        for (i = 0; i < dontEnumsLength; i++) {
          if (hasOwnProperty.call(obj, dontEnums[i])) {
            result.push(dontEnums[i]);
          }
        }
      }
      return result;
    };
  }());
}

