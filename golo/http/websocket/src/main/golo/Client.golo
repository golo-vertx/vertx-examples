module http.websockets.Client

import io.vertx.core.Vertx
import io.vertx.core.buffer.Buffer


function main = |args|{
	let vertx = Vertx.vertx()
	let client = vertx : createHttpClient()

	client:websocket(8080,"localhost","/someurl", |websocket|{
		websocket:handler(|data|{
			println("Received data" + data:toString("ISO-8859-1"))
			client.close()
			})
			#websocket:writeBinaryMessage(Buffer.buffer("Hello world"))
		})
	
}