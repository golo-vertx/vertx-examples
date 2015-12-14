module eventbus.pubsub.Sender

import io.vertx.core.Vertx
import io.vertx.core.VertxOptions

function main = |args|{
	Vertx.clusteredVertx(VertxOptions():setClustered(true),|res|{
		if res:succeeded() {
    		let vertx = res:result()
    	 	let eb = vertx:eventBus()
    	 	vertx:setPeriodic(1000,|v|{
	  			eb:publish("news-feed","Some news!")
			})
  		} else {
    		println("Failed: " + res:cause())
  		}
	})
}
