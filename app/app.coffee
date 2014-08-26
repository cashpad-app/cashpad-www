angular
  .module 'geekywallet', [
    'ui.ace',
    'geekywallet.wallet',
    'geekywallet.connection'
  ]
  .controller 'MyCtrl', ($scope, $connection) ->
    $scope.aceLoaded = (editor) ->
      doc = $connection.get 'mywallet'
      doc.whenReady ->
        doc.attach_ace editor, true
        editor.setReadOnly false

    $scope.aceCfg =
      onLoad: $scope.aceLoaded
      readOnly: true