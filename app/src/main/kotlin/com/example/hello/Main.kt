package com.example.hello

import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.plugins.micrometer.*
import io.micrometer.prometheus.*
import io.ktor.http.*

fun main() {

    val target = System.getenv("TARGET") ?: "World"
    val port = System.getenv("PORT") ?: "8080"

    // Prometheus registry
    val prometheusRegistry = PrometheusMeterRegistry(PrometheusConfig.DEFAULT)

    embeddedServer(Netty, port.toInt()) {

        // Instala o plugin Micrometer no Ktor
        install(MicrometerMetrics) {
            registry = prometheusRegistry
        }

        routing {

            // Endpoint raiz
            get("/") {
                call.respondText("Hello $target!")
            }

            // Liveness probe
            get("/health/live") {
                call.respondText("OK")
            }

            // Readiness probe
            get("/health/ready") {
                call.respondText("READY")
            }

            // Endpoint de métricas Prometheus
            get("/metrics") {
                call.respondText(
                    prometheusRegistry.scrape(),
                    ContentType.parse("text/plain; version=0.0.4")
                )
            }
        }
    }.start(wait = true)
}
