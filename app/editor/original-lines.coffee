angular
  .module 'geekywallet.editor.originalLines', []
  .factory '$originalLines', ->
    lines = []

    angular.extend lines,
      $set: (l) ->
        params = ([0, lines.length - 1].concat l)
        Array.prototype.splice.apply lines, params
