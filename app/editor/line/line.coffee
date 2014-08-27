angular
  .module 'geekywallet.editor.line', []
  .controller 'LineCtrl', ($scope, $stateParams, $computedLines, $originalLines) ->
    $scope.lineIndex = $stateParams.lineIndex
    $scope.computedLines = $computedLines
    $scope.originalLines = $originalLines
