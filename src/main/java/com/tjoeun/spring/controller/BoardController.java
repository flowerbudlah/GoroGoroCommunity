package com.tjoeun.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.dto.ReplyDTO;
import com.tjoeun.spring.dto.ReportDTO;
import com.tjoeun.spring.service.BoardService;
import com.tjoeun.spring.service.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private ReplyService replyService;

	// 1. 게시판 메인화면으로 간다.
	@RequestMapping("/main")
	public String main(
			@RequestParam("boardNo") int boardNo, 
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		// 게시판 일련번호(인덱스)
		model.addAttribute("boardNo", boardNo); 

		// 게시판 이름
		String boardName = boardService.getBoardName(boardNo);
		model.addAttribute("boardName", boardName);

		// 해당 게시판 안의 글 목록
		List<PostDTO> postList = boardService.goMain(boardNo, page);
		model.addAttribute("postList", postList);

		// 페이지 처리
		PageDTO pageDTO = boardService.mainPageDTO(boardNo, page);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);

		return "board/main";
	}

	// 2. 게시판 메인페이지에서 특정 게시글 검색과 페이지(1 2 3 4 5 6 7 8 9 10)처리
	@RequestMapping("/searchResult")
	public String searchResult(
			@RequestParam("boardNo") int boardNo, 
			@RequestParam("type") String type,
			@RequestParam("keyword") String keyword, 
			@RequestParam(value = "page", defaultValue = "1") int page, Model model)
			throws Exception {
		
		// 게시판 이름
		String boardName = boardService.getBoardName(boardNo);
		model.addAttribute("boardName", boardName);

		PostDTO searchListPostDTO = new PostDTO();
		searchListPostDTO.setBoardNo(boardNo);
		searchListPostDTO.setType(type);
		searchListPostDTO.setKeyword(keyword);

		// 검색결과 리스트
		List<PostDTO> searchList = boardService.searchList(searchListPostDTO, page);
		model.addAttribute("searchList", searchList);

		// 검색결과 수
		int searchCount = boardService.searchCount(searchListPostDTO);
		model.addAttribute("searchCount", searchCount);

		// 페이징
		PageDTO searchListPageDTO = boardService.searchPageDTO(searchListPostDTO, page);
		model.addAttribute("searchListPageDTO", searchListPageDTO);
		
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("page", page);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);

		return "board/main";
	}

	// 2. 1) 글쓰기 페이지로 이동
	@RequestMapping("/write")
	public String write(@RequestParam("boardNo") int boardNo, Model model) {
		model.addAttribute("boardNo", boardNo);
		return "board/write";
	}

	// 2. 2) 게시글 등록 Creating
	@RequestMapping("/writeProcess")
	public @ResponseBody PostDTO writeProcess(HttpServletRequest request, HttpServletResponse response, PostDTO writePostDTO, MultipartFile imageFile) throws Exception {
		PostDTO postDTO = boardService.writeProcess(writePostDTO);
		return postDTO;
	}

	// 3. 1) 글 수정 페이지로 이동
	@RequestMapping("/modify")
	public String modify(@RequestParam("postNo") int postNo, @ModelAttribute("modifyPostDTO") PostDTO modifyPostDTO, Model model) {

		model.addAttribute("postNo", postNo);
		
		// 수정하고자 하는 그 글을 가져온다. 
		PostDTO PostDTOfromDB = boardService.read(postNo);
		model.addAttribute("PostDTOfromDB", PostDTOfromDB);

		return "board/modify";
	}

	// 3. 2) 게시글 수정완료(Complete Updating)
	@RequestMapping("/modifyProcess")
	public @ResponseBody PostDTO modifyProcess(HttpServletRequest request, HttpServletResponse response, PostDTO modifyPostDTO, MultipartFile imageFile) throws Exception {
		
		// 수정하겠다고 하는 그 글들이 입력되어 고쳐쓴 새로운 PostDTO가 된다.
		PostDTO postDTO = boardService.modify(modifyPostDTO);
		return postDTO;
	}

	// 4. 게시글읽기 (댓글 포함)
	@RequestMapping("/read")
	public String read(@RequestParam("postNo") int postNo, @ModelAttribute("readPostDTO") PostDTO postDTO, Model model) {

		PostDTO readPostDTO = boardService.read(postNo);

		model.addAttribute("readPostDTO", readPostDTO);
		model.addAttribute("postNo", postNo);

		// 조회수 증가
		boardService.increasingViewCount(postNo); 

		// 댓글출력
		List<ReplyDTO> replyList = replyService.replyList(postNo);
		model.addAttribute("replyList", replyList);

		return "board/read";

	}

	// 5. 글삭제(Deleting)
	@RequestMapping("/deletePost")
	public @ResponseBody PostDTO deleteBoard(HttpServletRequest request, HttpServletResponse response, int postNo) throws Exception {
		PostDTO postDTO = boardService.deletePost(postNo);
		return postDTO;
	}

	// 6. 1) 댓글등록
	@RequestMapping("/writeReplyProcess")
	public @ResponseBody ReplyDTO writeReplyProcess(ReplyDTO writeReplyDTO) {

		ReplyDTO ReplyDTO = replyService.writeReplyProcess(writeReplyDTO);
		return ReplyDTO;
	}

	// 6. 2) 댓글삭제
	@RequestMapping("/removeReply")
	public @ResponseBody ReplyDTO removeReply(int replyNo) {

		ReplyDTO ReplyDTO = replyService.removeReply(replyNo);
		return ReplyDTO;
	}

	// 7. 이미지 첨부파일 삭제
	@RequestMapping("/deleteImageFile")
	public @ResponseBody PostDTO deleteImageFile(PostDTO imageFilePostDTO) {
		PostDTO afterDeletingImageFile = boardService.deleteImageFile(imageFilePostDTO);
		return afterDeletingImageFile;
	}

	// 8. 좋아요(추천)
	@RequestMapping("/like")
	public @ResponseBody PostDTO like(int postNo) throws Exception {
		PostDTO likePostDTO = boardService.like(postNo);
		return likePostDTO;
	}

	// 9. 1) 게시글 신고페이지로 이동
	@RequestMapping("/report")
	public String report(@RequestParam("postNo") int postNo, Model model) {
		model.addAttribute("postNo", postNo);
		return "board/report";
	}

	// 9. 2) 게시글 신고
	@RequestMapping("/reportProcess")
	public @ResponseBody ReportDTO reportProcess(ReportDTO submitReportDTO, MultipartFile imageFile) throws Exception {
		ReportDTO reportDTO = boardService.reportProcess(submitReportDTO);
		return reportDTO;
	}

}