package com.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.dto.PostDTO;
import com.spring.service.MainService;

@Controller
public class MainController {

	@Autowired
	private MainService mainService;

	// 이 사이트에 접속했을때 처음에 뜨는 화면 (The main page that appears when user access this site at first.)
	@RequestMapping("/main")
	public String main(Model model) {

		// 홈페이지 첫 메인화면에 뜨는 공지사항 게시글 리스트 (List of notice posts that appear on The site's main.)
		List<PostDTO> postList = mainService.getMainList();
		model.addAttribute("postList", postList);
		return "main";
	}
}