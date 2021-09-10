package com.example

import com.example.plugins.configureRouting
import io.ktor.server.cio.*
import io.ktor.server.engine.*

fun main() {
    embeddedServer(CIO, port = 9010, host = "0.0.0.0") {
        configureRouting()
    }.start(wait = true)
}
