angular
  .module 'geekywallet.editor', [
    'ui.ace',
    'geekywallet.wallet',
    'geekywallet.connection'
  ]
  .controller 'EditorCtrl', ($scope, $connection) ->
    $scope.aceLoaded = (editor) ->
      doc = $connection.get 'mywallet'
      doc.subscribe()
      doc.whenReady ->
        console.log 'whenready'
        doc.attach_ace editor, true
        editor.setReadOnly false

    $scope.aceCfg =
      onLoad: $scope.aceLoaded
      readOnly: true