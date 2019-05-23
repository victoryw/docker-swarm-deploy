package com.example.demo

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpStatus
import org.springframework.web.reactive.function.BodyInserters.fromObject
import org.springframework.web.reactive.function.server.RouterFunction
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.router
import reactor.core.publisher.Mono
import java.io.File

@SpringBootApplication
class DemoApplication

fun main(args: Array<String>) {
    runApplication<DemoApplication>(*args)
}

@Configuration
class SimpleRoute {
    @Bean
    fun route(): RouterFunction<ServerResponse> {
        return router {
            GET("/route") { _ -> mono() }
        }
    }

    private fun mono(): Mono<ServerResponse> {
        val env = System.getenv()

        val value = env!!["secret"]
        return when (value) {
            null ->
                ServerResponse.status(HttpStatus.INTERNAL_SERVER_ERROR).build()
            else -> ServerResponse.ok().body(fromObject(value))
        }
    }
}
