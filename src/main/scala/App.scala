import org.json4s.JsonDSL._
import org.json4s.native.JsonMethods._
import services._
import unfiltered.request._
import unfiltered.response._

class App extends unfiltered.filter.Plan {

  def intent = {
    case GET(Path("/like")) =>
      JsonContent ~>
        JsonResponse(
          // TODO: get from the datastore
          "count" -> Memcache.getOrValue("like", 0L)
        )

    case POST(Path("/like")) =>
      JsonContent ~>
        JsonResponse(
          // TODO: persist to the datastore
          "count" -> Memcache.increment("like")
        )
  }

  object JsonResponse {
    import org.json4s.JsonAST.JValue

    def apply(json: JValue) = ResponseString(compact(render(json)))
  }

}
