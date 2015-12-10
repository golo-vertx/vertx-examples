module net.Client

import io.vertx.core.Vertx
import io.vertx.core.net.NetSocket
import io.vertx.core.net.NetClient

function main = |args|{
	let vertx = Vertx.vertx()
	let client = vertx : createNetClient() : connect(1234, "localhost", |res| {
		if (res : succeeded()) {
			let socket = res : result()
			socket : handler(|buffer| {
				println("Net client receiving:" + buffer : toString("ISO-8859-1") )
			})

		# send some data
	 	for (var i = 0, i < 10, i = i + 1) {
    		let str = "hello " + i
    		println("Net client sending " + str)
    		socket : write()
  		}
		}else{
			println("Failed to connect " + res:cause()) 
		}
	}
}

