import io.vertx.groovy.core.Vertx

def options = [:]
Vertx.clusteredVertx(options, {res->
  if (res.succeeded()) {
    def vertx = res.result()
    def eb = vertx.eventBus()
    //println("success in clustering")
    println("We now have a clustered event bus: ${eb}")
    eb.consumer("ping-address", { message ->
	  println("Received message: ${message.body()}")
	  // Now send back reply
	  message.reply("pong!")
	})
    println("Receiver ready!")
  } else {
    println("Failed: ${res.cause()}")
  }
})
