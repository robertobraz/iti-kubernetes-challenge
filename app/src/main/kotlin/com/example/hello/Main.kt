package com.example.hello

import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun main() {
    val target = System.getenv("TARGET") ?: "World"
    val port = System.getenv("PORT") ?: "8080"
    
    embeddedServer(Netty, port.toInt()) {
        routing {
            get("/") {
                call.respondText("Hello $target!")
		//call.respondText("Hello from Docker!")
            }
        }
    }.start(wait = true)
}
