module eventbus.pointtopoint.Sender

import io.vertx.core.Vertx
import io.vertx.core.VertxOptions
import io.vertx.core.eventbus.DeliveryOptions


function main = |args|{
	let delOpts = DeliveryOptions():addHeader("sent-by","tester"): 	setSendTimeout(1000)
	let replyHandler = |reply|{
		if(reply:succeeded()){
			println("Received reply: " + reply:result():body())
		}else{
			println("No reply")
		}
	} 

	Vertx.clusteredVertx(VertxOptions(),|res|{
		if res:succeeded() {
    		let vertx = res:result()
    	 	let eb = vertx:eventBus()
    	 	vertx:setPeriodic(1000,|v|{
	  			eb:send("reply-handler-ping-address","normal-ping!",replyHandler)
	  			eb:send("test-golo-overloading-ping-address","overloading-test-ping",delOpts)
			})
  		} else {
    		println("Failed: " + res:cause())
  		}
	})

	#let vertx = Vertx.vertx()
	#let eb = vertx:eventBus()
	#vertx:setPeriodic(1000,|v|{
	#	eb:send("ping-address","ping!",|reply|{
	#		if(reply:succeeded()){
	#				println("Received reply" + reply:resut():body())
	#		}else{
	#			println("No reply")
	#		}
	#	})
	#})
	#eb:consumer("ping-address",|message|{
	#	println("Received message: " + message.body())
	#	message.reply("pong!")
	#})
	#println("Receiver ready!")

}
