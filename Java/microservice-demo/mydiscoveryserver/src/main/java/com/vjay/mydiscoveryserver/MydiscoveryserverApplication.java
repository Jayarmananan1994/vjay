package com.vjay.mydiscoveryserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class MydiscoveryserverApplication {

	public static void main(String[] args) {
		SpringApplication.run(MydiscoveryserverApplication.class, args);
	}

}
