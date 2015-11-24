module simple.Server

import io.vertx.core.Vertx

function main = |args|{
	let vertx = Vertx.vertx()
	vertx : createHttpServer() : requestHandler(|req| -> req:
		response():
		putHeader("content-type","text/html"):
		end("<html><body><h1>Hello from vert.x!</h1></body></html>") 
	) : listen(8080)
}