angular
  .module 'geekywallet.editor.filters', [
    'geekywallet.editor.userFilter',
    'geekywallet.editor.tagFilter'
  ]

angular
  .module 'geekywallet.editor.compute', ['geekywallet.editor.filters']
  .controller 'ComputeCtrl', ($scope, $computedLines, $originalLines, userFilter) ->
    $scope.computedLines = $computedLines
    $scope.originalLines = $originalLines
    $scope.selectedUser = ''

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
          tags: if l.tags? then l.tags else []
        p_data.push line
      cumulativeLines.push p_data
    $scope.cumulativeLines = cumulativeLines

    filterWatch = ->
      user: $scope.selectedUser

    updateFilteredLines = (filters) ->
      console.log 'updateFilteredLines', filters
      lines = $scope.cumulativeLines
      $scope.filteredLines = userFilter lines, filters.user

    $scope.$watchCollection filterWatch, updateFilteredLines
