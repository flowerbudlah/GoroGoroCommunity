package com.spring.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.spring.dao.AdminDAO;
import com.spring.dto.AdminReplyDTO;
import com.spring.dto.BoardDTO;
import com.spring.dto.CategoryDTO;
import com.spring.dto.FlagDTO;
import com.spring.dto.LoginRecordDTO;
import com.spring.dto.MemberDTO;
import com.spring.dto.PageDTO;
import com.spring.dto.ReportDTO;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class AdminService {

	@Autowired
	private AdminDAO adminDAO;

	// 한 페이지당 보여주는 글의 개수 10개
	// Number of posts that are displayed per one page = 10
	@Value("${page.listcnt}")
	private int page_listcnt;

	// 한 페이지당 보여주는 페이지 버튼 개수 10개[1 2 3 4 5 6 7 8 9 10] 
	// Number of buttons that are displayed per one page = 10
	@Value("${page.paginationcnt}")
	private int page_paginationcnt;
	
	// 1. 1) 회원목록 불러오기 (In 회원관리페이지) Taking the entire user list from the user management page. 
	public List<MemberDTO> takeMemberList() {
		return adminDAO.takeMemberList();
	}

	// 1. 2) 로그인 기록 가져오기 Take the record of Sign-in realTime of the specific user.
	public List<LoginRecordDTO> takeLoginRecord(String nick) {
		return adminDAO.takeLoginRecord(nick);
	}

	// 1. 3) 특정한 한 회원이 쓴 글의 수 가져오기 (In 회원관리페이지)
	// The function that takes the number of posts written by a specific user in the Admin page that manages users. 
	public int postCount(String writer) {
		return adminDAO.postCount(writer);
	}

	// 1. 4) 특정한 한 회원이 쓴 댓글 수 가져오기 (In 회원관리페이지)
	// The function that takes the number of comments(Reply) written by a specific user in the Admin page that manages users. 
	public int replyCount(String writer) {
		return adminDAO.replyCount(writer);
	}

	// 1. 5) 특정 회원 검색 (In 회원관리페이지)
	// The function that Administrator can searches for a specific user's information in the administrator page that manages users. 
	public List<MemberDTO> searchMemberList(MemberDTO searchListMemberDTO) throws Exception {
		return adminDAO.searchMemberList(searchListMemberDTO);
	}

	// 1. 6) Email (ID) 일시정지 (In 회원관리페이지)
	public MemberDTO makeIdSuspend(String email) {

		MemberDTO emailToSuspend = new MemberDTO();

		int successToSuspend = adminDAO.makeIdSuspend(email);

		if (successToSuspend > 0) {

			emailToSuspend.setResult("successfulPause");

		} else {
			
			emailToSuspend.setResult("failureOfPause");

		}

		return emailToSuspend;
	}

	// 1. 7) Email (ID) 일시정지 해제 (In 회원관리페이지)
	public MemberDTO makeIdActive(String email) {

		MemberDTO activeEmail = new MemberDTO();

		int successOfActivating = adminDAO.makeIdActive(email);

		if (successOfActivating > 0) {

			activeEmail.setResult("successOfmakingActive");

		} else {
			
			activeEmail.setResult("failureOfmakingActive");
		
		}

		return activeEmail;
	}
	
	// 2. 1) 게시판 카테고리 생성 Create a category
	public CategoryDTO makeCategory(String boardCategoryName) {

		CategoryDTO categoryDTO = new CategoryDTO();
		
		int categoryMakingCount = adminDAO.makeCategory(boardCategoryName);

		if (categoryMakingCount > 0) {
			
			categoryDTO.setResult("Success");

		} else {
			
			categoryDTO.setResult("Fail");
		
		}
		return categoryDTO;
	}

	// 2. 2) 카테고리 이름 중복체크 Duplication Checking of the Category's name
	public String checkCategory(String boardCategoryName) {
		return adminDAO.checkCategory(boardCategoryName);
	}

	// 2. 3) 카테고리 삭제 Delete the category
	public CategoryDTO deleteCategory(int boardCategoryNo) {

		CategoryDTO deleteCatetoryDTO = new CategoryDTO();

		int deleteCnt = adminDAO.deleteCategory(boardCategoryNo);

		if (deleteCnt > 0) {
			deleteCatetoryDTO.setResult("success");
		} else {
			deleteCatetoryDTO.setResult("fail");
		}

		return deleteCatetoryDTO;
	}

	// 2. 4) 카테고리 안에 있는 게시판 생성 Create a board
	public BoardDTO makeBoard(BoardDTO BoardDTOinCategory) {

		BoardDTO newBoardDTOinCategory = new BoardDTO();

		// 게시판 생성
		int boardMakingCount = adminDAO.makeBoard(BoardDTOinCategory);

		if (boardMakingCount > 0) {
			newBoardDTOinCategory.setResult("Success");
		} else {
			newBoardDTOinCategory.setResult("Fail");
		}
		return newBoardDTOinCategory;
	}

	// 2. 5) 게시판 이름 중복체크 Checking the duplication of board's name in the same category.
	// 2. 5). (1) 게시판을 새롭게 만들고자 할경우, 같은 카테고리안에서는 같은이름의 게시판을 만들수 없다. 
	// 2. 5). (2) 새롭게 이동할 카테고리안에 이미 같은이름의 게시판이 존재하면 카테고리를 이동할수없다.  
	public String checkBoardNameInTheSameCategory(BoardDTO boardNameAndCategoryNo) {
		return adminDAO.checkBoardNameInTheSameCategory(boardNameAndCategoryNo);
	}
	
	

	// 2. 6) 게시판이 속한 카테고리 변경 Updating 
	public void changeCategory(BoardDTO boardDTOinCategory) {
		adminDAO.changeCategory(boardDTOinCategory);
	}

	// 2. 7) 게시판 이름 변경 Updating
	public BoardDTO changeBoardName(BoardDTO boardDTOinCategory) {

		BoardDTO changingBoardDTO = new BoardDTO();

		int boardNameChanging = adminDAO.changeBoardName(boardDTOinCategory);

		if (boardNameChanging > 0) {
			changingBoardDTO.setResult("Success");
		} else {
			changingBoardDTO.setResult("Fail");
		}

		return changingBoardDTO;
	}

	// 2. 8) 게시판 삭제 Delete the board
	public BoardDTO deleteBoard(int boardNo) throws Exception {

		BoardDTO boardToDelete = new BoardDTO();

		int delete = adminDAO.deleteBoard(boardNo);

		if (delete > 0) {
			boardToDelete.setResult("success");

		} else {
			boardToDelete.setResult("fail");
		}
		
		return boardToDelete;
	}

	// 3. 1) 관리자가 신고보고서 목록을 모두 보기 (in 게시물 관리 페이지), 신고 보고서 목록 가져오기
	// Taking the a list of reports on post management.
	// With this function, Admin can view a list of reports on the Post Management page. 
	public List<ReportDTO> takeReportedPost(int page) {

		// 한 페이지
		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);

		return adminDAO.takeReportedPost(rowBounds);
	}

	// 3. 2) 신고보고서 목록 페이지처리(on 게시물 관리 페이지) 
	public PageDTO reportedPost(int currentPage) {

		int countOfReportedPost = adminDAO.countOfReportedPost();
		
		PageDTO pageDTO = new PageDTO(countOfReportedPost, currentPage, page_listcnt, page_paginationcnt);
		return pageDTO;
	}

	// 3. 3) 신고 보고서에 관리자의 댓글 작성 Create
	public AdminReplyDTO writeAdminReplyProcess(AdminReplyDTO writeReplyDTO) {

		AdminReplyDTO adminReplyDTO = new AdminReplyDTO();

		int writingCount = adminDAO.writeAdminReplyProcess(writeReplyDTO);

		if (writingCount > 0) {

			adminReplyDTO.setResult("success");

		} else {

			adminReplyDTO.setResult("fail");

		}

		return adminReplyDTO;
	}

	// 3. 4) 하나의 신고 보고서에 달린 관리자의 댓글리스트 조회 Read
	public List<AdminReplyDTO> replyAdminList(int reportNo) {
		return adminDAO.adminReplyList(reportNo);
	}

	// 3. 5) 신고보고서에 달린 관리자 답변에 대한 관리자의 댓글삭제 delete
	public AdminReplyDTO removeAdminReply(int replyNo) {

		AdminReplyDTO adminReplyDTO = new AdminReplyDTO();

		int removeCount = adminDAO.removeAdminReply(replyNo);

		 // 댓글삭제 성공
		if (removeCount > 0) {

			adminReplyDTO.setResult("success");
			 
		// 댓글삭제 미성공
		} else {
			
			adminReplyDTO.setResult("fail");
		}
		
		return adminReplyDTO;
	}

	// 3. 6) 신고보고서 게시판 메인화면에서 게시글 검색 (with Ajax)
	public List<ReportDTO> searchList(ReportDTO searchListReportDTO, int page) throws Exception {

		// 한 페이지
		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);

		List<ReportDTO> searchList = adminDAO.searchList(searchListReportDTO, rowBounds);
		return searchList;
	}

	// 3. 7) 신고보고서 게시판 메인화면에서 특정 신고보고서 검색후 화면에서의 페이지처리
	public PageDTO searchPageDTO(ReportDTO searchListReportDTO, int currentPage) {

		// 검색되는 신고보고서의 수 (Number of reports that have been searched)
		int searchCount = adminDAO.searchCount(searchListReportDTO);
		PageDTO searchPageDTO = new PageDTO(searchCount, currentPage, page_listcnt, page_paginationcnt);
		return searchPageDTO;
	}

	// 3. 8) 검색되는 신고보고서의 수 (Number of reports that have been searched)
	public int searchCount(ReportDTO searchListReportDTO) {
		int searchCount = adminDAO.searchCount(searchListReportDTO);
		return searchCount;
	}

	// 3. 9) 유효한 신고라면 관리자는 경고플래그 증가시킬 수 있다.
	// If the report is valid, the administrator can increase the flag.
	public FlagDTO increaseFlag(FlagDTO flagDTO) {

		FlagDTO flag = new FlagDTO();

		// 이 글이 이미 플래그(경고)를 받은 글이라면 중복해서 플래그 증가 불가
		// If this post has already been flaged, No flags can be increased. 
		if (this.checkFlagedAlready(flagDTO.getPostNo())) {

		} else {

			int flagCount = adminDAO.increaseFlag(flagDTO);

			System.out.print("flag: " + flagCount);

			if (flagCount > 0) {

				flag.setResult("success");
				
			} else {

				flag.setResult("fail");
			}
		}
		return flag;
	}

	// 3. 10) 게시글이 플래그(경고)를 받은 것인지를 판단하는 기능 
	// A function to determine whether The post has been flagged or not.
	public boolean checkFlagedAlready(int postNo) {

		String checkIfAlreadyFlaged = adminDAO.checkFlagedAlready(postNo);

		// 이미 그 게시글이 경고를 받은 글이라면
		if (checkIfAlreadyFlaged != null) {

			// 다시 경고 못한다. 
			return true;
			
		// 경고플래그를 받은적이없는 게시글이라면
		} else {
			
			// 경고플래그 추가
			return false;
		}
	}

}