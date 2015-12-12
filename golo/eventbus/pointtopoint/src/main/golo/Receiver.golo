module eventbus.pointtopoint.Receiver

import io.vertx.core.Vertx
import io.vertx.core.VertxOptions

function main = |args|{
	Vertx.clusteredVertx(VertxOptions(),|res|{
		if res:succeeded() {
    		let vertx = res:result()
    	 	let eb = vertx:eventBus()
    	 	eb:consumer("ping-address",|message|{
				println("Received message: " + message:body())
				message:reply("pong!")
			})
			println("Receiver ready!")
  		} else {
    		println("Failed: " + res:cause())
  		}
	})


	#let vertx = Vertx.vertx()
	#let eb = vertx:eventBus()
	#let msgConsumer = eb:consumer("ping-address",|message|{
	#	println("Received message: " + message.body())
	#	message.reply("pong!")
	#})
	#msgConsumer:completionHandler(|res|{
	#	if res:succeeded(){
	#		println("Handler has receached all nodes.")
	#	}else{
	#		println("Registration failed.")
	#	}

	#})
	#println("Receiver ready!")
}
