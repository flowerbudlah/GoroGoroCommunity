package com.spring.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.spring.dto.BoardDTO;
import com.spring.dto.CategoryDTO;
import com.spring.service.TopMenuService;

public class TopMenuInterceptor implements HandlerInterceptor {

	@Autowired
	private TopMenuService topMenuService;

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 카테고리들 (Board's Category list)
		List<CategoryDTO> CategoryList = topMenuService.getCategoryList();
		request.setAttribute("CategoryList", CategoryList);
		
		// 카테고리에 속해있는 게시판들 (Board's List that belong to Category)
		List<BoardDTO> BoardList = topMenuService.getBoardList(); 
		request.setAttribute("BoardList", BoardList);

		return true;
	}

}