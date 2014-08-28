angular
  .module 'geekywallet.editor.graphs'
  .directive 'gwBalance', ->
    barSize = 40
    gutter = 10
    padding = 10

    toStackedBarData = (balance) ->
      for key, keyValues of balance
        for person, value of keyValues
          person: person
          value: value
          key: key

    scope:
      gwBalance: '='
    templateUrl: 'editor/graphs/gw-balance.html'
    link: (scope) ->
      scope.$watch 'gwBalance', (gwBalance) ->
        return unless gwBalance?.spent?

        count = (Object.keys gwBalance.spent).length
        innerWidth = count * barSize + (count - 1) * gutter

        scope.stackedBarCfg =
          data: toStackedBarData gwBalance
          gutter: gutter
          width: innerWidth + 2 * padding
          accessor: ({value}) -> value
          padding: padding
          compute:
            color: (i, item) -> switch item.key
              when 'given' then 'green'
              when 'spent' then 'red'
