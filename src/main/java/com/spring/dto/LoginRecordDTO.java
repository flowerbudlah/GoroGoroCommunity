package com.spring.dto;

import java.util.Date;

public class LoginRecordDTO {
	
	private int loginRecordNo;
	private int memberNo;
	private String email;
	private String nick;
	private Date loginRecordRealTime;
	public int getLoginRecordNo() {
		return loginRecordNo;
	}
	public void setLoginRecordNo(int loginRecordNo) {
		this.loginRecordNo = loginRecordNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
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
	public Date getLoginRecordRealTime() {
		return loginRecordRealTime;
	}
	public void setLoginRecordRealTime(Date loginRecordRealTime) {
		this.loginRecordRealTime = loginRecordRealTime;
	}

}