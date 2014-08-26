angular
  .module 'geekywallet.editor', [
    'geekywallet.editor.compute',
    'geekywallet.editor.line',
    'geekywallet.editor.computedLines',
    'ui.ace',
    'geekywallet.wallet',
    # 'geekywallet.connection'
  ]
  .controller 'EditorCtrl', ($scope, $computedLines) ->
    $computedLines.$set [1, 2, 3]
    # $scope.aceLoaded = (editor) ->
    #   sharejs.open 'text', 'mywallet', (error, doc) ->
    #     doc.attach_ace editor, true
    #     editor.setReadOnly false

    # $scope.aceCfg =
    #   onLoad: $scope.aceLoaded
    #   readOnly: true