angular
  .module 'geekywallet.editor', [
    'geekywallet.editor.compute',
    'geekywallet.editor.line',
    'geekywallet.editor.computedLines',
    'ui.ace',
    'geekywallet.wallet',
    # 'geekywallet.connection'
  ]
  .controller 'EditorCtrl', ($computedLines, $wallet, $http) ->
    $http
      .get 'liechtenstein'
      .then (data) ->
        $computedLines.$set $wallet data.data
    # $scope.aceLoaded = (editor) ->
    #   sharejs.open 'text', 'mywallet', (error, doc) ->
    #     doc.attach_ace editor, true
    #     editor.setReadOnly false

    # $scope.aceCfg =
    #   onLoad: $scope.aceLoaded
    #   readOnly: true