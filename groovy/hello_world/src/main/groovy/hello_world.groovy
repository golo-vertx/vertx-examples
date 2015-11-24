import io.vertx.groovy.core.Vertx

def vertx = Vertx.vertx()

vertx.createHttpServer().requestHandler({ req ->
  req.response()
    .putHeader("content-type", "text/plain")
    .end("Hello from Vert.x!")
}).listen(8080)
