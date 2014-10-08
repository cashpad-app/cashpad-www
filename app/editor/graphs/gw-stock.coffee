angular
  .module 'geekywallet.editor.graphs'
  .directive 'gwStock', ->

    scope:
      gwStock: '='
    templateUrl: 'editor/graphs/gw-stock.html'
    link: (scope) ->
      scope.mouseMove = ($event) ->
        # console.log scope.stockCfg.$viewport.width
        if $event.pageX <= scope.stockCfg.$viewport.width - scope.stockCfg.paddingRight and $event.pageX >= scope.stockCfg.padding
          scope.lineX = $event.pageX - scope.stockCfg.padding
          if scope.currentPath
            scope.currentPoint = Math.round(scope.lineX /
                  ((scope.stockCfg.$viewport.width - (scope.stockCfg.padding + scope.stockCfg.paddingRight)) /
                    (scope.gwStock[scope.currentPath].length - 1)))
            # console.log $event.pageX

      scope.selectPath = ($event, $index) ->
        scope.currentPath = $index
        scope.mouseMove($event)

      scope.$watch 'gwStock', (gwStock) ->

        palette = ['red', 'blue', 'green', 'gray', 'salmon', 'yellow', 'brown', 'purple']

        toRemove = []

        for currentPath, i in gwStock
          if toRemove.indexOf(i) == -1
            for pathToMatch, j in gwStock[i+1..]
              samePath = true;
              for item, k in currentPath
                if (item.value != pathToMatch[k].value)
                  samePath = false;
                  break;

              if samePath
                toRemove.push j+1
                for item in currentPath
                  item.user += " " + pathToMatch[0].user

        for r, count in toRemove
          gwStock.splice(r - count, 1)

        scope.stockCfg =
          data: gwStock
          xaccessor: (item) -> item.index
          yaccessor: (item) -> item.value
          # width: 500
          # height: 300
          padding: 10
          paddingRight: 100
          compute:
            color: (item) -> palette[item % palette.length]
          closed: true
