package com.spring.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.dao.MyPageDAO;
import com.spring.dto.PageDTO;
import com.spring.dto.PostDTO;
import com.spring.dto.ReportDTO;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class MyPageService {

	@Value("${page.listcnt}")
	private int page_listcnt; // 한 페이지당 보여주는 글의 개수

	@Value("${page.paginationcnt}")
	private int page_paginationcnt; // 한 페이지당 보여주는 페이지 버튼 개수

	@Autowired
	private MyPageDAO myPageDAO;

	@Autowired
	private BoardService boardService;

	// 1. 회원들의 신고기록문 (신고내역) 목록
	public List<ReportDTO> takeMyReportedPost(String reporter, int page) {

		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);

		return myPageDAO.takeMyReportedPost(reporter, rowBounds);
	}

	// 2. 신고기록 게시판(신고기록문이 모여있는 게시판)의 페이지 처리
	public PageDTO mainPageDTO(String reporter, int currentPage) {

		// 전체 신고글 수
		int reportCnt = myPageDAO.getReportCnt(reporter);

		// page_listcnt: 한 페이지당 보여주는 글의 개수(10),
		// page_paginationcnt: 한 페이지당 보여주는 페이지 버튼 개수(아마, 10개로 이전 1 2 3 4 5 6 7 8 9 10 이후)
		PageDTO pageDTO = new PageDTO(reportCnt, currentPage, page_listcnt, page_paginationcnt);
		return pageDTO;
	}

	// 3. 신고한 게시글 중 특정 게시물 검색하기(페이지 처리 완료)
	public List<PostDTO> searchReportList(ReportDTO searchListReportDTO, int page) throws Exception {

		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);

		List<PostDTO> searchReportList = myPageDAO.searchReportList(searchListReportDTO, rowBounds);
		return searchReportList;
	}

	// 4. 신고내역 게시판에서 검색시 페이지 처리
	public PageDTO searchReportPageDTO(ReportDTO searchListReportDTO, int currentPage) {

		// 아작스로 검색을 했을 때 나오는 게시물 수
		int searchReportCount = myPageDAO.searchReportCount(searchListReportDTO);
		PageDTO searchReportPageDTO = new PageDTO(searchReportCount, currentPage, page_listcnt, page_paginationcnt);
		return searchReportPageDTO;
	}

	// 5. 신고한 건 페이지 시 신고한
	public int searchReportCount(ReportDTO searchListReportDTO) {
		int searchReportCount = myPageDAO.searchReportCount(searchListReportDTO);
		return searchReportCount;
	}

	// 7. 2) 신고된 특정한 글 하나 보기(신고의 구체적인 사유)
	public ReportDTO readReportDTO(int reportNo) {
		ReportDTO readReportDTO = myPageDAO.readReportDTO(reportNo);
		return readReportDTO;
	}

	// 신고내역 게시글 수정하기
	public ReportDTO modify(ReportDTO modifyReportDTO) {

		ReportDTO reportDTO = new ReportDTO();

		// 글을 수정하면서 이참에 새롭게 이미지를 업로드 하고자 하는 경우
		MultipartFile imageFile = modifyReportDTO.getImageFile();

		// 원글에서 업로드 된 파일이 있다면
		if (imageFile.getSize() > 0) {
			String UploadingImageFileName = boardService.saveUploadFile(imageFile);
			modifyReportDTO.setImageFileName(UploadingImageFileName);
		}

		int successOrFail = myPageDAO.modifyReportTO(modifyReportDTO);

		// 수정 성공
		if (successOrFail > 0) {
			reportDTO.setResult("success");

			// 수정 실패
		} else {
			reportDTO.setResult("fail");
		}

		return reportDTO;
	}

	// 신고내역 게시글을 수정하는데 그냥 이미지 파일을 삭제려는 경우
	public ReportDTO deleteImageFile(ReportDTO imageFileReportDTO) {

		ReportDTO reportDTO = new ReportDTO();

		int deleteImageFile = myPageDAO.deleteImageFile(imageFileReportDTO);

		if (deleteImageFile > 0) {
			reportDTO.setResult("success");
		} else {
			reportDTO.setResult("fail");
		}

		return reportDTO;
	}

	// 오직 신고자만 신고게시글 삭제가능
	public ReportDTO deleteReportDTO(int reportNo) throws Exception {

		ReportDTO reportDTO = new ReportDTO();

		int deleteCnt = myPageDAO.deleteReportDTO(reportNo);

		if (deleteCnt > 0) {
			reportDTO.setResult("success");
		} else {
			reportDTO.setResult("fail");
		}

		return reportDTO;

	}

	// 마이 페이지에서 내가 쓴 게시글 검색 시
	public List<PostDTO> searchList(PostDTO searchListPostDTO, int page) throws Exception {

		// 내가 쓴 총 게시글의 수
		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		List<PostDTO> searchList = myPageDAO.searchList(searchListPostDTO, rowBounds);
		return searchList;
	}

	// 마이 페이지에서 내가 쓴 게시글 검색 시 메인페이지의 페이징 작업
	public PageDTO searchPageDTO(PostDTO searchListPostDTO, int currentPage) {

		// 아작스로 검색을 했을 때 나오는 게시물 수, ex. 2건의 게시글이 검색되었습니다.
		int searchCount = myPageDAO.searchCount(searchListPostDTO);
		PageDTO searchPageDTO = new PageDTO(searchCount, currentPage, page_listcnt, page_paginationcnt);
		return searchPageDTO;
	}

	public int searchCount(PostDTO searchListPostDTO) {
		int searchCount = myPageDAO.searchCount(searchListPostDTO);
		return searchCount;
	}

	// 6. 1) 내가 쓴 게시물 리스트들 보기 (관리자 페이지에서 )
	public List<PostDTO> goMyPosts(int memberNo, int page) {

		int start = (page - 1) * page_listcnt; // 한 페이지
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		List<PostDTO> myPostList = myPageDAO.goMyPosts(memberNo, rowBounds);

		return myPostList;
	}

	// 6. 2) 메인페이지의 페이징 작업
	public PageDTO takeCountOfMyPost(int memberNo, int currentPage) {
		// 게시판 메인 페이지의 페이징과 관련있는 해당 게시판의 전체 글 수
		int countOfMyPost = myPageDAO.takeCountOfMyPost(memberNo);

		PageDTO pageDTO = new PageDTO(countOfMyPost, currentPage, page_listcnt, page_paginationcnt);

		return pageDTO;
	}

}
