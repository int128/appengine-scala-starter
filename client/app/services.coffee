services = angular.module 'helloServices', []

services.factory 'LikeService', ->
  count: 0
  get: ->
    @count
  increment: ->
    ++@count
