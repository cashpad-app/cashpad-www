angular
  .module 'geekywallet.editor.filters', [
    'geekywallet.editor.userFilter',
    'geekywallet.editor.datesFilter',
    'geekywallet.editor.tagFilter'
  ]

angular
  .module 'geekywallet.editor.compute', ['geekywallet.editor.filters', 'mgcrea.ngStrap']
  .controller 'ComputeCtrl', ($scope, $computedLines, $originalLines, userFilter, tagFilter, datesFilter) ->
    $scope.computedLines = $computedLines
    $scope.originalLines = $originalLines
    $scope.filteredPeople = ''
    $scope.filteredTags = ''
    $scope.people = if $computedLines.length > 0
    then $computedLines[0].context.people
    else []



    updateCumulativeLines = (filteredLines) ->
      if filteredLines.length > 0
        people = []
        if $scope.filteredPeople? and $scope.filteredPeople.length > 0
          filteredPeople = $scope.filteredPeople.split ' '
          for p in $scope.people
            for fp in filteredPeople
              if p.match new RegExp '.*' + fp + '.*'
                people.push p
                break
        else
          people = $scope.people

        cumulativeLines = []
        for p in people
          p_data = []
          for l, index in filteredLines
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
              tags: l.tags
              date: l.date
            p_data.push line
          cumulativeLines.push p_data
        $scope.cumulativeLines = cumulativeLines
      else
        $scope.cumulativeLines = []

    filterWatch = ->
      people: $scope.filteredPeople
      tags: $scope.filteredTags
      fromDate: $scope.filteredFromDate
      untilDate: $scope.filteredUntilDate

    updateFilteredLines = (filters) ->
      console.log 'updateFilteredLines', filters
      lines = $scope.computedLines
      tags = tagFilter(lines, filters.tags)
      date = datesFilter(tags, filters.fromDate, filters.untilDate)
      users = userFilter(date, filters.users)
      filteredLines = users
      updateCumulativeLines filteredLines

    $scope.$watchCollection filterWatch, updateFilteredLines
