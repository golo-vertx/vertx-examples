import io.vertx.groovy.core.Vertx

def vertx = Vertx.vertx()

vertx.createHttpClient([
  "ssl":true,
  "trustAll":true
]).getNow(4443, "localhost", "/", { resp ->
  println("Got response ${resp.statusCode()}")
  resp.bodyHandler({ body ->
    println("Got data ${body.toString("ISO-8859-1")}")
  })
})
