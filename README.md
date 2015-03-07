App Engine Scala Template
=========================

A template project with Scala and Unfiltered on Google App Engine.

* Scala
* [Unfiltered filter](http://unfiltered.databinder.net)
* [JSON4S](https://github.com/json4s/json4s)
* [Scalate](http://scalate.fusesource.org)
  * Memcache support
* sbt
  * Scalate precompiling support with [xsbt-scalate-generate](https://github.com/backchatio/xsbt-scalate-generate)
  * App Engine support with [sbt-appengine](https://github.com/sbt/sbt-appengine)


Prepare
-------

Java 7 or later is required.

Install App Engine SDK (mandatory) and JRebel (recommended).

```bash
gcloud components update gae-java
```

Set environment variables in `.bashrc` or `.zshrc`.

```bash
export APPENGINE_SDK_HOME=$HOME/Library/google-cloud-sdk/platform/appengine-java-sdk
export JREBEL_PATH=$HOME/Library/jrebel/jrebel.jar
```

Run
---

Run sbt.

```bash
sbt
```

Start the development server.

```
appengineDevServer --port=8888
```

Deploy
------

Run sbt.

```bash
sbt
```

Start the development server.

```
appengineDeploy --oauth2
```

Structure
---------

* `src/main/scala/` - Scala sources of the product
* `src/test/scala/` - Scala sources of the test
* `static/public/` - Static files
* `static/target/` - Compiled assets
* `build.sbt` - Scala dependencies
* `appengine.sbt` - App Engine dependencies
* `scalate.sbt` - Scalate dependencies
* `target/webapp/` - (output) Web application to be run or deployed
