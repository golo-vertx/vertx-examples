#Progress
##Able to use groovy API in golo
We were able to direclty run the groovy API in golo with any problems (well eventually).  
It also solved the problem of passing server options as a golo map (instead of a Java Object).
###Code
[src/main/golo/ServerGroovy.golo](https://github.com/golo-vertx/vertx-examples/blob/experimental/golo/http/https/src/main/golo/ServerGroovy.golo)
###Usage
1. Run the HTTPS server using `./gradlew runGroovyServer`
2. Test the server using either of the following options:
..* Using curl - run `curl --insecure https://localhost:4443`
..* Using golo client - run `./gradlew runClient`

##Golo is able to select correct method in case of overloaded methods with the same number of parameter
This may be sheer coincidence!  
As discussed constructor [io.vertx.core.http.HttpServerOptions](http://vertx.io/docs/apidocs/io/vertx/core/http/HttpServerOptions.html) is overloaded. It has two types of constructor with exactly 1 argument [`HttpServerOptions(HttpServerOptions other)` and `HttpServerOptions(JsonObject json)`]. So passing a JSON object to `HttpServerOptions`'s constructor from golo should not work. But it is working right now!
###Code
[src/main/golo/Server2.golo](https://github.com/golo-vertx/vertx-examples/blob/experimental/golo/http/https/src/main/golo/Server2.golo)
###Usage
Run the server using `./gradlew runServer2` 
