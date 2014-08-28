angular
  .module 'geekywallet.editor.line', []
  .controller 'LineCtrl', ($scope, $stateParams, $computedLines, $originalLines) ->
    $scope.originalLines = $originalLines
    $scope.$watchCollection (-> $computedLines), (computedLines) ->
      $scope.computedLine = computedLines.filter((l) -> l.line == $stateParams.lineIndex + 1)[0]
