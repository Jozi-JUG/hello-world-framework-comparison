package com.example;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@EnableAutoConfiguration
public class Example {

    @GetMapping("/")
    String demo() {
        return "Hello World";
    }

    public static void main(String[] args) throws Exception {
        SpringApplication.run(Example.class, args);
    }

    // This is actually slower:
    @GetMapping("/nb")
    Mono<String> demoNonBlocking() {
        return Mono.just("Hello World");
    }
}
