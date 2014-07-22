gulp = require('gulp')
concat = require('gulp-concat')
coffee = require('gulp-coffee')
ngmin = require('gulp-ngmin')
uglify = require('gulp-uglify')
less = require('gulp-less')
connect = require('gulp-connect')
del = require('del')
bower = require('bower')

sources =
  bower:  'bower.json'
  coffee: 'src/main/coffeescript/**/*'
  less:   'src/main/less/**/*'
  static: 'src/main/static/**/*'

targets =
  gulp: 'src/main/webapp/'
  appengineDevServer: 'target/webapp/'

gulp.task 'bower', ->
  bower.commands.install().on 'end', (installed) ->
    gulp.src([
        'bower_components/angular/angular.min.js'
        'bower_components/angular-route/angular-route.min.js'
      ])
      .pipe(concat('lib.js'))
      .pipe(gulp.dest(targets.gulp))
      .pipe(gulp.dest(targets.appengineDevServer))
    gulp.src([
        'bower_components/bootstrap/dist/**/*'
      ])
      .pipe(gulp.dest(targets.gulp))
      .pipe(gulp.dest(targets.appengineDevServer))

gulp.task 'coffee', ->
  gulp.src(sources.coffee)
    .pipe(coffee())
    .pipe(ngmin())
    .pipe(uglify())
    .pipe(concat('app.js'))
    .pipe(gulp.dest(targets.gulp))
    .pipe(gulp.dest(targets.appengineDevServer))

gulp.task 'less', ->
  gulp.src(sources.less)
    .pipe(less())
    .pipe(concat('app.css'))
    .pipe(gulp.dest(targets.gulp))
    .pipe(gulp.dest(targets.appengineDevServer))

gulp.task 'static', ->
  gulp.src(sources.static)
    .pipe(gulp.dest(targets.gulp))
    .pipe(gulp.dest(targets.appengineDevServer))

gulp.task 'default', ['clean'], ->
  gulp.start 'bower', 'coffee', 'less', 'static'

gulp.task 'watch', ->
  gulp.watch sources.bower,  ['bower']
  gulp.watch sources.coffee, ['coffee']
  gulp.watch sources.less,   ['less']
  gulp.watch sources.static, ['static']

gulp.task 'server', ['watch'], ->
  connect.server
    root: targets.gulp
    port: 8888
    livereload: true

gulp.task 'clean', (cb) -> del targets.gulp, cb
