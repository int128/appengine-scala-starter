controllers = angular.module 'helloControllers', []

controllers.controller 'TopController', ($scope) ->
  $scope.content = 'Hello World'
