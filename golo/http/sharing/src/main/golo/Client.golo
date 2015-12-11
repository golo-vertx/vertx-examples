module https.Client

import io.vertx.core.Vertx
import io.vertx.core.http.HttpClientOptions

function main = |args|{
	let vertx = Vertx.vertx()
	let client = vertx : createHttpClient(
		HttpClientOptions():setSsl(true):setTrustAll(true)
	) 
	client : getNow(4443,"localhost","/",|resp|{
		println("Got response " + resp : statusCode())
		resp : bodyHandler(|body| ->
			println("Got data " + body : toString("ISO-8859-1"))
		)
	})
}