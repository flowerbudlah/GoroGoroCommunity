package com.spring.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dao.BoardDAO;
import com.spring.dto.PostDTO;

@Service
public class MainService {

	@Autowired
	private BoardDAO boardDAO;

	public List<PostDTO> getMainList() {
		
		// 게시물은 3개만 등장(사이트 메인화면에 등장하는 공지사항 게시판의 경우, 메인화면에는 3개의 게시물만 등장하도록 한다. )
		RowBounds rowBounds = new RowBounds(0, 3);

		// 즉, BoardNo=1 공지사항만 등장
		List<PostDTO> postList = boardDAO.goMain(1, rowBounds);

		return postList;
	}

}
