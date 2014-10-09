angular
  .module 'geekywallet.editor.compute', []
  .controller 'ComputeCtrl', ($scope, $computedLines, $originalLines) ->
    $scope.computedLines = $computedLines
    $scope.originalLines = $originalLines

    # get people in the context 
    people = if $computedLines.length > 0
    then $computedLines[0].context.people
    else []

    cumulativeLines = []
    for p in people
      p_data = []
      for l, index in $computedLines
        val = l.computed.balance[p]
        next_val = if !!val then val else 0
        new_val = if index == 0
        then next_val
        else p_data[index - 1].value + next_val
        line =
          index: index
          user: p
          value: new_val
          line: l.line
        p_data.push line
      cumulativeLines.push p_data
    $scope.cumulativeLines = cumulativeLines
