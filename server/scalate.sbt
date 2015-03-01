import com.mojolly.scalate.ScalatePlugin.ScalateKeys._

libraryDependencies ++= Seq(
  "org.fusesource.scalate" % "scalate-core_2.10" % "1.6.1",
  "org.slf4j" % "slf4j-jdk14" % "1.7.7"
)

Seq(scalateSettings: _*)

scalateTemplateConfig in Compile <<= (sourceDirectory in Compile) { base =>
  Seq(
    TemplateConfig(base / "../../../client/target/webapp", Seq(), Seq(), Some(""))
  )
}
