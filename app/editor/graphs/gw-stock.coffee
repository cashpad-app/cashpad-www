angular
  .module 'geekywallet.editor.graphs'
  .directive 'gwStock', ->

    scope:
      gwStock: '='
    templateUrl: 'editor/graphs/gw-stock.html'
    link: (scope) ->
      scope.mouseMove = ($event) ->
        if $event.pageX < scope.stockCfg.padding
          scope.lineX = 0
        else if $event.pageX > scope.stockCfg.$viewport.width - scope.stockCfg.paddingRight
          scope.lineX = scope.stockCfg.$viewport.width - scope.stockCfg.paddingRight - scope.stockCfg.padding
        else
          scope.lineX = $event.pageX - scope.stockCfg.padding

        if scope.currentPath?
          scope.currentPoint = Math.round(scope.lineX /
                ((scope.stockCfg.$viewport.width - (scope.stockCfg.padding + scope.stockCfg.paddingRight)) /
                  (scope.gwStock[0].length - 1)))

      scope.selectPath = ($event, $index) ->
        scope.currentPath = $index
        scope.mouseMove($event)

      scope.getRectTextX = (xscale) ->
        pointX = xscale(scope.stockCfg.data[scope.currentPath][scope.currentPoint].index)
        valueLength = scope.stockCfg.data[scope.currentPath][scope.currentPoint].value.toFixed(2).toString().length
        
        if pointX - valueLength * 5.5 > 0 and pointX + valueLength * 5.5 < scope.stockCfg.$viewport.innerWidth
          pointX - valueLength * 5.5
        else if pointX - valueLength * 5.5 <= 0 
          3
        else
          scope.stockCfg.$viewport.innerWidth - valueLength * 11 - 3

      scope.getTextX = (xscale) ->
        scope.getRectTextX(xscale) + scope.stockCfg.data[scope.currentPath][scope.currentPoint].value.toFixed(2).toString().length * 5.5


      # scope.getTextY = (yscale) ->
      #   value = yscale(scope.stockCfg.data[scope.currentPath][scope.currentPoint].value)
      #   return value - 42 > 5 ? value - 23 : value + 35

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
          paddingRight: 170
          compute:
            color: (item) -> palette[item % palette.length]
          closed: true
