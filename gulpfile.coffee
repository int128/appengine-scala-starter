# gulpfile.coffee: build script for front assets

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
connect     = require 'gulp-connect'
less        = require 'gulp-less'
ngAnnotate  = require 'gulp-ng-annotate'
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


gulp.task 'server', ['watch'], ->
  connect.server
    root: 'src/main/webapp/'
    port: 8888
    livereload: true
