package com.spring.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {

	private int boardNo; // 게시판의 인덱스 번호(자동으로 늘어남)
	private String boardName; // 그 게시판의 이름
	private Date CreationDate; // 게시판의 생성일(Now() is default)
	private int boardCategoryNo; // 게시판이 속한 카테고리의 인덱스 번호(외래키)
	private String result;

}
