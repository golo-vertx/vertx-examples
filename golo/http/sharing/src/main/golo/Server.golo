module https.sharing.Server

import io.vertx.core.Vertx
import io.vertx.example.core.http.sharing.HttpServerVerticle

function main = |args|{
	let vertx = Vertx.vertx()
	vertx:deployVerticle("io.vertx.example.core.http.sharing.HttpServerVerticle")
}

