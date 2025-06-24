package com.spring.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.servlet.HandlerInterceptor;

import com.spring.dto.MemberDTO;
import com.spring.dto.PostDTO;
import com.spring.service.BoardService;

public class DeleteInterceptor implements HandlerInterceptor {

	@Resource(name = "signInMemberDTO")
	private @Lazy MemberDTO signInMemberDTO;

	@Autowired
	private BoardService boardService;

	// Checking if the person who signed in and the person who wrote the post are the same, 
	// This Interceptor will only react when deleting a post.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		int postNo = Integer.parseInt(request.getParameter("postNo"));
		PostDTO tmpPostDTO = boardService.read(postNo);

		// 글쓴사람이랑 로그인을 한 사람이 같으면, 또는 관리자라면 
		// If the person who logged in is the writer or administrator
		if ((tmpPostDTO.getWriter().equalsIgnoreCase(signInMemberDTO.getNick()))
				|| (signInMemberDTO.getMemberNo() == 1)) {
			
			return true;
			
		} else {

			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath + "/etc/notWriter");
			return false;
		
		}

	}

}
