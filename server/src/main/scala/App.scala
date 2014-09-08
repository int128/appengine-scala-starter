import unfiltered.request._
import unfiltered.response._

class App extends unfiltered.filter.Plan {
  def intent = {
    case GET(Path("/")) => ResponseString("Hello")
  }
}
