package com.example.Hallen;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class HallenApplication {

	public static void main(String[] args) {
		SpringApplication.run(HallenApplication.class, args);
	}

}
