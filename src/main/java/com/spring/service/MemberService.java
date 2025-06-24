package com.spring.service;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.spring.dao.AdminDAO;
import com.spring.dao.MemberDAO;
import com.spring.dto.LoginRecordDTO;
import com.spring.dto.MemberDTO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private AdminDAO adminDAO;
	
	@Resource(name = "signInMemberDTO")
	@Lazy
	private MemberDTO signInMemberDTO;

	// 1. 1) 회원가입(새로운 회원의 탄생) Create
	public MemberDTO signUpProcess(MemberDTO signUpMemberDTO) {

		MemberDTO newMemberDTO = new MemberDTO();
		int signUp = memberDAO.signUpProcess(signUpMemberDTO);

		if (signUp > 0) {
			newMemberDTO.setResult("success");
		} else {
			newMemberDTO.setResult("fail");
		}
		return newMemberDTO;
	}

	// 1. 2) 회원가입 시 (아이디 용)이메일 중복체크
	public String checkEmail(String email) {
		return memberDAO.checkEmail(email);
	}

	// 1. 3) 대화명(닉네임) 중복 체크 (회원가입시 회원정보수정시 모두 해당됨)
	public String checkNick(String nick) {
		return memberDAO.checkNick(nick);
	}

	// 2. Sign In(로그인)
	public void signIn(MemberDTO tmpSignInMemberDTO) {

		MemberDTO memberDTOfromDB = memberDAO.signIn(tmpSignInMemberDTO); // 아이디와 비밀번호로 로그인
	
		// 로그인을 했더니, DB애 정보가 있다. 로그인 가능
		if (memberDTOfromDB != null) {

			// 아이디가 정지먹힌 경우가 아닌경우
			if (memberDTOfromDB.getAccountStatus().equalsIgnoreCase("active")) {
				
				signInMemberDTO.setMemberNo(memberDTOfromDB.getMemberNo()); // 로그인한 회원의 회원번호
				signInMemberDTO.setEmail(memberDTOfromDB.getEmail()); // 로그인한 회원의 아이디 이메일
				signInMemberDTO.setPasswords(memberDTOfromDB.getPasswords()); // 로그인한 회원의 패스워드
				signInMemberDTO.setNick(memberDTOfromDB.getNick()); // 로그인한 회원의 대화명
					
				signInMemberDTO.setSignIn(true); // 로그인 성공하니 sign in이 false에서 true로 바뀝니다.
					
				LoginRecordDTO realTimeLoginRecordDTO = new LoginRecordDTO();
				realTimeLoginRecordDTO.setMemberNo(signInMemberDTO.getMemberNo());
				realTimeLoginRecordDTO.setEmail(signInMemberDTO.getEmail());
				realTimeLoginRecordDTO.setNick(memberDTOfromDB.getNick());
					
				// 회원이 로그인을 하면, 그 로그인을 한 시각이 기록된다.
				memberDAO.recordRealTimeLogin(realTimeLoginRecordDTO);

			// 정지 먹힌 경우
			} else if (memberDTOfromDB.getAccountStatus().equalsIgnoreCase("suspend")){

				// 정지기간이 남은 경우
				if(memberDTOfromDB.getSuspensionEndDate().after(new Date())){
					
					System.out.println(memberDTOfromDB.getAccountStatus()); 

					signInMemberDTO.setAccountStatus(memberDTOfromDB.getAccountStatus());
					signInMemberDTO.setSuspensionEndDate(memberDTOfromDB.getSuspensionEndDate());
					
				// 정지기간이 끝난경우
				} else {
					
					signInMemberDTO.setMemberNo(memberDTOfromDB.getMemberNo()); // 로그인한 회원의 회원번호
					signInMemberDTO.setEmail(memberDTOfromDB.getEmail()); // 로그인한 회원의 아이디 이메일
					signInMemberDTO.setPasswords(memberDTOfromDB.getPasswords()); // 로그인한 회원의 패스워드
					signInMemberDTO.setNick(memberDTOfromDB.getNick()); // 로그인한 회원의 대화명
					
					// 정지기간이 끝났기에 suspend를 active로 바꾼다. 
					signInMemberDTO.setAccountStatus("active");
					// 정지풀고, 기간없애야함. 
					adminDAO.makeIdActive(memberDTOfromDB.getEmail());
					
					signInMemberDTO.setSignIn(true); // 로그인 성공하니 sign in이 false에서 true로 바뀝니다.
						
					LoginRecordDTO realTimeLoginRecordDTO = new LoginRecordDTO();
					realTimeLoginRecordDTO.setMemberNo(signInMemberDTO.getMemberNo());
					realTimeLoginRecordDTO.setEmail(signInMemberDTO.getEmail());
					realTimeLoginRecordDTO.setNick(memberDTOfromDB.getNick());
					// 회원이 로그인을 하면, 그 로그인을 한 시각이 기록된다.
					memberDAO.recordRealTimeLogin(realTimeLoginRecordDTO);
					
				}
				
			}
			
		// 로그인을 했더니, DB애 정보가 없다. 로그인 불가
		} else if (memberDTOfromDB == null) { 

			signInMemberDTO.setSignIn(false);
			signInMemberDTO.setAccountStatus("unknown");
		}
	}

	// 3. 1) 회원정보를 수정하고자하는 경우,
	public void takeMemberDTO(MemberDTO modifyMemberDTO) {

		// 수정하고자하는 회원 정보를 가져오기.
		MemberDTO fromDBMemberDTO = memberDAO.takeMemberDTO(signInMemberDTO.getMemberNo());

		modifyMemberDTO.setEmail(fromDBMemberDTO.getEmail());
		modifyMemberDTO.setPasswords(fromDBMemberDTO.getPasswords());
		modifyMemberDTO.setPasswordsConfirm(fromDBMemberDTO.getPasswordsConfirm());
		modifyMemberDTO.setNick(fromDBMemberDTO.getNick());
		modifyMemberDTO.setQuestion(fromDBMemberDTO.getQuestion());
		modifyMemberDTO.setAnswer(fromDBMemberDTO.getAnswer());
		modifyMemberDTO.setMemberNo(signInMemberDTO.getMemberNo());

	}

	// 3. 2) 회원정보 수정하기(Update)
	public MemberDTO modifyMemberDTO(MemberDTO modifyMemberDTO) {

		MemberDTO memberDTO = new MemberDTO();

		int successOrFail = memberDAO.modifyMemberDTO(modifyMemberDTO);
		
		// 회원정보 수정 성공
		if (successOrFail > 0) { 
			
			signInMemberDTO.setNick(modifyMemberDTO.getNick());
			memberDTO.setResult("success");
		
		// 회원정보 수정 실패
		} else { 
			memberDTO.setResult("fail");
		}
		
		return memberDTO;
	}

	// 4. 회원탈퇴하기(Delete)
	public MemberDTO deleteAccount(MemberDTO memberDTOisLeaving) throws Exception {

		MemberDTO memberDTO = new MemberDTO();

		int leaveCount = memberDAO.deleteAccount(memberDTOisLeaving);

		// 탈퇴 성공
		if (leaveCount > 0) {
			memberDTO.setResult("success");
		// 탈퇴 실패
		} else {
			memberDTO.setResult("fail");
		}
		return memberDTO;
	}

	// 5. 1) 이메일(ID)을 분실했을경우, 사용하던 닉네임을 입력한 뒤에 본인 확인을 위한 질문을 보여준다.
	public MemberDTO takeQuestion(String nick) {

		MemberDTO toFindEmail = memberDAO.takeQuestion(nick);
		return toFindEmail;
	}

	// 5. 2) 잊어버린 이메일(ID)을 찾기위해서 닉네임과 질문에 대한 정답을 입력
	public String findEmail(MemberDTO memberDTOtoFindEmail) {

		String email = memberDAO.findEmail(memberDTOtoFindEmail);
		return email;
	}

	// 5. 3) 잊어버린 비밀번호를 찾기위한 첫번째 절차로 아이디인 이메일을 입력  
	public MemberDTO findPasswords(String email) {

		MemberDTO toFindPasswords = memberDAO.findPasswords(email);
		return toFindPasswords;
	}

	// 5. 4) 회원의 이메일로 보낼 임시비밀번호(Temporary Password)를 DB에 반영한다.
	public void makeTemporaryPasswords(MemberDTO tempPasswords) {
		memberDAO.makeTemporaryPasswords(tempPasswords);
	}

}