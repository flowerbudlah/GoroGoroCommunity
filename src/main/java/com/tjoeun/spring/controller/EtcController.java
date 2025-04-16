package com.tjoeun.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/etc")
public class EtcController {

	// 1. 해당 글의 글쓴이가 아니면 입장이 불가능한 인터셉터 (Interceptor)
	@RequestMapping("/notWriter")
	public String notWriter() {
		return "etc/notWriter";
	}

	// 2. 로그인을 한 뒤에 관리자가 아닌 사람이 관리자 페이지에 들어가는 경우 입장이 불가능한 인터셉터 (Interceptor)
	@RequestMapping("/notAdmin")
	public String notAdmin() {
		return "etc/notAdmin";
	}

}
