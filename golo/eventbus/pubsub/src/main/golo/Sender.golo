module eventbus.pubsub.Sender

import io.vertx.core.Vertx

function main = |args|{
	let vertx = Vertx.vertx()
	let eb = vertx:eventBus()
	vertx:setPeriodic(1000,|v|{
		eb:publish("news-feed","Some news!")
	})
}