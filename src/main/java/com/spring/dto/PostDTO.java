package com.spring.dto;

import java.util.Date;
import org.springframework.web.multipart.MultipartFile;

public class PostDTO {
	
	private int boardNo; //게시판 자체의 번호
	private String boardName; 

	private int postNo; //글 번호
	private String title; //글 제목
	private String content; //글 내용
	private String writer; //작성자
	
	private Date regDate; //글 작성일
	
	private int viewCount; //조회수
	private  int sameThinking; //좋아요 공감버튼! 
	private int replyCount; //해당 글의 댓글 수 

	private String result; // 게시글 작성의 성공여부를 알려주는 결과변수
		
	private String keyword; // 키워드 
	private String type; // 검색종류

	private String imageFileName; // 업로드한 사진의 이름
	private MultipartFile imageFile; // 업로드한 사진파일
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getSameThinking() {
		return sameThinking;
	}
	public void setSameThinking(int sameThinking) {
		this.sameThinking = sameThinking;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public MultipartFile getImageFile() {
		return imageFile;
	}
	public void setImageFile(MultipartFile imageFile) {
		this.imageFile = imageFile;
	}

}