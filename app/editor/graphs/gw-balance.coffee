angular
  .module 'geekywallet.editor.graphs'

  .filter 'gwBalanceUniquePerson', ($filter) ->
    (items) ->
      maxed = items.map (item, i) ->
        couple = [item, items[if i % 2 == 0 then i + 1 else i - 1]]
        angular.extend item,
          line: if couple[0].line.centroid[1] < couple[1].line.centroid[1] then couple[0].line else couple[1].line
      $filter('unique') maxed, 'item.person'

  .directive 'gwBalance', ->
    barSize = 42
    gutter = 5
    padding = gutter
    paddingLeft = 30

    toBarData = (balance) ->
      for key, keyValues of balance
        index = -1
        for person, value of keyValues
          index += 1
          person: person
          value: value
          key: key
          index: index

    nActiveParticipants = (balance) ->
      participants = {}
      for key, keyValues of balance
        for person, value of keyValues
          if value > 0
            participants[person] = true
      Object.keys(participants).length

    scope:
      gwBalance: '='
    templateUrl: 'editor/graphs/gw-balance.html'
    link: (scope) ->
      scope.$watch 'gwBalance', (gwBalance) ->
        return unless gwBalance?.spent?

        count = nActiveParticipants gwBalance
        innerWidth = count * barSize + (count - 1) * gutter
        barData = toBarData gwBalance

        scope.barCfg =
          stacked: true
          data: barData
          gutter: gutter
          width: innerWidth + 2 * padding
          accessor: ({value}) -> value
          padding: padding
          paddingLeft: paddingLeft
          compute:
            colorClass: (i, item) ->
              sibling = barData[if i == 0 then 1 else 0][item.index]
              if sibling.value > item.value then 'balance' else item.key
