services = angular.module 'helloServices', []

services.factory 'LikeService', ($http) ->
  get: (f) ->
    $http.get '/like'
      .success (res) ->
        f res.count
  increment: (f) ->
    $http.post '/like'
      .success (res) ->
        f res.count
