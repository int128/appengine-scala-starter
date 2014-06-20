import java.util.logging.Level

import com.google.appengine.api.memcache._

trait Memcache {
  private lazy val memcacheService = {
    val s = MemcacheServiceFactory.getMemcacheService
    s.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO))
    s
  }

  /**
   * Get the cached entry or calculate the value.
   *
   * @param key cache key
   * @param value cache value, evaluated only if cache does not found
   * @tparam T type of the value
   * @return cached entry or calculated value
   */
  def getCacheOrValue[T](key: String, value: => T): T =
    memcacheService.get(key) match {
      case null =>
        val evaluated = value
        memcacheService.put(key, evaluated)
        evaluated

      case cached => cached.asInstanceOf[T]
    }
}
