import java.io.File
import javax.servlet.FilterConfig
import org.fusesource.scalate.servlet.ServletResourceLoader
import org.fusesource.scalate.TemplateEngine
import unfiltered.response._

trait Scalate {
  private lazy val engine = {
    val e = new TemplateEngine
    e.workingDirectory = new File("WEB-INF")
    e.resourceLoader = new ServletResourceLoader(config.getServletContext)
    e.allowReload = false
    e
  }

  def config: FilterConfig

  def Scalate(path: String, params: Map[String, Any]) =
    HtmlContent ~> ResponseString(engine.layout(path, params))
}
