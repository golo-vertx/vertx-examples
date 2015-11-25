module https.Server

import io.vertx.core.Vertx
import io.vertx.core.http.HttpServerOptions
import io.vertx.core.net.JksOptions

function main = |args|{
	let vertx = Vertx.vertx()
	let server = vertx : createHttpServer(
		HttpServerOptions():setSsl(true):setKeyStoreOptions(
			JksOptions():setPath("server-keystore.jks"):setPassword("wibble")
		)
	)
	server : requestHandler(|req| -> req:
		response():
		putHeader("content-type","text/html"):
		end("<html><body><h1>Hello from vert.x!</h1></body></html>") 
	) : listen(4443)
}