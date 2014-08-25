angular
  .module 'geekywallet', ['geekywallet.pie']
  .controller 'MyCtrl', ($scope) ->
    $scope.pie = {
      data: [
        { name: 'Italy', population: 59859996 },
        { name: 'Mexico', population: 118395054 },
        { name: 'France', population: 65806000 },
        { name: 'Argentina', population: 50117096 },
        { name: 'Japan', population: 127290000 }
      ],
      accessor: (x) -> x.population
    }
