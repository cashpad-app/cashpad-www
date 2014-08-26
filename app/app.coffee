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