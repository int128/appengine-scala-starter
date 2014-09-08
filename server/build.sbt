name := "sbt-appengine-blank"

version := "1.0"

scalaVersion := "2.10.3"

libraryDependencies ++= Seq(
  "javax.servlet" % "servlet-api" % "2.5" % "provided",
  "net.databinder" %% "unfiltered-filter" % "0.8.0",
  "org.json4s" %% "json4s-native" % "3.2.9"
)
