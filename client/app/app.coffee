app = angular.module 'helloApp', ['helloControllers', 'ngRoute']

app.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'top.html'
      controller: 'TopController'
    .otherwise
      redirectTo: '/'
