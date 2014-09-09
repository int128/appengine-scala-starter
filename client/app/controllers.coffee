controllers = angular.module 'helloControllers', ['helloServices']

controllers.controller 'TopController', ($scope, LikeService) ->
  $scope.count = LikeService.get()
  $scope.like = ->
    $scope.count = LikeService.increment()
