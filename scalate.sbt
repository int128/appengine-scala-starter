import com.mojolly.scalate.ScalatePlugin.ScalateKeys._

libraryDependencies += "org.fusesource.scalate" % "scalate-core_2.10" % "1.6.1"

Seq(scalateSettings: _*)

scalateTemplateConfig in Compile <<= (sourceDirectory in Compile) { base =>
  Seq(
    TemplateConfig(base / "webapp", Seq(), Seq(), Some(""))
  )
}
