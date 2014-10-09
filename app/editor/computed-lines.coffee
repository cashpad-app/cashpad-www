angular
  .module 'geekywallet.editor.computedLines', []
  .factory '$computedLines', ->
    lines = []

    angular.extend lines,
      $set: (l) ->
        params = ([0, lines.length].concat l)
        Array.prototype.splice.apply lines, params

