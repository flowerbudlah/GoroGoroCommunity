package com.spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.dto.AdminReplyDTO;
import com.spring.dto.BoardDTO;
import com.spring.dto.CategoryDTO;
import com.spring.dto.LoginRecordDTO;
import com.spring.dto.MemberDTO;
import com.spring.dto.PageDTO;
import com.spring.dto.ReportDTO;
import com.spring.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;

	// 1. 1) 회원 관리 페이지로 이동 (Going to the Member management Page)
	@RequestMapping("/memberManagement")
	public String memberManagement(Model model) {

		List<MemberDTO> allMemberList = adminService.takeMemberList();
		model.addAttribute("allMemberList", allMemberList);

		return "admin/memberManagement";
	}

	// 1. 2) 회원관리 페이지에서 특정회원 검색하기 (With using AJAX, Searching the member in the member management page)
	@GetMapping("/searchMemberList")
	public @ResponseBody List<MemberDTO> searchMemberList(
	    @RequestParam("type") String type, 
	    @RequestParam("keyword") String keyword) throws Exception {

	    // 입력값 방어 코드 추가 (Add input validation)
	    if (type == null || keyword == null || type.trim().isEmpty() || keyword.trim().isEmpty()) {
	        return new ArrayList<>();
	    }

	    MemberDTO searchListMemberDTO = new MemberDTO();
	    searchListMemberDTO.setType(type.trim());
	    searchListMemberDTO.setKeyword(keyword.trim());

	    try {
	    	List<MemberDTO> searchMemberList = adminService.searchMemberList(searchListMemberDTO);
	        return searchMemberList;
	    } catch (Exception e) {
	    	
	    	// 콘솔에서 정확한 원인 확인 가능 (Being able to confirm the accurate cause In console)
	        e.printStackTrace();
	        return new ArrayList<>();
	    }
	}

	// 1. 3) 회원 관리 페이지에서 회원의 로그인 실시간 기록 파악 가능 (Going to the real-time login record page.)
	@RequestMapping("/realTimeAboutLogin")
	public String realTimeAboutLogin(Model model, @RequestParam(value = "nick") String nick) {

		List<LoginRecordDTO> realTimeLoginRecordList = adminService.takeLoginRecord(nick);
		model.addAttribute("realTimeLoginRecordList", realTimeLoginRecordList);
		model.addAttribute("nick", nick);

		return "admin/realTimeAboutLogin";
	}

	// 1. 4) 특정회원의 로그인 일시정지 시기키 (making Sign-in of a specific user pause)
	@RequestMapping("/makeIdSuspend")
	public @ResponseBody MemberDTO makeIdSuspend(String email) {

		MemberDTO emailToSuspend = adminService.makeIdSuspend(email);
		return emailToSuspend;
	}
	

	// 1. 5) 특정회원의 로그인 일시정지 해제 (making suspended Sign-in activate)
	@RequestMapping("/makeIdActive")
	public @ResponseBody MemberDTO makeIdActive(String email) {
		
		MemberDTO activeEmail = adminService.makeIdActive(email); 
		return activeEmail;
	}

	// 2. 1) 게시물 관리 페이지로 이동 (Going to the Post Management page. This page show administrator the reported Posts.)
	@RequestMapping("/postManagement")
	public String postManagement(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {

		List<ReportDTO> reportedPostList = adminService.takeReportedPost(page);
		model.addAttribute("reportedPostList", reportedPostList);

		// Pagination
		PageDTO pageDTO = adminService.reportedPost(page);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("page", page);

		return "admin/postManagement";
	}

	// 2. 2) 게시물 관리 페이지안에서 신고 보고서에 대한 관리자측의 검색결과 (The Search results in the post management page)
	@RequestMapping("/searchResult")
	public String searchResult(Model model,
			@RequestParam("type") String type,
			@RequestParam("keyword") String keyword, 
			@RequestParam(value = "page", defaultValue = "1") int page) throws Exception {

		ReportDTO searchListReportDTO = new ReportDTO();
		searchListReportDTO.setType(type);
		searchListReportDTO.setKeyword(keyword);

		// 신고내역 게시글 검색결과 리스트 (List of search results)
		List<ReportDTO> searchList = adminService.searchList(searchListReportDTO, page);
		model.addAttribute("searchList", searchList);

		// 검색결과 신고내역 게시글의 수 (Number of posts in search result.)
		int searchCount = adminService.searchCount(searchListReportDTO);
		model.addAttribute("searchCount", searchCount);

		// 1 2 3 4 5 6 7 8 9 10
		PageDTO searchListPageDTO = adminService.searchPageDTO(searchListReportDTO, page);
		model.addAttribute("searchListPageDTO", searchListPageDTO);
		model.addAttribute("page", page);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);

		return "admin/postManagement";
	}

	// 2. 3) 관리자가 신고보고서 게시글에 대해 답글을 달기 (The administrator responds to the report from the other user.)
	@RequestMapping("/writeAdminReplyProcess")
	public @ResponseBody AdminReplyDTO writeReplyProcess(HttpServletRequest request, HttpServletResponse response, AdminReplyDTO writeAdminReplyDTO) {

		AdminReplyDTO adminReplyDTO = adminService.writeAdminReplyProcess(writeAdminReplyDTO);
		return adminReplyDTO;

	}

	// 2. 4) 관리자가 신고보고서에 작성한 댓글삭제 
	// The function that Administrator deletes comments written by administrators in report.
	@RequestMapping("/removeAdminReply")
	public @ResponseBody AdminReplyDTO removeAdminReply
	(HttpServletRequest request, HttpServletResponse response, int replyNo) {

		AdminReplyDTO ReplyDTO = adminService.removeAdminReply(replyNo);
		return ReplyDTO;
	}

	// 3. 1) 게시판 관리 페이지로 이동 (Going to the board management Page.)
	@RequestMapping("/boardManagement")
	public String boardManagement() {
		return "admin/boardManagement";
	}

	// 3. 2) 게시판 카테고리를 생성 (Creating a category in the board management page.)
	@RequestMapping("/makeCategory")
	public @ResponseBody CategoryDTO make(String boardCategoryName) {

		// 변수로 들어온 값이 문자열이 전혀 없는 공란(" ", blank)뿐 이라면 그 이름의 카테고리 생성 불가
		// If the Category's name entered as a variable is only a blank (" ", blank) with no strings at all,
		// a category with that name cannot be created.
		if (boardCategoryName.trim().isEmpty()) {

			return null;

		} else {

			// 입력된 카테고리 이름의 앞뒤 공란을 제거하는 처리
			// Function to remove spaces(" ") before and after the entered category's name
			boardCategoryName = boardCategoryName.trim();
			// trim()의 기능적인 특징: 만약에 공란(" ", blank)만 나오면 트림기능 작동못함.
			// Functional feature of trim(): If Entered Value is only blank (" "), the trim function does not work.

			// 해당 카테고리 이름 중복되지 않았기에 사용가능한 경우,
			// If the category name is not duplicated, it can be used.
			if (this.checkCategoryName(boardCategoryName)) {
				// making new Category.
				return adminService.makeCategory(boardCategoryName);

			// 해당 카테고리 이름이 이미 존재하기에 사용불가
			// If the category name is duplicated, it cannot be used.
			} else {

				return null;
			}
		}
	}

	// 3. 3) 카테고리 이름 중복체크 (Duplicate Check of Category's name)
	public boolean checkCategoryName(String boardCategoryName) {

		String result = adminService.checkCategory(boardCategoryName);

		// 입력한 해당 카테고리 이름은 없기에 사용가능 
		// If a category name you entered does not exist, 
		if (result == null) {
			
			// 사용가능 (You can use The category's name)  
			return true;
			
		// 해당 카테고리 이름이 이미 존재한다면 (해당 이름 중복)
		// If it already exists as duplicate name. 
		} else {
			
			// 사용불가 (The category name cannot be used.)
			return false; 
		}
	}

	// 3. 4) 카테고리 삭제 (Deleting the Category)
	@RequestMapping("/deleteCategory")
	public @ResponseBody CategoryDTO deleteCategory(int boardCategoryNo) {
		CategoryDTO categoryDTOtoDelete = adminService.deleteCategory(boardCategoryNo);
		return categoryDTOtoDelete;
	}

	// 3. 5) (카테고리에 포함된) 게시판을 생성 (Creating a board included in a category)
	@RequestMapping("/makeNewBoard")
	public @ResponseBody BoardDTO makeNewBoard(BoardDTO BoardDTOinCategory) {

		// 변수로 들어온 값인 게시판이름이 문자열이 전혀 없는 공란(" ", blank)뿐 이라면 불가
		// If the board name that is entered as a variable is a blank space (" ", blank) with no strings at all, it is not possible.
		if (BoardDTOinCategory.getBoardName().trim().isEmpty()) {

			return null;

		} else {

			// 입력된 게시판 이름의 앞뒤 공란을 제거하는 처리
			// the Function to remove spaces before and after the entered board's name.
			BoardDTOinCategory.setBoardName(BoardDTOinCategory.getBoardName().trim()); 
			// trim() 이 기능이 특징이 만약에 공란(" ", blank)만 나오면 트림기능 작동못함.

			// 해당 카테고리안의 게시판 이름이 중복되지 않았기에 사용가능한 경우
			if (this.checkBoardNameInTheSameCategory(BoardDTOinCategory)) {

				// 새로운 게시판 생성
				return adminService.makeBoard(BoardDTOinCategory);

			// 해당 카테고리안의 게시판 이름이 이미 존재하기에 사용불가
			} else {

				return null;
			}
		}
	}

	// 3. 6) 새로운 게시판을 만드는 경우, 같은 카테고리 안에 이미 해당 게시판 이름이 존재하면 만들 수 없는 기능 (동일 카테고리 안에서 게시판이름 중복금지)
	// Duplicate board names within the same category are not allowed.
	public boolean checkBoardNameInTheSameCategory(BoardDTO boardNameAndCategoryNo) {

		String result = adminService.checkBoardNameInTheSameCategory(boardNameAndCategoryNo);

		if (result == null) {
			
			// 사용가능
			return true; 
		
		} else {
			
			// 사용불가
			return false; 
		}
	}

	// 3. 7) 게시판 이름 변경 (Modify the board's name)
	@RequestMapping("/changeBoardName")
	public @ResponseBody BoardDTO changeBoardName(@ModelAttribute BoardDTO boardDTOinCategory) {

		// 입력된 게시판 이름이 공백이면 변경불가
	    if (boardDTOinCategory.getBoardName().trim().isEmpty()) {
	        return null;

	    } else {
	    	
	        boardDTOinCategory.setBoardName(boardDTOinCategory.getBoardName().trim());

	        // 입력된 게시판의 이름이 이미 같은 카테고리에 존재하지 않는다면 
	        // If the name of the entered board does not exist in the same category. 
	        if (this.checkBoardNameInTheSameCategory(boardDTOinCategory)) {
	        	
	        	// 해당 이름 사용 가능 can use
	            return adminService.changeBoardName(boardDTOinCategory);

	        // 같은 카테고리 안에 입력된 게시판의 이름이 중복되는 경우, 그 이름으로 변경불가
	        // If the board name you entered already exists in the same category (duplicate),
	        } else {
	        	
	        	// it cannot be used.
	            return null;
	        }
	    }
	}

	// 3. 8) 게시판 삭제
	@RequestMapping("/deleteBoard")
	public @ResponseBody BoardDTO deleteBoard(int boardNo) throws Exception {
		
		BoardDTO boardToDelete = adminService.deleteBoard(boardNo);
		return boardToDelete; 
	}

	// 3. 9) 게시판이 속해있는 카테고리의 변경 (Changing the category of the board)
	@RequestMapping("/changeCategory")
	public @ResponseBody BoardDTO changeBoardCategory(@ModelAttribute BoardDTO boardDTOinCategory) {

		// 입력된 게시판의 이름이 공란이라면 (If the entered board name is blank) 
	    if (boardDTOinCategory.getBoardName() == null || boardDTOinCategory.getBoardName().trim().isEmpty()) {
	    	// cannot change
	        return null;
	    }

	    boardDTOinCategory.setBoardName(boardDTOinCategory.getBoardName().trim());

	    // 입력된 게시판의 이름이 같은 카테고리 안에 존재하는지 여부를 체크
		String result = adminService.checkBoardNameInTheSameCategory(boardDTOinCategory);

		// 바꾸고자하는 카테고리 안에 그 이름 이미 존재
		if(result != null) {

			// 이동불가
			return null;
		
		// 바꾸고자하는 카테고리 안에 그 이름이 없는 경우
		} else {

			// 카테고리 변경 (카테고리 이동가능)
			adminService.changeCategory(boardDTOinCategory);
			return boardDTOinCategory;			
		}
	}
}