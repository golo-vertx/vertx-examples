module http.upload.Client

import io.vertx.core.Vertx
import io.vertx.core.streams.Pump
import io.vertx.core.http.HttpClientOptions
import io.vertx.core.file.OpenOptions

function main = |args|{
	let vertx = Vertx.vertx()
	let req = vertx : createHttpClient( HttpClientOptions()
		):put(8080, "localhost", "/someurl", |resp|{
			println("response:" + resp:statusCode())
			})

	let filename = "upload.txt"
	let fs = vertx:fileSystem()

	fs:props(filename, |ares| {
		let props = ares : result()
		println("props is " + props)
		let size = props:size()
		req:headers(): set("content-length", java.lang.String.valueOf(size))
		fs:open(filename, OpenOptions(), |ares2|{
			let file = ares2:result()
			let pump = Pump.pump(file, req)
			file : endHandler(|v|{
				req:end()
			})
			pump : start()
		})
	})

}
