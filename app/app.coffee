palette = ['#009900', '#990000', '#009900', '#009900', '#090900']

[spent, given] = ['spent', 'given']

removeDuplicates = (ar) ->
  if ar.length == 0
    return []
  res = {}
  res[ar[key]] = ar[key] for key in [0..ar.length-1]
  value for key, value of res

parseData = (type, data) ->
  people = removeDuplicates((l.context.people for l in data).reduce (x, y) ->
    x.concat y)
  ({
  name: p
  count: (
    init = {}
    init[p] = 0
    (data.reduce (x, y) ->
        x[p] += y.computed[type][p] if (!isNaN(y.computed[type][p]))
        x
      , init))[p]
  } for p in people)

angular
  .module 'geekywallet', ['geekywallet.pie']
  .controller 'MyCtrl', ($scope) ->
    $scope.types = [spent, given]
    $scope.selection = spent

    piefy = (type, data) ->
      data: parseData(type, data),
      accessor: (i) -> i.count,
      r: 30,
      R: 100,
      compute:
        color: (i) -> palette[i % palette.length]

    $scope.$watch('selection', ((newVal, oldVal) ->
      console.log(newVal + " " + oldVal)
      $scope.pie = piefy(newVal, data)
      console.log($scope.pie)
    ), true)
