package micronaut.example;


import io.micronaut.http.MediaType;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionStage;


@Controller("/")
public class MessageController {

    
    @Get(value = "/", produces = MediaType.TEXT_PLAIN)
    CompletionStage<String> hello() {
        return CompletableFuture.completedStage("Hello World");
    }
}
