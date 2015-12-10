module eventbus.pointtopoint.Receiver

import io.vertx.core.Vertx

function main = |args|{
	let vertx = Vertx.vertx()
	let eb = vertx:eventBus()
	eb:consumer("ping-address",|message|{
		println("Received message: " + message.body())
		message.reply("pong!")
	})
	println("Receiver ready!")
}