package com.spring.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.dto.LoginRecordDTO;
import com.spring.dto.MemberDTO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	// 1. 1) 회원가입
	public int signUpProcess(MemberDTO signUpMemberDTO) {
		return sqlSessionTemplate.insert("member.signUpProcess", signUpMemberDTO);
	}

	// 1. 2) 이메일(ID) 중복체크
	public String checkEmail(String email) {
		return sqlSessionTemplate.selectOne("member.checkEmail", email);
	}

	// 1. 3) 대화명 중복체크
	public String checkNick(String nick) {
		return sqlSessionTemplate.selectOne("member.checkNick", nick);
	}

	// 2. 1) 로그인 (Sign In)
	public MemberDTO signIn(MemberDTO tmpSignInMemberDTO) {
		return sqlSessionTemplate.selectOne("member.signIn", tmpSignInMemberDTO);
	}

	// 2. 2) 로그인을 할때마다 로그인시간이 기록
	public int recordRealTimeLogin(LoginRecordDTO realTimeLoginRecordDTO) {
		return sqlSessionTemplate.insert("member.recordRealTimeLogin", realTimeLoginRecordDTO);
	}

	// 3. 1) 수정할 회원정보 가져오기
	public MemberDTO takeMemberDTO(int memberNo) {
		MemberDTO fromDBMemberDTO = sqlSessionTemplate.selectOne("member.takeMemberDTO", memberNo);
		return fromDBMemberDTO;
	}

	// 3. 2) 회원정보 수정
	public int modifyMemberDTO(MemberDTO modifyMemberDTO) {
		return sqlSessionTemplate.update("member.modifyMemberDTO", modifyMemberDTO);
	}

	// 4. 회원 본인이 원해서 회원탈퇴
	public int deleteAccount(MemberDTO memberDTOtodeleteAccount) {
		return sqlSessionTemplate.delete("member.leave", memberDTOtodeleteAccount);
	}

	// 5. 1) 이메일(ID)을 분실했을경우, 사용하던 닉네임을 입력한 뒤에 질문을 보여준다.
	public MemberDTO takeQuestion(String nick) {
		return sqlSessionTemplate.selectOne("member.takeQuestion", nick);
	}

	// 5. 2) 위 질문에 대한 알맞은 응답을 하면 이메일(ID)을 알려준다. 
	public String findEmail(MemberDTO memberDTOtoFindEmail) {
		return sqlSessionTemplate.selectOne("member.findEmail", memberDTOtoFindEmail);
	}

	// 6. 1) 비밀번호를 분실했을때  
	public MemberDTO findPasswords(String email) {
		return sqlSessionTemplate.selectOne("member.findPasswords", email);
	}

	// 6. 2) 이메일로 보낼 임시비밀번호를 DB에 반영한다.
	public int makeTemporaryPasswords(MemberDTO tempPasswords) {
		return sqlSessionTemplate.update("member.makeTemporaryPasswords", tempPasswords);
	}

}