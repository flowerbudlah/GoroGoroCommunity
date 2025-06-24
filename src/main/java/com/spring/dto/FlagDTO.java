package com.spring.dto;

public class FlagDTO {

	private int flagNo;  
	// 해당 플래그의 주인
	private int memberNo;
	// 유효한 신고의 게시글
	private int postNo;
	// 해당 신고번호
	private int reportNo;
	// 최초 신고자
	private  String reporter;
	
	private String result;

	public int getFlagNo() {
		return flagNo;
	}

	public void setFlagNo(int flagNo) {
		this.flagNo = flagNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}

	public String getReporter() {
		return reporter;
	}

	public void setReporter(String reporter) {
		this.reporter = reporter;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	} 
	
}