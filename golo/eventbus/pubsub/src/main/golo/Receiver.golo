module eventbus.pubsub.Receiver

import io.vertx.core.Vertx
import io.vertx.core.VertxOptions

function main = |args|{
	Vertx.clusteredVertx(VertxOptions(),|res|{
		if res:succeeded() {
    		let vertx = res:result()
    	 	let eb = vertx:eventBus()
    	 	eb:consumer("news-feed",|message| -> 
				println("Received news: " + message:body())
			)
			println("Ready!")
  		} else {
    		println("Failed: " + res:cause())
  		}
	})
}
