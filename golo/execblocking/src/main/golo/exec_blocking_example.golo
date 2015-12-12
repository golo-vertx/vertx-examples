module execblocking.example

import io.vertx.core.Vertx
import java.lang.Thread

function main = |args|{
	let vertx = Vertx.vertx()
	vertx : createHttpServer(): requestHandler(|request|{
			# Let's say we have to call a blocking API (e.g. JDBC) to execute a query for each
			# request. We can't do this directly or it will block the event loop
			# But you can do this using executeBlocking:

			vertx:executeBlocking(|future|{
				# Do the blocking operation in here
				# Imagine this was a call to a blocking API to get the result
				try{
					java.lang.Thread.sleep(500)
				}catch(e){
					e: printStackTrace()
				}
				let result  = "armadillos!"
				future:complete(result)
				}, |res|{
					if (res:succeeded()){
						request:response():putHeader("content-type", "text/plain"):end(res:result())
					}else{
						res:cause():printStackTrace()
					}

			})
		}):listen(8080)		
}
