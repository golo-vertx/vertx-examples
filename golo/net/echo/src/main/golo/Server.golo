module net.Server

import io.vertx.core.streams.Pump
import io.vertx.core.Vertx

function main = |args|{
	let vertx = Vertx.vertx()
	vertx : createNetServer() : connectHandler(|sock| {
		#create a pump
		Pump.pump(sock, sock) : start()
	}) : listen(1234)
	println("Echo server is now listening")

}

