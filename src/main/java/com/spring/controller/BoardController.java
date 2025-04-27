package com.spring.controller;

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
import com.spring.dto.PageDTO;
import com.spring.dto.PostDTO;
import com.spring.dto.ReplyDTO;
import com.spring.dto.ReportDTO;
import com.spring.service.BoardService;
import com.spring.service.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private ReplyService replyService;

	// 1. 1) 게시판 메인 페이지로 이동 (Going to the Main Page of Board)
	@RequestMapping("/main")
	public String main(
			@RequestParam("boardNo") int boardNo, 
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		// Index
		model.addAttribute("boardNo", boardNo); 

		// Board's name
		String boardName = boardService.getBoardName(boardNo);
		model.addAttribute("boardName", boardName);

		// The post list
		List<PostDTO> postList = boardService.goMain(boardNo, page);
		model.addAttribute("postList", postList);

		// Pagination
		PageDTO pageDTO = boardService.mainPageDTO(boardNo, page);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);

		return "board/main";
	}

	// 1. 1) 게시판 메인 페이지에서 특정 게시물을 검색 (Searching for the specific posts)
	@RequestMapping("/searchResult")
	public String searchResult(
			@RequestParam("boardNo") int boardNo, 
			@RequestParam("type") String type,
			@RequestParam("keyword") String keyword, 
			@RequestParam(value = "page", defaultValue = "1") int page, Model model)
			throws Exception {

		String boardName = boardService.getBoardName(boardNo);
		model.addAttribute("boardName", boardName);

		PostDTO searchListPostDTO = new PostDTO();
		searchListPostDTO.setBoardNo(boardNo);
		searchListPostDTO.setType(type);
		searchListPostDTO.setKeyword(keyword);

		// Search's Results List
		List<PostDTO> searchList = boardService.searchList(searchListPostDTO, page);
		model.addAttribute("searchList", searchList);

		// Number of search results
		int searchCount = boardService.searchCount(searchListPostDTO);
		model.addAttribute("searchCount", searchCount);

		// Making pagination(1 2 3 4 5 6 7 8 9 10) on the board's main page.
		PageDTO searchListPageDTO = boardService.searchPageDTO(searchListPostDTO, page);
		model.addAttribute("searchListPageDTO", searchListPageDTO);
		model.addAttribute("boardNo", boardNo);
		model.addAttribute("page", page);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);

		return "board/main";
	}

	// 2. 1) 글쓰기 페이지로 이동 (Going to The Page to write) 
	@RequestMapping("/write")
	public String write(@RequestParam("boardNo") int boardNo, Model model) {
		model.addAttribute("boardNo", boardNo);
		return "board/write";
	}

	// 2. 2) 게시글 등록 (Adding or Creating a post)
	@RequestMapping("/writeProcess")
	public @ResponseBody PostDTO writeProcess(HttpServletRequest request, HttpServletResponse response, PostDTO writePostDTO, MultipartFile imageFile) throws Exception {
		PostDTO postDTO = boardService.writeProcess(writePostDTO);
		return postDTO;
	}

	// 3. 1) 게시글 수정 페이지로 이동 (Going to The page to modify) 
	@RequestMapping("/modify")
	public String modify(@RequestParam("postNo") int postNo, @ModelAttribute("modifyPostDTO") PostDTO modifyPostDTO, Model model) {

		model.addAttribute("postNo", postNo);
		
		// Take the Post that you want to modify. 
		PostDTO PostDTOfromDB = boardService.read(postNo);
		model.addAttribute("PostDTOfromDB", PostDTOfromDB);

		return "board/modify";
	}

	// 3. 2) 이미지 첨부파일 삭제 (Removing attached image file in the modification page.)
	@RequestMapping("/deleteImageFile")
	public @ResponseBody PostDTO deleteImageFile(PostDTO imageFilePostDTO) {
		PostDTO afterDeletingImageFile = boardService.deleteImageFile(imageFilePostDTO);
		return afterDeletingImageFile;
	}

	// 3. 3) 게시글 수정 완료 (Completing the modification of post)
	@RequestMapping("/modifyProcess")
	public @ResponseBody PostDTO modifyProcess(HttpServletRequest request, HttpServletResponse response, PostDTO modifyPostDTO, MultipartFile imageFile) throws Exception {
		
		// 수정하겠다고 하는 그 글들이 입력되어 고쳐쓴 새로운 PostDTO가 된다.
		PostDTO postDTO = boardService.modify(modifyPostDTO);
		return postDTO;
	}

	// 4. 게시글 읽기 (Reading a Post)
	@RequestMapping("/read")
	public String read(@RequestParam("postNo") int postNo, @ModelAttribute("readPostDTO") PostDTO postDTO, Model model) {

		PostDTO readPostDTO = boardService.read(postNo); 
		model.addAttribute("readPostDTO", readPostDTO);
		model.addAttribute("postNo", postNo);

		// 조회수 증가 Increasing views
		boardService.increasingViewCount(postNo); 

		// 대글 출력 Printing the comment
		List<ReplyDTO> replyList = replyService.replyList(postNo);
		model.addAttribute("replyList", replyList);

		return "board/read";
	}

	// 5. 1) 댓글 등록 Commenting
	@RequestMapping("/writeReplyProcess")
	public @ResponseBody ReplyDTO writeReplyProcess(ReplyDTO writeReplyDTO) {

		ReplyDTO ReplyDTO = replyService.writeReplyProcess(writeReplyDTO);
		return ReplyDTO;
	}

	// 5. 2) 댓글삭제 Deleting the comment
	@RequestMapping("/removeReply")
	public @ResponseBody ReplyDTO removeReply(int replyNo) {

		ReplyDTO ReplyDTO = replyService.removeReply(replyNo);
		return ReplyDTO;
	}

	// 6. 좋아요(추천) recommend
	@RequestMapping("/like")
	public @ResponseBody PostDTO like(int postNo) throws Exception {
		PostDTO likePostDTO = boardService.like(postNo);
		return likePostDTO;
	}

	// 7. 1) 게시글 신고 페이지로 이동 (Going to the post's report page)
	@RequestMapping("/report")
	public String report(@RequestParam("postNo") int postNo, Model model) {
		model.addAttribute("postNo", postNo);
		return "board/report";
	}

	// 7. 2) 게시글 신고완료 (completing a Post's report)
	@RequestMapping("/reportProcess")
	public @ResponseBody ReportDTO reportProcess(ReportDTO submitReportDTO, MultipartFile imageFile) throws Exception {
		ReportDTO reportDTO = boardService.reportProcess(submitReportDTO);
		return reportDTO;
	}
	
	// 8. 글삭제 (Deleting the post)
	@RequestMapping("/deletePost")
	public @ResponseBody PostDTO deleteBoard(HttpServletRequest request, HttpServletResponse response, int postNo) throws Exception {
		PostDTO postDTO = boardService.deletePost(postNo);
		return postDTO;
	}

}