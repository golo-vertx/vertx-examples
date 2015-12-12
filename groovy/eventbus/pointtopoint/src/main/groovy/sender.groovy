import io.vertx.groovy.core.Vertx

def options = [:]
Vertx.clusteredVertx(options, {res->
  if (res.succeeded()) {
    def vertx = res.result()
    def eb = vertx.eventBus()
    //println("success in clustering")
    println("We now have a clustered event bus: ${eb}")
    vertx.setPeriodic(1000, { v ->
  		eb.send("ping-address", "ping!", {reply->
    		if (reply.succeeded()) {
    	  		println("Received reply: ${reply.result().body()}")
    		} else {
      			println("No reply")
    		}
  		})
  	})
  } else {
    println("Failed: ${res.cause()}")
  }
})
