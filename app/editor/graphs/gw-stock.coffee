angular
  .module 'geekywallet.editor.graphs'
  .directive 'gwStock', ($timeout) ->
    scope:
      gwStock: '='
    templateUrl: 'editor/graphs/gw-stock.html'
    link: (scope) ->
      scope.$on 'computeLineChangedInEditor', (event, line) ->
        if scope.currentPoint?
          for path in scope.stockCfg.data
            for item, i in path
              if item.line == line + 1
                $timeout ->
                  scope.currentPoint = i
                break

      scope.graphState = {};

      scope.mouseMove = ($event) ->
        return unless scope.graphState?.viewport?
        viewport = scope.graphState.viewport

        if $event.pageX < scope.stockCfg.padding
          scope.lineX = 0
        else if $event.pageX > viewport.width - scope.stockCfg.paddingRight
          scope.lineX = viewport.width - scope.stockCfg.paddingRight - scope.stockCfg.padding
        else
          scope.lineX = $event.pageX - scope.stockCfg.padding

        if scope.currentPath?
          newCurrentPoint = Math.round(scope.lineX /
                ((viewport.width - (scope.stockCfg.padding + scope.stockCfg.paddingRight)) /
                  (scope.gwStock[0].length - 1)))
          if newCurrentPoint != scope.currentPoint
            scope.currentPoint = newCurrentPoint
            scope.$emit 'computeLineChangedInGraph', scope.stockCfg.data[scope.currentPath][scope.currentPoint].line

      scope.selectPath = ($event, $index) ->
        scope.currentPath = $index
        scope.mouseMove($event)

      scope.getRectTextX = (xscale) ->
        return unless scope.graphState?.viewport?
        viewport = scope.graphState.viewport

        if scope.currentPath? and scope.currentPoint?
          pointX = xscale(scope.stockCfg.data[scope.currentPath][scope.currentPoint].index)
          valueLength = scope.stockCfg.data[scope.currentPath][scope.currentPoint].value.toFixed(2).toString().length

          if pointX - valueLength * 5.5 > 0 and pointX + valueLength * 5.5 < viewport.innerWidth
            pointX - valueLength * 5.5
          else if pointX - valueLength * 5.5 <= 0
            3
          else
            viewport.innerWidth - valueLength * 11 - 3
        else
          0

      scope.getRectTextY = (yscale) ->
        if scope.currentPath? and scope.currentPoint?
          value = scope.stockCfg.data[scope.currentPath][scope.currentPoint].value
          if yscale(value) - 42 > 5
            yscale(value) - 42
          else
            yscale(value) + 16
        else
          0

      scope.getTextX = (xscale) ->
        if !scope.currentPoint?
          0
        else
          scope.getRectTextX(xscale) + scope.stockCfg.data[scope.currentPath][scope.currentPoint].value.toFixed(2).toString().length * 5.5

      scope.getTextY = (yscale) ->
        if !scope.currentPoint?
          return 0

        rectY = scope.getRectTextY(yscale)
        if rectY > yscale(scope.stockCfg.data[scope.currentPath][scope.currentPoint].value)
          rectY + 19
        else
          rectY + 19

      gwStockWatch = (gwStock) ->
        palette = ['red', 'blue', 'green', 'gray', 'salmon', 'yellow', 'brown', 'purple']
        scope.currentPath = undefined
        scope.currentPoint = undefined

        # group duplicates together
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

        # create array with Y value of each 'step'
        if gwStock.length > 0
          scope.ySteps = []
          values = []
          for currentPath in gwStock
            for item in currentPath
              values.push item.value
          
          max = (acc, current) -> Math.max(acc,current)
          min = (acc, current) -> Math.min(acc,current)

          maxValue = Math.abs values.reduce(max, -Infinity)
          minValue = Math.abs values.reduce(min, Infinity)

          stepSize = Math.round(((maxValue + minValue) / 10))

          for i in [0..maxValue / stepSize]
            scope.ySteps.push i * stepSize

          for i in [1..minValue / stepSize]
            scope.ySteps.push i * -stepSize

        scope.stockCfg =
          data: gwStock
          xaccessor: (item) -> item.index
          yaccessor: (item) -> item.value
          padding: 10
          paddingRight: 170
          compute:
            color: (item) -> palette[item % palette.length]
          closed: true

      scope.$watch 'gwStock', gwStockWatch
