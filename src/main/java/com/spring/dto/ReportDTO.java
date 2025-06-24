package com.spring.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class ReportDTO {

	private int reportNo; // 신고번호
	private String reason; // 신고사유(제목)
	private String detail; // 신고상세사유(내용)
	private String reporter; // 신고자(글쓴이)
	private Date reportDate; // 신고일(작성일)

	private int postNo; // 신고대상 글번호
	private int memberNo; // 신고대상 글을 쓴사람

	private String imageFileName; // 증거자료 이름(첨부파일 이름)
	private MultipartFile imageFile; // 업로드한 사진파일

	private String result;

	private int replyCount; // 신고보고서에 쓴 댓글 

	private String keyword; // 키워드(검색시 사용)
	private String type; // 검색종류(검색시 사용)
	
	public int getReportNo() {
		return reportNo;
	}
	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public Date getReportDate() {
		return reportDate;
	}
	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
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
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
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
	
}