package com.spring.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.ibatis.session.RowBounds;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.dao.BoardDAO;
import com.spring.dto.PageDTO;
import com.spring.dto.PostDTO;
import com.spring.dto.ReportDTO;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class BoardService {

	// 파일 업로드시 파일이 저장되는 경로
//	@Value("${path.load}")
//	private String pathLoad;

	// 한 페이지당 보여주는 글의 개수
	@Value("${page.listcnt}")
	private int page_listcnt;

	// 한 페이지당 보여주는 페이지 버튼 개수
	@Value("${page.paginationcnt}")
	private int page_paginationcnt;

	@Autowired
	private BoardDAO boardDAO;

	// 1. 1) 게시판 메인 화면으로 이동
	public List<PostDTO> goMain(int boardNo, int page) {

		// 페이지 처리
		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);

		List<PostDTO> postList = boardDAO.goMain(boardNo, rowBounds);
		return postList;
	}

	// 1. 2) 게시판 메인 화면의 페이지 처리
	public PageDTO mainPageDTO(int boardNo, int currentPage) {

		// 게시판 메인화면의 페이지처리와 관련있는 해당 게시판의 전체 글 수
		int postCnt = boardDAO.getPostCnt(boardNo);

		// page_listcnt: 한 페이지당 보여주는 글의 개수,
		// page_paginationcnt: 한 페이지당 보여주는 페이지 버튼 개수
		PageDTO pageDTO = new PageDTO(postCnt, currentPage, page_listcnt, page_paginationcnt);
		return pageDTO;
	}

	// 1. 3) 게시판 메인화면에서 게시글 검색하기
	public List<PostDTO> searchList(PostDTO searchListPostDTO, int page) throws Exception {

		// 검색후 화면에서의 페이지 처리
		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);

		List<PostDTO> searchList = boardDAO.searchList(searchListPostDTO, rowBounds);
		return searchList;
	}

	// 1. 4) 게시글 검색 후 화면에서의 페이지 처리
	public PageDTO searchPageDTO(PostDTO searchListPostDTO, int currentPage) {

		// 아작스로 검색을 했을 때 나오는 게시물 수
		int searchCount = boardDAO.searchCount(searchListPostDTO);
		PageDTO searchPageDTO = new PageDTO(searchCount, currentPage, page_listcnt, page_paginationcnt);
		return searchPageDTO;
	}

	// 1. 5) 게시글 검색 시 검색된 게시글의 수
	public int searchCount(PostDTO searchListPostDTO) {
		int searchCount = boardDAO.searchCount(searchListPostDTO);
		return searchCount;
	}

	// 1. 6) 게시판 이름 가져오기
	public String getBoardName(int boardNo) {
		return boardDAO.getBoardName(boardNo);
	}

	// 2. 1) 글쓰기
	public PostDTO writeProcess(PostDTO writePostDTO) throws Exception {

		PostDTO postDTO = new PostDTO();

		// 이미지 파일을 업로드
		MultipartFile imageFile = writePostDTO.getImageFile();
		String UploadingImageFileName = saveUploadFile(imageFile);
		writePostDTO.setImageFileName(UploadingImageFileName);

		// 글입력
		int writingCount = boardDAO.writeProcess(writePostDTO);

		if (writingCount > 0) {
			postDTO.setResult("success");
		} else {
			postDTO.setResult("fail");
		}
		return postDTO;
	}

	// 2. 2) 이미지 파일 첨부(Imgur 서버저장)
	public String saveUploadFile(MultipartFile imageFile) {

		if (imageFile == null || imageFile.isEmpty()) {
			return null;
		}

		String clientId = "e957565cfb7c026";

		String imgurUploadUrl = "https://api.imgur.com/3/image";

		try {
			byte[] imageBytes = imageFile.getBytes();
			String base64Image = Base64.getEncoder().encodeToString(imageBytes);

			HttpPost post = new HttpPost(imgurUploadUrl);
			post.setHeader("Authorization", "Client-ID " + clientId);

			List<NameValuePair> params = new ArrayList<>();
			params.add(new BasicNameValuePair("image", base64Image));
			post.setEntity(new UrlEncodedFormEntity(params));

			try (CloseableHttpClient client = HttpClients.createDefault();
					CloseableHttpResponse response = client.execute(post)) {

				String json = EntityUtils.toString(response.getEntity());
				JSONObject jsonObj = new JSONObject(json);

				if (jsonObj.getBoolean("success")) {
					return jsonObj.getJSONObject("data").getString("link");
				} else {
					throw new IOException("Imgur upload failed: " + json);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

//		String imageFileName = imageFile.getOriginalFilename();

//		try {
//			imageFile.transferTo(new File(pathLoad + "/" + imageFileName));
//		} catch (IllegalStateException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}

//		return imageFileName;
	}

	// 3. 1) 글수정 (Update)
	public PostDTO modify(PostDTO modifyPostDTO) {

		PostDTO postDTO = new PostDTO();

		// 글을 수정하면서 이참에 새롭게 이미지를 업로드 하고자하는 경우,
		MultipartFile imageFile = modifyPostDTO.getImageFile();

		// 새롭게 업로드 하는 파일이 있다면
		if (imageFile.getSize() > 0) {
			String UploadingImageFileName = saveUploadFile(imageFile);
			modifyPostDTO.setImageFileName(UploadingImageFileName);
		}

		int updateCnt = boardDAO.modify(modifyPostDTO);

		if (updateCnt > 0) {
			postDTO.setResult("success");
		} else {
			postDTO.setResult("fail");
		}
		return postDTO;
	}

	// 3. 2) 글을 수정시 이미 업로드한 이미지 파일을 없애는 경우
	public PostDTO deleteImageFile(PostDTO imageFilePostDTO) {

		PostDTO postDTO = new PostDTO();

		int deleteImageFile = boardDAO.deleteImageFile(imageFilePostDTO);

		if (deleteImageFile > 0) {
			postDTO.setResult("success");
		} else {
			postDTO.setResult("fail");
		}
		return postDTO;
	}

	// 4. 1) 특정한 게시글 하나 읽기 Read
	public PostDTO read(int postNo) {
		PostDTO readPostDTO = boardDAO.read(postNo);
		return readPostDTO;
	}

	// 4. 2) 조회수 증가
	public void increasingViewCount(int postNo) {
		boardDAO.increasingViewCount(postNo);
	}

	// 4. 3) 좋아요 공감버튼
	public PostDTO like(int postNo) throws Exception {

		PostDTO likePostDTO = new PostDTO();

		int like = boardDAO.like(postNo);

		if (like > 0) {
			likePostDTO.setResult("success");
		} else {
			likePostDTO.setResult("fail");
		}
		return likePostDTO;
	}

	// 5. 게시글 삭제 Delete
	public PostDTO deletePost(int postNo) throws Exception {

		PostDTO postDTO = new PostDTO();

		int deleteCnt = boardDAO.deletePost(postNo);

		if (deleteCnt > 0) {
			postDTO.setResult("success");
		} else {
			postDTO.setResult("fail");
		}
		return postDTO;
	}

	// 5. 일반 게시물을 신고를 하면서, 새로운 신고내역 게시글이 만들어진다. Create
	public ReportDTO reportProcess(ReportDTO submitReportDTO) throws Exception {

		ReportDTO reportDTO = new ReportDTO();

		MultipartFile imageFile = submitReportDTO.getImageFile();
		String UploadingImageFileName = saveUploadFile(imageFile);
		submitReportDTO.setImageFileName(UploadingImageFileName);

		// 신고서 제출
		int submitCount = boardDAO.reportProcess(submitReportDTO);

		if (submitCount > 0) {
			reportDTO.setResult("success");
		} else {
			reportDTO.setResult("fail");
		}
		return reportDTO;
	}

}