angular
  .module 'geekywallet.editor', [
    'ui.ace',
    'geekywallet.wallet',
    'geekywallet.connection'
  ]
  .controller 'EditorCtrl', ($scope, $connection) ->
    $scope.aceLoaded = (editor) ->
      editor.setReadOnly true
      console.log 'ace loaded'
      doc = $connection.get 'users', 'seth'
      doc.subscribe()
      doc.whenReady ->
        console.log 'ready'
        unless doc.type
          doc.create 'text'
        if doc.type && doc.type.name == 'text'
          doc.attach_ace editor, true
          editor.setReadOnly false

    $scope.aceCfg =
      onLoad: $scope.aceLoaded
      readOnly: true
