import io.vertx.groovy.core.Vertx

def vertx = Vertx.vertx()

def server = vertx.createHttpServer([
  "ssl":true,
  "keyStoreOptions":[
    "path":"server-keystore.jks",
    "password":"wibble"
  ]
])

server.requestHandler({ req ->
  req.response().putHeader("content-type", "text/html").end("<html><body><h1>Hello from vert.x!</h1></body></html>")
}).listen(4443)
