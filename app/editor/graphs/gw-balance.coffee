angular
  .module 'geekywallet.editor.graphs'
  .directive 'gwBalance', ($palette) ->
    toBarCfg = (what) ->
      (balance) ->
        v for _, v of balance[what]

    scope:
      gwBalance: '='
    templateUrl: 'editor/graphs/gw-balance.html'
    link: (scope) ->
      palette = $palette.random()

      scope.$watch 'gwBalance', (gwBalance) ->
        scope.spentBarCfg =
          data: [toBarCfg('spent') gwBalance]
          max: 1000
          compute:
            color: palette.get

        scope.givenBarCfg =
          data: [toBarCfg('given') gwBalance]
          max: 1000
          compute:
            color: palette.get