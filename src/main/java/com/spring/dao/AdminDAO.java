package com.spring.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.dto.AdminReplyDTO;
import com.spring.dto.BoardDTO;
import com.spring.dto.FlagDTO;
import com.spring.dto.LoginRecordDTO;
import com.spring.dto.MemberDTO;
import com.spring.dto.ReportDTO;

@Repository
public class AdminDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	// 1. 1) 게시판 대분류(카테고리) 생성 (Create a Category)
	public int makeCategory(String boardCategoryName) {
		return sqlSessionTemplate.insert("admin.makeCategory", boardCategoryName);
	}

	// 1. 2) 게시판 대분류(카테고리) 이름의 중복체크 
	public String checkCategory(String categoryName) {
		return sqlSessionTemplate.selectOne("admin.checkCategory", categoryName);
	}

	// 1. 3) 게시판 대분류(카테고리)에 속하는 게시판 생성
	public int makeBoard(BoardDTO BoardDTOinCategory) {
		return sqlSessionTemplate.insert("admin.makeBoard", BoardDTOinCategory);
	}

	// 1. 4) 게시판 이름 변경 Updating
	public int changeBoardName(BoardDTO boardDTOinCategory) {
		return sqlSessionTemplate.update("admin.changeBoardName", boardDTOinCategory);
	}

	// 1. 5) 게시판 이름 중복체크
	public String checkBoardNameInTheSameCategory(BoardDTO boardNameAndCategoryNo) {
		return sqlSessionTemplate.selectOne("admin.checkSameBoardName", boardNameAndCategoryNo);
	}

	// 1. 6) 게시판 대분류(카테고리) 삭제
	public int deleteCategory(int boardCategoryNo) {
		return sqlSessionTemplate.delete("admin.deleteCategory", boardCategoryNo);
	}

	// 1. 7) 게시판 대분류(카테고리)에 속한 게시판 삭제
	public int deleteBoard(int boardNo) {
		return sqlSessionTemplate.delete("admin.deleteBoard", boardNo);
	}

	// 1. 8) 게시판이 속한 카테고리 변경
	public int changeCategory(BoardDTO boardDTOinCategory) {
		return sqlSessionTemplate.update("admin.changeCategory", boardDTOinCategory);
	}

	// 2. 1) 회원목록 가져오기
	public List<MemberDTO> takeMemberList() {
		return sqlSessionTemplate.selectList("admin.takeMemberList");
	}

	// 2. 2) 특정회원이 작성한 글의 수 가져오기
	public int postCount(String writer) {
		return sqlSessionTemplate.selectOne("admin.postCount", writer);
	}

	// 2. 3) 특정회원이 쓴 댓글 수 가져오기
	public int replyCount(String writer) {
		return sqlSessionTemplate.selectOne("admin.postReply", writer);
	}

	// 2. 4) 관리자의 회원검색(with using a Ajax)
	public List<MemberDTO> searchMemberList(MemberDTO searchListMemberDTO) throws Exception {
		return sqlSessionTemplate.selectList("admin.searchMemberList", searchListMemberDTO);
	}

	// 2. 5) 관리자가 신고된 게시물보기
	public List<ReportDTO> takeReportedPost(RowBounds rowBounds) {
		return sqlSessionTemplate.selectList("admin.takeReportedPost", rowBounds);
	}

	// 2. 6) 특정회원이 작성한 글 중엥서 신고된 게시글의 수 가져오기
	public int countOfReportedPost() {
		return sqlSessionTemplate.selectOne("admin.countOfReportedPost");
	}

	// 2. 7) 특정회원(닉네임으로 검색)에 대한 로그인 실시간 기록 가져오기
	public List<LoginRecordDTO> takeLoginRecord(String nick) {
		return sqlSessionTemplate.selectList("admin.takeLoginRecord", nick);
	}
	
	// 2. 8) 회원일시정지 시키기 
	public int makeIdSuspend(String email) {
		return sqlSessionTemplate.update("admin.makeIdSuspend", email);
	}

	// 2. 9) 일시정지된 회원을 살리기, 활성화시키기
	public int makeIdActive(String email) {
		return sqlSessionTemplate.update("admin.makeIdActive", email);
	}

	// 3. 1) 관리자가 해당 신고글에 댓글 답변다는 것
	public int writeAdminReplyProcess(AdminReplyDTO writeAdminReplyDTO) {
		return sqlSessionTemplate.insert("admin.writeAdminReplyProcess", writeAdminReplyDTO);
	}

	// 3. 2) 관리자가 신고서에 쓴 댓글 목록 가져오기
	public List<AdminReplyDTO> adminReplyList(int reportNo) {
		return sqlSessionTemplate.selectList("admin.adminReplyList", reportNo);
	}

	// 3. 3) 관리자가 신고서에 쓴 댓글을 삭제
	public int removeAdminReply(int reportNo) {
		return sqlSessionTemplate.delete("admin.removeAdminReply", reportNo);
	}

	// 3. 4) 신고보고서 메인 게시판에서 글 검색
	public List<ReportDTO> searchList(ReportDTO searchListReportDTO, RowBounds rowBounds) throws Exception {
		List<ReportDTO> searchList = sqlSessionTemplate.selectList("admin.searchList", searchListReportDTO, rowBounds);
		return searchList;
	}

	// 3. 5) 신고보고서 메인 게시판에서 검색시 검색결과 게시글 수 (아작스로 검색시 아작스로 페이징 작업때문에 필요)
	public int searchCount(ReportDTO searchListReportDTO) {
		int searchCount = sqlSessionTemplate.selectOne("admin.searchCount", searchListReportDTO);
		return searchCount;
	}

	// 3. 6) 관리자에 의한 신고된 게시글에 대해 유효한 경고(flag)를 증가시키는 처리
	public int increaseFlag(FlagDTO flagDTO) {
		return sqlSessionTemplate.insert("admin.increaseFlag", flagDTO);
	}

	// 3. 7) 해당 글이 이미 신고되어 유효한 경고(flag)를 받은경우인지 체크
	public String checkFlagedAlready(int postNo) {
		return sqlSessionTemplate.selectOne("admin.checkFlagedAlready", postNo);
	}

}