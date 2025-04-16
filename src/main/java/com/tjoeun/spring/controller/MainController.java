package com.tjoeun.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.service.MainService;

@Controller
public class MainController {

	@Autowired
	private MainService mainService;

	@RequestMapping("/main")
	public String main(Model model) {

		// 홈페이지 첫 메인화면에 뜨는 공지사항 게시글 리스트
		List<PostDTO> postList = mainService.getMainList();
		model.addAttribute("postList", postList);
		return "main";
	}

}
