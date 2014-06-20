App Engine Blank Project
========================

Template project of App Engine application.


How to use
----------

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

Then, invoke sbt and start a development server.

```
$ sbt

> appengineDevServer
```


Architecture
------------

This project contains following:

  * Scala 2.10
  * Unfiltered filter
  * Scalate
    * Scalate cache support
    * Scalate generating support with xsbt-scalate-generator
  * App Engine support with sbt-appengine

