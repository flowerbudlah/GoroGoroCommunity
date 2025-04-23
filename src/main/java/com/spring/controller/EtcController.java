package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/etc")
public class EtcController {

	// 1. writing Interceptor: A function that prevents access by anyone other than the writer. 
	@RequestMapping("/notWriter")
	public String notWriter() {
		return "etc/notWriter";
	}

	// 2. entering Interceptor: An interceptor that prevents non-administrators from entering the administrator Only page. 
	@RequestMapping("/notAdmin")
	public String notAdmin() {
		return "etc/notAdmin";
	}

}