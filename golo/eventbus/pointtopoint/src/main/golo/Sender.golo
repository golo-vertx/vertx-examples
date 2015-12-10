module eventbus.pointtopoint.Sender

import io.vertx.core.Vertx

function main = |args|{
	let vertx = Vertx.vertx()
	let eb = vertx:eventBus()
	vertx:setPeriodic(1000,|v|{
		eb:send("ping-address","ping!",|reply|{
			if(reply:succeeded()){
				println("Received reply" + reply:resut():body())
			}else{
				println("No reply")
			}
		})
	})
	#eb:consumer("ping-address",|message|{
	#	println("Received message: " + message.body())
	#	message.reply("pong!")
	#})
	#println("Receiver ready!")

}
