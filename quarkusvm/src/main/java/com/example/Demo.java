package com.example;/*
 * Copyright (C) Jini Guru Technologies (Mauritius) Limited - Company No. : 154309 - All Rights Reserved Unauthorized copying of
 * this file or any of its contents, via any medium is strictly prohibited Proprietary and confidential
 */


import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionStage;
import javax.enterprise.context.ApplicationScoped;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 * @author Maven
 */
@ApplicationScoped
@Path("/")
public class Demo {

    @GET
    public CompletionStage<String> demo() {
        return CompletableFuture.completedStage("Hello World");
    }
    

}
