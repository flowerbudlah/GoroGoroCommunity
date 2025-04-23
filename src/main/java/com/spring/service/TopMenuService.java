package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dao.TopMenuDAO;
import com.spring.dto.BoardDTO;
import com.spring.dto.CategoryDTO;

@Service
public class TopMenuService {

	@Autowired
	private TopMenuDAO topMenuDAO;

	// 1. 카테고리(게시판 대분류) 가져오기
	public List<CategoryDTO> getCategoryList() {
		List<CategoryDTO> CategoryList = topMenuDAO.getCategoryList();
		return CategoryList;
	}

	// 2. 카테고리(게시판 대분류)에 속한 게시판 가져오기
	public List<BoardDTO> getBoardList() {
		List<BoardDTO> boardList = topMenuDAO.getBoardList();
		return boardList;
	}

}
