controllers = angular.module 'helloControllers', ['helloServices']

controllers.controller 'TopController', ($scope, LikeService) ->
  $scope.count = 0
  LikeService.get (initialValue) ->
    $scope.count = initialValue
  $scope.like = ->
    LikeService.increment (newValue) ->
      $scope.count = newValue
