angular
  .module 'geekywallet.editor', [
    'ui.ace',
    'geekywallet.wallet',
    # 'geekywallet.connection'
  ]
  .controller 'EditorCtrl', ($scope) ->
    # $scope.aceLoaded = (editor) ->
    #   sharejs.open 'text', 'mywallet', (error, doc) ->
    #     doc.attach_ace editor, true
    #     editor.setReadOnly false

    # $scope.aceCfg =
    #   onLoad: $scope.aceLoaded
    #   readOnly: true