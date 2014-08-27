angular
  .module 'geekywallet.editor.graphs'
  .directive 'gwBalance', ->
    barSize = 40
    gutter = 10

    toStackedBarData = (balance) ->
      for key, keyValues of balance
        for person, value of keyValues
          person: person
          value: value
          key: key

    peopleCount = (balance) -> (Object.keys balance.spent).length

    scope:
      gwBalance: '='
    templateUrl: 'editor/graphs/gw-balance.html'
    link: (scope) ->
      scope.$watch 'gwBalance', (gwBalance) ->
        return unless gwBalance?.spent?
        count = peopleCount gwBalance

        scope.stackedBarCfg =
          data: toStackedBarData gwBalance
          gutter: gutter
          width: count * barSize + (count - 1) * gutter
          accessor: ({value}) -> value
          compute:
            color: (_, item) -> switch item.key
              when 'given' then 'green'
              when 'spent' then 'red'
