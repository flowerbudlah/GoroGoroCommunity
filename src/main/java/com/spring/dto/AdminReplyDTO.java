package com.spring.dto;

import java.util.Date;

public class AdminReplyDTO {

	private int replyNo; // 댓글 번호
	private int reportNo; // 댓글이 달린 신고게시글 번호
	private String replyContent; // 댓글 내용
	private String replyWriter; // 댓글 작성자
	private Date replyRegDate; // 댓글 작성일 Now()
	private String result; // 댓글 작성의 성공여부를 알려주는 그 결과
	
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public int getReportNo() {
		return reportNo;
	}
	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getReplyWriter() {
		return replyWriter;
	}
	public void setReplyWriter(String replyWriter) {
		this.replyWriter = replyWriter;
	}
	public Date getReplyRegDate() {
		return replyRegDate;
	}
	public void setReplyRegDate(Date replyRegDate) {
		this.replyRegDate = replyRegDate;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}

}