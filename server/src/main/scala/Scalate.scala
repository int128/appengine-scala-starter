import java.io.File
import java.util.logging._
import javax.servlet.FilterConfig

import com.google.appengine.api.utils.SystemProperty
import org.fusesource.scalate.TemplateEngine
import org.fusesource.scalate.servlet.ServletResourceLoader
import services.Memcache
import unfiltered.response._

trait Scalate {
  def config: FilterConfig

  private lazy val logger = Logger.getLogger(getClass.getName)

  private lazy val engine = {
    val e = new TemplateEngine
    e.workingDirectory = new File("WEB-INF")
    e.resourceLoader = new ServletResourceLoader(config.getServletContext)
    e.allowReload = false
    e
  }

  private def render(path: String, params: Map[String, Any]) = {
    logger.info(s"Rendering the template: $path")
    engine.layout(path, params)
  }

  private def calculateCacheKey(path: String, extraKey: String) =
    s"$path.$extraKey.${SystemProperty.applicationVersion.get}"

  /**
   * Render the scala template.
   *
   * @param path path of the template
   * @param params parameters for the template
   */
  case class Scalate(path: String, params: Map[String, Any]) extends
    ComposeResponse(HtmlContent ~> ResponseString(render(path, params)))

  /**
   * Render the scala template with the cache support.
   * On first access, a rendered page will be stored on the cache with a key
   * which consists of path, extra key and deployed application version.
   *
   * @param path path of the template
   * @param params parameters for the template, called only if cache does not found
   * @param extraKey an extra key for caching, defaults to empty string
   */
  case class CachedScalate(path: String, params: () => Map[String, Any], extraKey: String = "") extends
    ComposeResponse(HtmlContent ~> ResponseString(
      Memcache.getOrValue(calculateCacheKey(path, extraKey), render(path, params()))))
}
