package services

import java.util.logging.Level

import com.google.appengine.api.memcache._

object Memcache {
  private lazy val memcacheService = {
    val s = MemcacheServiceFactory.getMemcacheService
    s.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO))
    s
  }

  def get[T](key: String): Option[T] =
    Option(memcacheService.get(key).asInstanceOf[T])

  def put[T](key: String, value: T): T = {
    memcacheService.put(key, value)
    value
  }

  def put[T](key: String, value: T, expiration: Expiration): T = {
    memcacheService.put(key, value, expiration)
    value
  }

  def delete(key: String) = memcacheService.delete(key)

  def increment(key: String): Long = memcacheService.increment(key, 1)

  /**
   * Get the cached entry or calculate the value.
   *
   * @param key cache key
   * @param value cache value, evaluated only if cache does not found
   * @tparam T type of the value
   * @return cached entry or calculated value
   */
  def getOrValue[T](key: String, value: => T): T =
    get(key) match {
      case Some(cached) => cached
      case None => put(key, value)
    }
}
