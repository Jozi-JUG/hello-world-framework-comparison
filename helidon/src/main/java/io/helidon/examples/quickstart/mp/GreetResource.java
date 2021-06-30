
package io.helidon.examples.quickstart.mp;

import javax.enterprise.context.ApplicationScoped;

import javax.json.JsonObject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 * A simple JAX-RS resource to greet you. Examples:
 *
 * Get default greeting message:
 * curl -X GET http://localhost:8080/greet
 *
 * Get greeting message for Joe:
 * curl -X GET http://localhost:8080/greet/Joe
 *
 * Change greeting
 * curl -X PUT -H "Content-Type: application/json" -d '{"greeting" : "Howdy"}' http://localhost:8080/greet/greeting
 *
 * The message is returned as a JSON object.
 */
@Path("/")
@ApplicationScoped
public class GreetResource {


    /**
     * Return a worldly greeting message.
     *
     * @return {@link JsonObject}
     */
    @GET
    public String getDefaultMessage() {
        return "Hello World";
    }

}
