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

// 글쓴이만 자기가 쓴글의 수정이 가능하다. Only the writer can edit what he or she has written.
public class CheckWriterInterceptor implements HandlerInterceptor {

	@Resource(name = "signInMemberDTO")
	private @Lazy MemberDTO signInMemberDTO;

	@Autowired
	private BoardService boardService;

	// 로그인한 사람과 작성한 사람이 같은지 검사하기(이번 Interceptor는 수정할 때와 삭제할 때만 반응하도록 함)
	// Checking that the sign-in user and the person who wrote the post are the same person. 
	// This Interceptor only reacts on edit or delete the post.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		int postNo = Integer.parseInt(request.getParameter("postNo"));
		PostDTO tmpPostDTO = boardService.read(postNo);

		// 작성자와 로그인한 사람이 동일한 사람인 경우 
		// If the writer and the Signed-in person are the same person. 
		if (tmpPostDTO.getWriter().equalsIgnoreCase(signInMemberDTO.getNick())) {

			return true;

		} else {

			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath + "/etc/notWriter");
			return false;

		}
	}
}
