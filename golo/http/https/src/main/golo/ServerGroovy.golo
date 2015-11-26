module https.groovy.Server

import io.vertx.groovy.core.Vertx

function main = |args|{
	let vertx = Vertx.vertx()
	let options = map[
		["port",4443],
		["ssl",true],
		["keyStoreOptions",map[
			["path","server-keystore.jks"],
			["password","wibble"]
		]]
	]
	let server = vertx:createHttpServer(options)
	server:requestHandler(|req| -> req:
		response():
		putHeader("content-type","text/html"):
		end("<html><body><h1>Hello from vert.x!</h1></body></html>") 
	):listen()
	#UPDATE - works perfectly!
}