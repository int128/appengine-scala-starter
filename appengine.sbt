libraryDependencies += "org.mortbay.jetty" % "jetty" % "6.1.22" % "container"

appengineSettings

webappResources in Compile := Seq(baseDirectory.value / "static/target")
