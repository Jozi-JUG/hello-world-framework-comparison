package com.example

import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*

fun main() {
    embeddedServer(Netty, port = 9009) {
        routing {
            get ("/") {
                call.respondText("Hello World")
            }
        }
    }.start(wait = true)
}