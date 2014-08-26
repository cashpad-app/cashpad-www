angular
  .module 'geekywallet.editor.line', []
  .controller 'LineCtrl', ($scope, $stateParams, $computedLines) ->
    $scope.lineIndex = $stateParams.lineIndex
    $scope.computedLines = $computedLines
