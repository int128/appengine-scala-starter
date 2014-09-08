# gulpfile.coffee: build script for front assets
#
# gulp        - build assets
# gulp watch  - build assets continuously
# gulp server - start a server with assets and mocked APIs

sources =
  bower:  'bower.json'
  coffee: 'src/main/coffeescript/**/*'
  less:   'src/main/less/**/*'
  static: 'src/main/static/**/*'

libs =
  js: [
    'angular/angular.min.js'
    'angular-route/angular-route.min.js'
  ]
  css:    ['bootstrap/dist/**/*.min.css']
  static: ['bootstrap/dist/**/*']


bower       = require 'bower'
del         = require 'del'
gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
concat      = require 'gulp-concat'
less        = require 'gulp-less'
ngAnnotate  = require 'gulp-ng-annotate'
nodemon     = require 'gulp-nodemon'
uglify      = require 'gulp-uglify'


gulp.task 'default', ['clean'], ->
  gulp.start 'compile:lib', 'compile:coffee', 'compile:less', 'compile:static'

gulp.task 'clean', (cb) ->
  del 'src/main/webapp/', cb

gulp.task 'watch', ->
  gulp.watch sources.bower,  ['compile:lib']
  gulp.watch sources.coffee, ['compile:coffee']
  gulp.watch sources.less,   ['compile:less']
  gulp.watch sources.static, ['compile:static']


gulp.task 'compile:lib', ->
  bower.commands.install().on 'end', ->
    gulp.src libs.js.map (e) -> "bower_components/#{e}"
      .pipe concat 'lib.js'
      .pipe gulp.dest 'src/main/webapp/'
      .pipe gulp.dest 'target/webapp/'
    gulp.src libs.css.map (e) -> "bower_components/#{e}"
      .pipe concat 'lib.css'
      .pipe gulp.dest 'src/main/webapp/'
      .pipe gulp.dest 'target/webapp/'
    gulp.src libs.static.map (e) -> "bower_components/#{e}"
      .pipe gulp.dest 'src/main/webapp/'
      .pipe gulp.dest 'target/webapp/'

gulp.task 'compile:coffee', ->
  gulp.src sources.coffee
    .pipe coffee()
    .pipe ngAnnotate()
    .pipe uglify()
    .pipe concat 'app.js'
    .pipe gulp.dest 'src/main/webapp/'
    .pipe gulp.dest 'target/webapp/'

gulp.task 'compile:less', ->
  gulp.src sources.less
    .pipe less()
    .pipe concat 'app.css'
    .pipe gulp.dest 'src/main/webapp/'
    .pipe gulp.dest 'target/webapp/'

gulp.task 'compile:static', ->
  gulp.src sources.static
    .pipe gulp.dest 'src/main/webapp/'
    .pipe gulp.dest 'target/webapp/'


gulp.task 'server', ['compile:apimock'], ->
  gulp.start 'watch', 'watch:apimock'
  nodemon
    watch:  ['target/apimock/', 'target/webapp/']
    script: 'target/apimock/app.js'
    env:
      port: 8888
      webapp: "#{__dirname}/target/webapp/"

gulp.task 'watch:apimock', ->
  gulp.watch 'src/apimock/coffeescript/**/*', ['compile:apimock']

gulp.task 'compile:apimock', ->
  gulp.src 'src/apimock/coffeescript/**/*'
    .pipe coffee()
    .pipe concat 'app.js'
    .pipe gulp.dest 'target/apimock/'
