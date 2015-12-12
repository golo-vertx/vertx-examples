module http.websockets.Server

import io.vertx.core.Vertx
import io.vertx.core.http


function main = |args|{
	let vertx = Vertx.vertx()
	vertx:createHttpServer():websocketHandler(|ws|{
			ws:handler(^ws::writeBinaryMessage)
		}):requestHandler(|req|{
			if (req:uri() == "/"){
				req:response():sendFile("ws.html")
			}
			}):listen(8080)
	
}
