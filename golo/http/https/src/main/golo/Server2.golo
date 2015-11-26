module https.Server2

import https.java.HttpServerOptionsProxy

import io.vertx.core.Vertx
import io.vertx.core.http.HttpServerOptions
import io.vertx.core.json.JsonObject

function main = |args|{
	let vertx = Vertx.vertx()
	let options = map[
		["ssl",true],
		["keyStoreOptions",map[
			["path","server-keystore.jks"],
			["password","wibble"]
		]]
	]
	let serverOptions1 = HttpServerOptions(JsonObject(options))	#should set correct server options (like ssl=true, etc.)
	#But in practice it does not work!
	#This is due to that the fact that contructor of HttpServerOptions is overloaded (it has two types of constructor with 1 argument [HttpServerOptions(HttpServerOptions other) and HttpServerOptions(JsonObject json)] - refer http://vertx.io/docs/apidocs/io/vertx/core/http/HttpServerOptions.html)
	println("Check if SSL is set for serverOptions1: serverOptions1.isSsl() = " + serverOptions1:isSsl()) #Comes out to be false!
	#UPDATE:Works fine! No errors and the above statement is evaluates to true!!
	vertx:createHttpServer(serverOptions1) :requestHandler(|req| -> req:
		response():
		putHeader("content-type","text/html"):
		end("<html><body><h1>Hello from vert.x!</h1></body></html>") 
	):listen(4442)



	#To overcome this problem we create a Java Proxy class of HttpServerOptions called HttpServerOptionsProxy. It has a single constructor which takes a JSON object and passes it to HttpServerOptions constructor. This is expected to work correctly, because the correct constructor will be called in the Java Proxy method.
	let serverOptions2 = HttpServerOptionsProxy(JsonObject(options)):getDelegate()
	println("Check if SSL is set for serverOptions2: serverOptions2.isSsl() = " + serverOptions2:isSsl()) #Expecting true...
	#But the result comes out to be false!!
	#No idea why!
	#UPDATE - This also started working! And the above statement is coming to be true (which was expected)
	vertx:createHttpServer(serverOptions2) :requestHandler(|req| -> req:
		response():
		putHeader("content-type","text/html"):
		end("<html><body><h1>Hello from vert.x!</h1></body></html>") 
	):listen(4443)
}