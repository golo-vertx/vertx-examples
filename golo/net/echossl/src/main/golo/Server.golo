module net.echossl.Server

import io.vertx.core.streams.Pump
import io.vertx.core.Vertx
import io.vertx.core.net.NetServerOptions
import io.vertx.core.net.JksOptions

function main = |args|{
	let vertx = Vertx.vertx()
	let server = vertx : createNetServer(
			NetServerOptions():setSsl(true):setKeyStoreOptions(
			JksOptions():setPath("server-keystore.jks"):setPassword("wibble")
		))
	server : connectHandler(|sock| {
		#create a pump
		Pump.pump(sock, sock) : start()
	}) : listen(1234)
	println("Echo server is now listening")

}

