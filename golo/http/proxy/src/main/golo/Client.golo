module proxy.Client

import io.vertx.core.Vertx

function main = |args|{
	let request = Vertx.vertx():createHttpClient():put(8080,"localhost","/",|resp|{
			println("Got response " + resp:statusCode())
			resp:bodyHandler(|body| -> println("Got data " + body:toString("ISO-8859-1")))
	})
	request:setChunked(true)
	for(var i = 0, i < 10, i=i+1){
		request:write("client-chunk-"+i)
	}
	request:end()
}
