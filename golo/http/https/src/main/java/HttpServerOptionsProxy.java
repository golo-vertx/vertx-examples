package https.java;

import io.vertx.core.http.HttpServerOptions;
import io.vertx.core.json.JsonObject;

public class HttpServerOptionsProxy{
	private final HttpServerOptions delegate;
	private JsonObject jo;
	public HttpServerOptionsProxy(JsonObject json){
		//System.out.println("Trying to create HttpServerOptions with options:\n" + json); //we get the correct json => golo passed json object as argument correctly. Now it is upto the Java constructor to work correctly!
		this.delegate = new HttpServerOptions(json);
		//System.out.println("Is SSL true - " + delegate.isSsl());
		//delegate.setSsl(true); //comes out to be false
		//System.out.println("Is SSL true 2nd time- " + delegate.isSsl());
		//UPDATE - Above two lines are evaluating to true!
	}
	public HttpServerOptions getDelegate(){
		return delegate;
	}
};