package com.spring.dto;

import java.util.Date;

public class MemberDTO {

	private int memberNo; // 회원일련번호

	private String accountStatus; // 회원계정의 상태(일시정지상태 Suspend, 활성화상태 Active)
	private Date suspensionEndDate; // 정지기간
	
	private String email; // 이메일(ID)
	private String nick; // 대화명

	private String passwords; // 비밀번호
	private String passwordsConfirm; // 위 비밀번호 확인변수

	private String question; // 아이디 비밀번호 분실시 질문
	private String answer; // 아이디 비밀번호 분실시 답(위 질문에 대한 답)

	private Date signUpDate; // 가입일
	private String signUp_Date;

	private Date finalSignInDate; // 최종로그인 날짜
	private String finalSignIn_Date;

	private String result; // 회원가입 성공여부를 할려주는 결과변수

	private int postCount; // 특정한 회원이 쓴 글의 수
	private int replyCount; // 특정한 회원이 쓴
	
	private int reportCount; // 이 회원이 신고당한 건수
	private int reportedPost; // 이 회원이 신고당한 
	
	private int flagCount; // 이 회원이 받은 경고플래그

	private String keyword; // 키워드 (관리자페이지)
	private String type; // 검색종류 (관리자페이지)
	
	private boolean signIn; // 로그인이 된상태면 이것이 true, 로그인이 안된상태면 false

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getAccountStatus() {
		return accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}

	public Date getSuspensionEndDate() {
		return suspensionEndDate;
	}

	public void setSuspensionEndDate(Date suspensionEndDate) {
		this.suspensionEndDate = suspensionEndDate;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getPasswords() {
		return passwords;
	}

	public void setPasswords(String passwords) {
		this.passwords = passwords;
	}

	public String getPasswordsConfirm() {
		return passwordsConfirm;
	}

	public void setPasswordsConfirm(String passwordsConfirm) {
		this.passwordsConfirm = passwordsConfirm;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Date getSignUpDate() {
		return signUpDate;
	}

	public void setSignUpDate(Date signUpDate) {
		this.signUpDate = signUpDate;
	}

	public String getSignUp_Date() {
		return signUp_Date;
	}

	public void setSignUp_Date(String signUp_Date) {
		this.signUp_Date = signUp_Date;
	}

	public Date getFinalSignInDate() {
		return finalSignInDate;
	}

	public void setFinalSignInDate(Date finalSignInDate) {
		this.finalSignInDate = finalSignInDate;
	}

	public String getFinalSignIn_Date() {
		return finalSignIn_Date;
	}

	public void setFinalSignIn_Date(String finalSignIn_Date) {
		this.finalSignIn_Date = finalSignIn_Date;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public int getPostCount() {
		return postCount;
	}

	public void setPostCount(int postCount) {
		this.postCount = postCount;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public int getReportCount() {
		return reportCount;
	}

	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}

	public int getReportedPost() {
		return reportedPost;
	}

	public void setReportedPost(int reportedPost) {
		this.reportedPost = reportedPost;
	}

	public int getFlagCount() {
		return flagCount;
	}

	public void setFlagCount(int flagCount) {
		this.flagCount = flagCount;
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

	public boolean isSignIn() {
		return signIn;
	}

	public void setSignIn(boolean signIn) {
		this.signIn = signIn;
	}
	
	
}