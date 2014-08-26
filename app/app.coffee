angular
  .module 'geekywallet', [
    'ui.router',
    'geekywallet.landing',
    'geekywallet.editor'
  ]
  .config ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/'

    $stateProvider.state 'landing',
      url: '/',
      templateUrl: 'landing/landing.html',
      controller: 'LandingCtrl'

    $stateProvider.state 'editor',
      url: '/editor',
      templateUrl: 'editor/editor.html',
      controller: 'EditorCtrl'

      $stateProvider.state 'editor.compute',
        url: '/compute',
        templateUrl: 'editor/compute/compute.html',
        controller: 'ComputeCtrl'

      $stateProvider.state 'editor.line',
        url: '/{lineIndex:[0-9]+}',
        templateUrl: 'editor/line/line.html',
        controller: 'LineCtrl'