angular.module 'geekywallet.editor.graphs', [
  'geekywallet.editor.palette',
  'paths'
]
angular
  .module 'geekywallet.editor', [
    'geekywallet.editor.compute',
    'geekywallet.editor.line',
    'geekywallet.editor.computedLines',
    'geekywallet.editor.originalLines',
    'geekywallet.editor.graphs',
    'ui.ace',
    'geekywallet.wallet',
    'geekywallet.connection'
  ]
  .controller 'EditorCtrl', ($scope, $connection, $computedLines, $originalLines, $wallet, $state, $stateParams) ->
    setupConnection = (editor) ->
      doc = $connection.get 'docs', $stateParams.docID
      doc.subscribe()
      doc.whenReady ->
        console.log 'ready'
        unless doc.type
          doc.create 'text'
        if doc.type && doc.type.name == 'text'
          editor.setValue doc.getSnapshot(), 1
          doc.attach_ace editor, true
          editor.setReadOnly false
          editor.focus()

    setupLiveWallet = (editor) ->
      editor.selection.on 'changeCursor', ->
        if $state.is 'editor.line'
          $state.go 'editor.line',
            lineIndex: editor.selection.getSelectionAnchor().row
        else if $state.is 'editor.compute'
          $scope.$broadcast 'computeLineChangedInEditor', editor.selection.getSelectionAnchor().row

      editor.on 'change', ->
        value = editor.getValue()
        $originalLines.$set value.split '\n'
        try
          $computedLines.$set $wallet value
        catch e
          console.error e




    setupLiveCompute = (editor) ->
      $scope.$on 'computeLineChangedInGraph', (event, line) -> 
        if $state.is 'editor.compute'
          editor.clearSelection()
          editor.selection.moveCursorTo line - 1, 0, true

      $scope.$on 'computeCumulativeLinesChanged', (event, lines, firstLine, lastLine) -> 
        if $state.is 'editor.compute'
          Range=require("ace/range").Range;

          filteredLines = []
          for line in lines
            filteredLines.push line.line

          foldedLines = []
          for i in [firstLine..lastLine]
            if i not in filteredLines
              foldedLines.push i
            else
              editor.getSession().unfold i - 1, true

          start = 0
          for fl, index in foldedLines
            if index != 0 and fl != foldedLines[index - 1] + 1
              range = new Range(foldedLines[start] - 1, 0, foldedLines[index - 1], 0)
              editor.session.addFold("", range)
              start = index
              
            if index == foldedLines.length - 1
              range = new Range(foldedLines[start] - 1, 0, fl, 0)
              editor.session.addFold("", range)

    setupOnStateChange = (editor) ->
      $scope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
        if toState.name == 'editor'
          editor.setReadOnly false
        else if toState.name == 'editor.compute'
          editor.setReadOnly true

    $scope.isStateCompute = () ->
      $state.is 'editor.compute'

    aceWasLoaded = false
    $scope.aceLoaded = (editor) ->
      if aceWasLoaded
        return

      aceWasLoaded = true
      console.log 'ace loaded'

      setupConnection editor
      setupLiveWallet editor
      setupLiveCompute editor
      setupOnStateChange editor

    $scope.aceCfg =
      onLoad: $scope.aceLoaded
      readOnly: true
      mode: 'wallet'
