module http.simpleform.Server

import io.vertx.core.Vertx
import io.vertx.core.http


function main = |args|{
	let vertx = Vertx.vertx()
	vertx:createHttpServer():requestHandler(|req|{
			if (req:uri() == "/"){
				# serve the index page
				req:response():sendFile("index.html")
			} else if (req:uri():startsWith("/form")){
				req:response():setChunked(true)
				req:setExpectMultipart(true)
				req:endHandler(|v|{
					foreach attr in req:formAttributes():names() {
   						req:response():write("Got attr" +attr + ":" + req:formAttributes():get(attr) +"\n")
  					}
 					req:response():end()					
					})
			}else{
				req:response():setStatusCode(404):end()
			}
		}):listen(8080)
}
