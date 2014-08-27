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
  .controller 'EditorCtrl', ($scope, $connection, $computedLines, $originalLines, $wallet, $state) ->
    setupConnection = (editor) ->
      doc = $connection.get 'users', 'seth'
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
        $state.go 'editor.line',
          lineIndex: editor.selection.getSelectionAnchor().row

      editor.on 'change', ->
        value = editor.getValue()
        $originalLines.$set value.split '\n'
        try
          $computedLines.$set $wallet value
        catch e
          console.error e

    aceWasLoaded = false
    $scope.aceLoaded = (editor) ->
      if aceWasLoaded
        return

      aceWasLoaded = true
      console.log 'ace loaded'

      setupConnection editor
      setupLiveWallet editor

    $scope.aceCfg =
      onLoad: $scope.aceLoaded
      readOnly: true
      mode: 'wallet'
