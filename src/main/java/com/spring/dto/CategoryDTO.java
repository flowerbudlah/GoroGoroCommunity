package com.spring.dto;

import java.util.Date;

public class CategoryDTO {

	private int boardCategoryNo; // 게시판 대분류 카테고리 번호
	private String boardCategoryName; // 대분류 카테고리 이름 (x. 프로그래밍, 외국어, 기타)
	private Date creationDate; // 대분류 카테고리 만든날
	
	private String result;

	public int getBoardCategoryNo() {
		return boardCategoryNo;
	}

	public void setBoardCategoryNo(int boardCategoryNo) {
		this.boardCategoryNo = boardCategoryNo;
	}

	public String getBoardCategoryName() {
		return boardCategoryName;
	}

	public void setBoardCategoryName(String boardCategoryName) {
		this.boardCategoryName = boardCategoryName;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
}