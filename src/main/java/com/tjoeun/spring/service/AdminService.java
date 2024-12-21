package com.tjoeun.spring.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.tjoeun.spring.dao.AdminDAO;
import com.tjoeun.spring.dto.AdminReplyDTO;
import com.tjoeun.spring.dto.BoardDTO;
import com.tjoeun.spring.dto.CategoryDTO;
import com.tjoeun.spring.dto.MemberDTO;
import com.tjoeun.spring.dto.PageDTO;
import com.tjoeun.spring.dto.PostDTO;
import com.tjoeun.spring.dto.ReportDTO;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class AdminService {

	@Autowired
	private AdminDAO adminDAO; 

	@Value("${page.listcnt}")
	private int page_listcnt; // 한 페이지당 보여주는 글의 개수
	
	@Value("${page.paginationcnt}")
	private int page_paginationcnt;	// 한 페이지당 보여주는 페이지 버튼 개수
	
	//1. 게시판 대분류 카테고리 생성 Create
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

	public String checkCategory(String boardCategoryName) {
		return adminDAO.checkCategory(boardCategoryName); 
	}
		
	//2. 카테고리 삭제 Delete 
	public void deleteCategory(int boardCategoryNo) {
		adminDAO.deleteCategory(boardCategoryNo);
	}
	
	//3. 게시판 이름 생성 Create
	public void makeBoard(BoardDTO BoardDTOinCategory) {
		adminDAO.makeBoard(BoardDTOinCategory);
	}

	//4. 게시판 이름 변경 Updating
	public void changeBoardName(BoardDTO boardDTOinCategory) {
		adminDAO.changeBoardName(boardDTOinCategory);
	}
	
	//5. 게시판 삭제 Delete
	public void deleteBoard(int boardNo) {
		adminDAO.deleteBoard(boardNo);
	}	

	//6. 게시판이 속한 대분류 카테고리 변경 Updating
	public void changeCategory(BoardDTO boardDTOinCategory) {
		adminDAO.changeCategory(boardDTOinCategory);
	}
	
	
	//7. 1) 멤버리스트는 다 가져오는거(at 관리자페이지)
	public List<MemberDTO> takeMemberList(){
		return adminDAO.takeMemberList();
	} 
	
	//7. 2) 특정한 한 회원이 쓴 글의 수 가져오기 (at 관리자페이지)
	public int postCount(String writer) {
		return adminDAO.postCount(writer);   
	}
		
	//7. 3) 특정한 한 회원이 쓴 댓글 수 가져오기	(at 관리자페이지)
	public int replyCount(String writer) {
		return adminDAO.replyCount(writer); 
	}

	//7. 4) 특정 회원 검색(at 관리자페이지) 
	public List<MemberDTO> searchMemberList(MemberDTO searchListMemberDTO) throws Exception {
		return adminDAO.searchMemberList(searchListMemberDTO);		
	}

	
	//8. 1) 관리자가 신고된 글 모두 리스트로 보기 (at 게시물페이지) 
	public List<ReportDTO> takeReportedPost(int page){
		
		int start = (page - 1) * page_listcnt; //한 페이지 
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		
		return adminDAO.takeReportedPost(rowBounds);
	} 
	
	// 관리자 페이지에서 본인에게 신고된 게시글 리스트에서 페이징 작업   
	public PageDTO reportedPost(int currentPage) {
		
		int countOfReportedPost = adminDAO.countOfReportedPost(); 
		
		//page_listcnt: 한 페이지당 보여주는 글의 개수, page_paginationcnt: 한 페이지당 보여주는 페이지 버튼 개수
		PageDTO pageDTO = new PageDTO(countOfReportedPost, currentPage, page_listcnt, page_paginationcnt);
				
		return pageDTO;
	}
		
	
	//1. 댓글 작성 Create 
	public AdminReplyDTO writeAdminReplyProcess(AdminReplyDTO writeReplyDTO) {
				
		AdminReplyDTO adminReplyDTO = new AdminReplyDTO();
					
		int writingCount =  adminDAO.writeAdminReplyProcess(writeReplyDTO); 
					
		if (writingCount > 0) {
			adminReplyDTO.setResult("SUCCESS");
		} else {
			adminReplyDTO.setResult("FAIL"); 
		}
					
		return adminReplyDTO;				
	}
	
	
	//2. 댓글리스트 조회 Read
	public List<AdminReplyDTO> replyAdminList(int reportNo){
		return adminDAO.adminReplyList(reportNo);
	}

			
	//3. 댓글삭제 delete
	public AdminReplyDTO removeAdminReply(int replyNo) {
				
		AdminReplyDTO adminReplyDTO = new AdminReplyDTO();
				
		int removeCount = adminDAO.removeAdminReply(replyNo); 
				
		if(removeCount > 0) { //댓글삭제 성공
			adminReplyDTO.setResult("SUCCESS");
		}else{ //댓글삭제 미성공
			adminReplyDTO.setResult("FAIL"); //대소문자가 중요합니다. 
		}
	
		return adminReplyDTO;
	}
			
		
	//1. 3) 게시판 메인화면 게시글 검색(아작스)
	public List<ReportDTO> searchList(ReportDTO searchListReportDTO, int page) throws Exception {
			
		int start = (page - 1) * page_listcnt; //한 페이지 
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
			
		List<ReportDTO> searchList = adminDAO.searchList(searchListReportDTO, rowBounds);		
		return searchList; 
	}
		
	//1. 2) 메인페이지의 페이징 작업  
	public PageDTO searchPageDTO(ReportDTO searchListReportDTO, int currentPage) {
		
		//검색을 했을 때 나오는 게시물 수 
		int searchCount = adminDAO.searchCount(searchListReportDTO);
		PageDTO searchPageDTO = new PageDTO(searchCount, currentPage, page_listcnt, page_paginationcnt);
		return searchPageDTO;
	}
		
	public int searchCount(ReportDTO searchListReportDTO) {
		int searchCount = adminDAO.searchCount(searchListReportDTO);
		return searchCount;
	}

	public String checkBoardNameInTheSameCategory(BoardDTO boardNameAndCategoryNo) {
		return adminDAO.checkBoardNameInTheSameCategory(boardNameAndCategoryNo); 
	}
	
	
}