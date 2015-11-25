module sendFile.Server

import io.vertx.core.Vertx

function main = |args|{
	Vertx.vertx():createHttpServer():requestHandler(|req|{
		var filename = null
		if(req:path():equals("/")){
			filename="index.html"
		}else if(req:path():equals("/page1.html")){
			filename="page1.html"
		}else if(req:path():equals("/page2.html")){
			filename="page2.html"
		}else{
			req:response():setStatusCode(404):end()
		}
		if filename isnt null{
			req:response():sendFile(filename)
		}
	}):listen(8080)
}