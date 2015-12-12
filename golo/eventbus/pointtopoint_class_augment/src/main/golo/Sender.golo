module eventbus.pointtopoint.Sender

import io.vertx.core.Vertx
import io.vertx.core.VertxOptions

import io.vertx.core.AbstractVerticle

augment AbstractVerticle{
	function start = |this|{
		let vertx = this:getVertx()
		let eb = vertx:eventBus()
    	 vertx:setPeriodic(1000,|v|{
	  		eb:send("ping-address","ping!",|reply|{
				if(reply:succeeded()){
					println("Received reply: " + reply:result():body())
				}else{
					println("No reply")
				}
			})
		})
	}
}


function main = |args|{
	Vertx.clusteredVertx(VertxOptions(),|res|{
		if res:succeeded() {
    		res:result():deployVerticle(AbstractVerticle())
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
