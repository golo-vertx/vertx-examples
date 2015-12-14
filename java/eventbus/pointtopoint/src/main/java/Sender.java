package eventbus.pointtopoint;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.eventbus.EventBus;
import io.vertx.core.Vertx;
import io.vertx.core.VertxOptions;

/*
 * @author <a href="http://tfox.org">Tim Fox</a>
 */
public class Sender extends AbstractVerticle {

  public static void main(String[] args) {
    Vertx.clusteredVertx(new VertxOptions(),res->{
      if(res.succeeded()){
        res.result().deployVerticle(new Sender());
      }
    });
  }

  @Override
  public void start() throws Exception {
    EventBus eb = vertx.eventBus();
    vertx.setPeriodic(1000, v -> {
      eb.send("ping-address", "ping!", reply -> {
        if (reply.succeeded()) {
          System.out.println("Received reply: " + reply.result().body());
        } else {
          System.out.println("No reply");
        }
      });

    });
  }
}