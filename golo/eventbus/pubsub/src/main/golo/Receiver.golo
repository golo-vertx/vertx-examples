module eventbus.pubsub.Receiver

import io.vertx.core.Vertx

function main = |args|{
	let vertx = Vertx.vertx()
	let eb = vertx:eventBus()

	let msgConsumer = eb:consumer("news-feed",|message| -> 
		println("Received news: " + message:body())
	)
	msgConsumer:completionHandler(|res|{
		if res:succeeded(){
			println("Handler has receached all nodes.")
		}else{
			println("Registration failed.")
		}

	})
	println("Ready!")

}