module proxy.Proxy

import io.vertx.core.Vertx

function main = |args|{
	let client = Vertx.vertx():createHttpClient()
	Vertx.vertx():createHttpServer():requestHandler(|req|{
		let c_req = client:request(req:method(),8282,"localhost",req:uri(),|c_res|{
			println("Proxying response: "+c_res:statusCode())
			req:response():setChunked(true)
			req:response():setStatusCode(c_res:statusCode())
			req:response():headers():setAll(c_res:headers())
			c_res:handler(|data|{
				println("Proxying response body: "+data:toString("ISO-8859-1"))
				req:response():write(data)
			})
			c_res:endHandler(|v| -> req:response():end())
		})
		c_req:setChunked(true)
		c_req:headers():setAll(req:headers())
		req:handler(|data|{
			println("Proxying request body " + data:toString("ISO-8859-1"))
			c_req:write(data)
		})
		req:endHandler(|v|->c_req:end())
	}):listen(8080)
}
