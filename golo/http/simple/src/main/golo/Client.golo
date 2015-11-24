module simple.Client

import io.vertx.groovy.core.Vertx

function main = |args|{
	let vertx = Vertx.vertx()
	vertx : createHttpClient() : getNow(8080,"localhost","/",|resp|{
		println("Got response " + resp : statusCode())
		resp : bodyHandler(|body| ->
			println("Got data " + body : toString("ISO-8859-1"))
		)
	})
}