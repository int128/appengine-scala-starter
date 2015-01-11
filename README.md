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


How to Use
----------

### Setting up environment for client development

Node.js is required.

```bash
brew install node
npm -v
```

### Setting up environment for server development

Java 7 or later is required.

Install App Engine SDK (mandatory) and JRebel (optional).

```bash
brew install app-engine-sdk-java
```

And set environment variables in `.bashrc` or `.zshrc`.

```bash
export APPENGINE_SDK_HOME=/usr/local/Cellar/app-engine-java-sdk/x.y.z/libexec
export JREBEL_PATH=$HOME/Library/jrebel/jrebel.jar
```

### Run the client app

Build the client app and run the mocked server.

```bash
cd client/

npm install
npm install -g gulp

gulp
gulp server
```

### Run the full stack app

Build the client app continuously.

```bash
cd client/
gulp watch
```

Run the app.

```bash
cd server/
sbt

> appengineDevServer --port=8888
```

### Deploy

Build the client app.

```bash
cd client/
gulp
```

Deploy the app.

```bash
cd server/
sbt

> appengineDeploy --oauth2
```

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
