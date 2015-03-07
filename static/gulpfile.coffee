# gulpfile.coffee: build script for static assets
#
# gulp        - build assets
# gulp watch  - build assets continuously
# gulp server - start a server with assets and mocked APIs

sources =
  bower:  'bower.json'
  coffee: 'app/**/*.coffee'
  less:   'app/**/*.less'
  static: 'public/**/*'

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
  del 'target', cb

gulp.task 'watch', ->
  gulp.watch sources.bower,  ['compile:lib']
  gulp.watch sources.coffee, ['compile:coffee']
  gulp.watch sources.less,   ['compile:less']
  gulp.watch sources.static, ['compile:static']


gulp.task 'compile:lib', ->
  bower.commands.install().on 'end', ->
    gulp.src libs.js.map (e) -> "bower_components/#{e}"
      .pipe concat 'lib.js'
      .pipe gulp.dest 'target'
    gulp.src libs.css.map (e) -> "bower_components/#{e}"
      .pipe concat 'lib.css'
      .pipe gulp.dest 'target'
    gulp.src libs.static.map (e) -> "bower_components/#{e}"
      .pipe gulp.dest 'target'

gulp.task 'compile:coffee', ->
  gulp.src sources.coffee
    .pipe coffee()
    .pipe ngAnnotate()
    .pipe uglify()
    .pipe concat 'app.js'
    .pipe gulp.dest 'target'

gulp.task 'compile:less', ->
  gulp.src sources.less
    .pipe less()
    .pipe concat 'app.css'
    .pipe gulp.dest 'target'

gulp.task 'compile:static', ->
  gulp.src sources.static
    .pipe gulp.dest 'target'


gulp.task 'server', ->
  nodemon
    script: 'server.js'
    watch: ['server.js', 'target']
    env:
      port: 3000
      webapp: "#{__dirname}/target"
