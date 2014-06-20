libraryDependencies += "org.mortbay.jetty" % "jetty" % "6.1.22" % "container"

libraryDependencies ++= Seq(
"com.google.appengine" % "appengine-api-1.0-sdk" % "1.9.6",
"com.google.appengine" % "appengine-api-labs" % "1.9.6"
)

appengineSettings
