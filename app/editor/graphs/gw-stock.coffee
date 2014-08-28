angular
  .module 'geekywallet.editor.graphs'
  .directive 'gwStock', ->

    scope:
      gwStock: '='
    templateUrl: 'editor/graphs/gw-stock.html'
    link: (scope) ->
      scope.$watch 'gwStock', (gwStock) ->

        palette = ['red', 'blue', 'green', 'gray', 'salmon']

        scope.stockCfg =
          data: gwStock
          xaccessor: (item) -> item.index
          yaccessor: (item) -> item.value
          width: 500
          height: 300
          compute:
            color: (item) -> palette[item % palette.length]
          closed: true
