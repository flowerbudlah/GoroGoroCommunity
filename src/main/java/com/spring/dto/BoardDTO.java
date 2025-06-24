package com.spring.dto;

import java.util.Date;

public class BoardDTO {

	private int boardNo; // 게시판의 인덱스 번호(자동으로 늘어남)
	private String boardName; // 그 게시판의 이름
	private Date CreationDate; // 게시판의 생성일(Now() is default)
	private int boardCategoryNo; // 게시판이 속한 카테고리의 인덱스 번호(외래키)
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
	public Date getCreationDate() {
		return CreationDate;
	}
	public void setCreationDate(Date creationDate) {
		CreationDate = creationDate;
	}
	public int getBoardCategoryNo() {
		return boardCategoryNo;
	}
	public void setBoardCategoryNo(int boardCategoryNo) {
		this.boardCategoryNo = boardCategoryNo;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	private String result;
	
}
