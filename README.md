App Engine Hello World
======================

An App Engine application with Scala, Unfiltered and AngularJS.


Architecture
------------

This project contains following:

* Server side
  * Scala
  * [Unfiltered filter](http://unfiltered.databinder.net)
  * [JSON4S](https://github.com/json4s/json4s)
  * [Scalate](http://scalate.fusesource.org)
    * Scalate cache support
  * sbt
    * Scalate precompiling support with [xsbt-scalate-generate](https://github.com/backchatio/xsbt-scalate-generate)
    * App Engine support with [sbt-appengine](https://github.com/sbt/sbt-appengine)
* Client side
  * [CoffeeScript](http://coffeescript.org/)
  * [Less](http://lesscss.org)
  * [AngularJS](https://angularjs.org)
  * [Bootstrap](http://getbootstrap.com)
  * Assets management with [gulp.js](http://gulpjs.com) and [Bower](http://bower.io)


How to setup
------------

Clone the repository.

```bash
git clone git@github.com:int128/sbt-appengine-blank.git myapp
cd myapp
git remote rename origin template
```

Unpack the App Engine SDK and set the environment variable `APPENGINE_SDK_HOME`.

```bash
# ~/.bashrc
export APPENGINE_SDK_HOME="$HOME/App/appengine-java-sdk-x.y.z"
```

Open `src/main/webapp/WEB-INF/appengine-web.xml` and change the application id.

```xml
<appengine-web-app xmlns="http://appengine.google.com/ns/1.0">
    <application>myapp</application>
```


How to run
----------

### App Engine development server

Compile client assets and start the server.

```
$ gulp
$ sbt

> appengineDevServer --port=8888
```

Invoke gulp watch for hot reloading of client assets.

```
$ gulp watch
```


### Light weight server for client assets

```
$ gulp
$ gulp server
```


How to deploy
-------------

Compile client assets and deploy the application.

```
$ gulp
$ sbt

> appengineDeploy --oauth2
```
