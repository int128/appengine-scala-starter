services = angular.module 'knServices', ['ngStorage', 'angularFileUpload']

services.factory 'authStorage', ($localStorage) ->
  $localStorage

services.factory 'Note', ($http, $upload, authStorage) ->
  list: ->
    $http.get '/notes',
      headers:
        'X-EN-Token': authStorage.token
        'X-EN-Environment': authStorage.environment
  get: (guid) ->
    $http.get "/note/#{guid}",
      headers:
        'X-EN-Token': authStorage.token
        'X-EN-Environment': authStorage.environment
  save: (guid, data) ->
    $http.post "/note/#{guid}", data,
      headers:
        'X-EN-Token': authStorage.token
        'X-EN-Environment': authStorage.environment
  addResources: (guid, files, onSuccess) ->
    files.forEach (file) ->
      $upload.upload
        url: "/note/#{guid}/resource"
        headers:
          'X-EN-Token': authStorage.token
          'X-EN-Environment': authStorage.environment
        file: file
      .success onSuccess
  removeResource: (noteId, resourceId, onSuccess) ->
    $http.delete "/note/#{noteId}/resource/#{resourceId}",
      headers:
        'X-EN-Token': authStorage.token
        'X-EN-Environment': authStorage.environment
    .success onSuccess
