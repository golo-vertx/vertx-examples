package eventbus.pointtopoint;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.eventbus.EventBus;
import io.vertx.core.Vertx;
import io.vertx.core.VertxOptions;

/*
 * @author <a href="http://tfox.org">Tim Fox</a>
 */
public class Receiver extends AbstractVerticle {

  public static void main(String[] args) {
    Vertx.clusteredVertx(new VertxOptions(),res->{
      if(res.succeeded()){
        res.result().deployVerticle(new Receiver());
      }
    });
  }

  @Override
  public void start() throws Exception {
    EventBus eb = vertx.eventBus();
    eb.consumer("ping-address", message -> {
      System.out.println("Received message: " + message.body());
      // Now send back reply
      message.reply("pong!");
    });

    System.out.println("Receiver ready!");
  }
}