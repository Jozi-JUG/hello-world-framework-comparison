package org.acme;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionStage;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("/")
public class ReactiveGreetingResource {

    @GET
    public CompletionStage<String> demo() {
        return CompletableFuture.completedStage("Hello World");
    }
}
