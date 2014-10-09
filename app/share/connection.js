'use strict';

angular.module('geekywallet.connection', [
  'reconnectingWebSocket'
  ])
  .service('$connection', function(WebSocket) {
    function handleShareJSMessage(json) {
      var data = json.data;
      sjsSocketWrapper.onmessage({data: data});
    }

    var ws = new WebSocket('ws://10.0.0.135:9000');
    ws.onmessage = function(msg) {
      var json = JSON.parse(msg.data);
      switch (json.type) {
        case 'sharejs_message':
          handleShareJSMessage(json);
          break;
      }
    };

    var sjsSocketWrapper = {
      readyState : 1, // assume ready
      close : function() {
        console.log('sharejs required to close the connection');
      },
      send : function(msg) {
        ws.send(JSON.stringify({
          type: 'sharejs_message',
          data: JSON.parse(msg)
        }));
      }
    };

    return new window.sharejs.Connection(sjsSocketWrapper);
  });
