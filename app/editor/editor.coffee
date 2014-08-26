angular
  .module 'geekywallet.editor', [
    'geekywallet.editor.compute',
    'geekywallet.editor.line',
    'geekywallet.editor.computedLines',
    'ui.ace',
    'geekywallet.wallet',
    'geekywallet.connection'
  ]
  .controller 'EditorCtrl', ($scope, $connection, $computedLines, $wallet, $http) ->
	  $http
      .get 'liechtenstein'
      .then (data) ->
        $computedLines.$set $wallet data.data
    aceWasLoaded = false
    $scope.aceLoaded = (editor) ->
      if aceWasLoaded
        return
      aceWasLoaded = true
      editor.setReadOnly true
      console.log 'ace loaded'
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

    $scope.aceCfg =
      onLoad: $scope.aceLoaded
      readOnly: true
