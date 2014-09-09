App Engine Hello World
======================

An App Engine application with Scala, Unfiltered and AngularJS.


Architecture
------------

* Client app
  * [CoffeeScript](http://coffeescript.org/)
  * [Less](http://lesscss.org)
  * [AngularJS](https://angularjs.org)
  * [Bootstrap](http://getbootstrap.com)
  * Assets management with [gulp.js](http://gulpjs.com) and [Bower](http://bower.io)
  * Server with API mock for testing
* Server app
  * Scala
  * [Unfiltered filter](http://unfiltered.databinder.net)
  * [JSON4S](https://github.com/json4s/json4s)
  * [Scalate](http://scalate.fusesource.org)
    * Memcache support
  * sbt
    * Scalate precompiling support with [xsbt-scalate-generate](https://github.com/backchatio/xsbt-scalate-generate)
    * App Engine support with [sbt-appengine](https://github.com/sbt/sbt-appengine)


Structure
---------

* `client/`
  * `app/` - CoffeeScript and Less sources of the product
  * `public/` - Static files of the product
  * `target/webapp/` - (output) Compiled assets and static files
  * `apimock.coffee` - Source of server and API mock for testing
  * `bower.json` - Dependencies of the product
  * `package.json` - Dependencies for build and test
* `server/`
  * `src/main/scala/` - Scala sources of the product
  * `src/test/scala/` - Scala sources of the test
  * `target/webapp/` - (output) Compiled classes and client app
  * `build.sbt` - Scala dependencies


Setup
-----

### Prerequisite

* Server app
  * Java 7 or later
  * sbt
  * App Engine SDK
  * JRebel (optional)
* Client app
  * Node.js
  * npm


### Client app

Install dependencies.

```bash
cd client/
npm install
npm install -g gulp
```


### Server app

Set environment variables: `APPENGINE_SDK_HOME` (mandatory) and `JREBEL_PATH` (optional).

```bash
# .bashrc or .zshrc
export APPENGINE_SDK_HOME=/usr/local/Cellar/app-engine-java-sdk/x.y.z/libexec
export JREBEL_PATH=$HOME/Library/jrebel/jrebel.jar
```

Open `server/src/main/webapp/WEB-INF/appengine-web.xml` and change the application id.

```xml
<appengine-web-app xmlns="http://appengine.google.com/ns/1.0">
    <application>myapp</application>
```


Run
---

### Full stack app

Build client assets continuously.

```bash
cd client/
gulp watch
```

Start an App Engine development server.

```bash
cd server/
sbt

> appengineDevServer --port=8888
```


### Client app with API mock

Start an express server.

```bash
cd client/
gulp
gulp server
```


Deploy
------

Build client assets.

```bash
cd client/
gulp
```

Deploy the application.

```bash
cd server/
sbt

> appengineDeploy --oauth2
```
