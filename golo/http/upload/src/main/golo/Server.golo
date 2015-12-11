module http.upload.Server

import io.vertx.core.streams.Pump
import io.vertx.core.Vertx
import io.vertx.core.file.OpenOptions

import java.util.UUID

function main = |args|{
	let vertx = Vertx.vertx()
	vertx : createHttpServer() : requestHandler(|req| {

		req: pause()
		let filename = UUID.randomUUID() + ".uploaded"
		vertx: fileSystem() : open(filename, OpenOptions(), |ares|{
			let file = ares:result()
			let pump = Pump.pump(req, file)
			req:endHandler(|v1|{
				file:close(|v2|{
					println("uploaded to" + filename)
					req:response():end()
				})
			})
			pump : start()
			req :resume()
		})
	}) : listen(8080)
}

