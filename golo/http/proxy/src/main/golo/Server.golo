module proxy.Server

import io.vertx.core.Vertx

function main = |args|{
	let vertx = Vertx.vertx()
	vertx:createHttpServer():requestHandler(|req|{
		println("Got request " + req:uri())
		foreach name in req:headers():names(){
			println(name + ": " +req:headers():get(name))
		}
		req:handler(|data| -> println("Got data " + data:toString("ISO-8859-1")))
		req:endHandler(|v|{
			req:response():setChunked(true)
			for(var i=0, i<10, i = i+1){
				req:response():write("server-data-chunk-"+i)
			}
			req:response():end()
		})
	}):listen(8282)
}
