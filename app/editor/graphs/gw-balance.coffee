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
    barSize = 40
    gutter = 10
    padding = 10

    toBarData = (balance) ->
      for key, keyValues of balance
        index = -1
        for person, value of keyValues
          index += 1
          person: person
          value: value
          key: key
          index: index

    scope:
      gwBalance: '='
    templateUrl: 'editor/graphs/gw-balance.html'
    link: (scope) ->
      scope.$watch 'gwBalance', (gwBalance) ->
        return unless gwBalance?.spent?

        count = (Object.keys gwBalance.spent).length
        innerWidth = count * barSize + (count - 1) * gutter
        barData = toBarData gwBalance

        console.log barData

        scope.barCfg =
          stacked: true
          data: barData
          gutter: gutter
          width: innerWidth + 2 * padding
          accessor: ({value}) -> value
          padding: padding
          compute:
            color: (i, item) ->
              sibling = barData[if i == 0 then 1 else 0][item.index]
              if sibling.value > item.value then '#ccc' else switch item.key
                when 'given' then 'green'
                when 'spent' then 'red'
