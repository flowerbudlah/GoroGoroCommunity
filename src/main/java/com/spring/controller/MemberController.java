package com.spring.controller;
import java.util.UUID;

import javax.annotation.Resource;

import java.io.IOException;
import java.util.Properties;

import javax.mail.*;

import javax.mail.Message;
import javax.mail.MessagingException;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.dto.MemberDTO;
import com.spring.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Lazy
	@Resource(name = "signInMemberDTO")
	private MemberDTO signInMemberDTO;

	// 1. 1) 회원가입 페이지로 이동 Going to the Sign-up Page. 
	@RequestMapping("/signUp")
	public String signUp() {
		return "member/signUp";
	}

	// 1. 2) 이메일(ID) 중복체크(in 회원가입 페이지) Duplication Checking of ID
	@RequestMapping("/checkEmail")
	public @ResponseBody String checkEmail(String email) {

		String result = memberService.checkEmail(email);
		
		if (result == null) {
			
			return "available";

		} else {

			return "unavailable";

		}
	}

	// 1. 3) 닉네임 중복체크(in 회원가입 페이지) Duplication Checking of Nick
	@RequestMapping("/checkNick")
	public @ResponseBody String checkNick(String nick) {
		String result = memberService.checkNick(nick);
		
		if (result == null) {
			return "available";
		
		} else {
			return "unavailable";
		}
	}

	// 1. 4) 회원가입 완료버튼 누르고 회원가입 하기(in 회원가입 페이지) Signing up after press the button of completing signing-up.  
	@RequestMapping("/signUpProcess")
	public @ResponseBody MemberDTO signUpProcess(MemberDTO signUpMemberDTO) {

		// 새로운 회원의 탄생
		MemberDTO newMemberDTO = memberService.signUpProcess(signUpMemberDTO);
		return newMemberDTO;
	}

	// 2. 1) 회원정보 수정페이지로 이동 Going to the modification of user's information.
	@GetMapping("/modify")
	public String modify(@ModelAttribute("modifyMemberDTO") MemberDTO modifyMemberDTO) {

		// 회원정보를 수정할 대상을 가져온다.
		memberService.takeMemberDTO(modifyMemberDTO);
		return "member/modify";
	}

	// 2. 2) 닉네임 중복체크(in 회원정보수정 페이지) Duplication Checking of Nick
	@RequestMapping("/checkNickInModify")
	public @ResponseBody String checkNickInModify(String nick) {

		String result = memberService.checkNick(nick);

		// 사용하고싶은 새로운 닉네임을 넣어봤더니 사용하고 있는 사람이 없다.
		if (result == null) {

			// 그 닉네임은 사용가능
			return "available";

		// 사용하고 싶은 새로운 닉네임을 넣어봤더니 사용하고 있는 사람이 있는 경우
		} else {
			
			// 새롭게 사용하고 싶은 닉네임으로 입력한 값 = 이미 내가 현재 사용하고있는 닉네임인 경우  
			if (result.equalsIgnoreCase(signInMemberDTO.getNick())) {
				
				// 사용가능
				return "available";
				
			} else {
				
				// 사용불가
				return "unavailable"; 
			}

		}
	}

	// 2. 3) 회원정보수정 완료 버튼 누르고, 회원정보 수정이 이뤄지는 그 과정 The process of modifying user information after clicking the button. 
	@RequestMapping("/modifyProcess")
	public @ResponseBody MemberDTO modifyMemberDTO(MemberDTO modifyMemberDTO) {

		// 회원정보를 수정한 뒤에 수정을 완료한 새로운 memberDTO를 가져온다.
		MemberDTO memberDTOAfter = memberService.modifyMemberDTO(modifyMemberDTO);
		return memberDTOAfter;
	}

	// 3. 1) 로그인 페이지로 입장 (Going to the Sign-in Page.)
	@RequestMapping("/signIn")
	public String signIn() {
		return "member/signIn";
	}

	// 3. 2) 로그인 버튼을 누르고 로그인 성공
	@PostMapping("/signInProcess")
	public void signInProcess
	(HttpServletRequest request, HttpServletResponse response, MemberDTO tmpSignInMemberDTO) throws IOException {

		// 로그인 시도
		memberService.signIn(tmpSignInMemberDTO);

		// 이것은 로그인이 성공했다는 의미
		if(signInMemberDTO.isSignIn() == true) {

			response.getWriter().write("loginSuccess");

		// 회원이 현재 일시정지된 상태인 경우
		} else if(signInMemberDTO.getAccountStatus().equalsIgnoreCase("suspend") && (signInMemberDTO.isSignIn() == false)) {	
			
			response.getWriter().write("Sign-in will be suspended until "+ signInMemberDTO.getSuspensionEndDate());

		// 이것은 로그인 실패
		} else if (signInMemberDTO.isSignIn() == false) {
			
			response.getWriter().write("loginFail");
		}
	}

	// 4. 로그아웃(Sign Out)
	@RequestMapping("/signOut")
	public @ResponseBody void signOut(HttpSession session) {
		
		// 로그인 풀리고
		signInMemberDTO.setSignIn(false); 
		// 세션 종료
		session.invalidate(); 
	}

	// 5. 1) 회원탈퇴 페이지로 이동 Going to membership withdrawal page
	@RequestMapping("/getOut")
	public String getOut() {
		return "member/getOut";
	}

	// 5. 2) 회원본인이 원해서 회원탈퇴(with 아작스) Account Deletion 
	@RequestMapping("/DeleteAccount")
	public @ResponseBody MemberDTO deleteAccount(MemberDTO memberDTOisLeaving) throws Exception {

		MemberDTO memberDTO = memberService.deleteAccount(memberDTOisLeaving);
		return memberDTO;
	}

	// 6. 1) 이메일 분실시 이메일 찾는 페이지로 이동
	@RequestMapping("/findEmail")
	public String fineEmail() {
		return "member/findEmail";
	}

	// 6 .2) 이메일(ID)을 분실했을경우, 사용하던 닉네임을 입력한 뒤에 잊어버린 이메일(ID)을 찾기위한 질문을 보여준다.
	@GetMapping("/takeQuestion")
	public @ResponseBody MemberDTO takeQuestion(@RequestParam("nick") String nick, Model model) {

		MemberDTO toFindEmail = memberService.takeQuestion(nick);
		model.addAttribute("toFindEmail", toFindEmail);

		return toFindEmail;
	}

	// 6. 3) 이메일(ID)을 분실했을 경우, 사용하던 닉네임 입력 후 나타나는 질문에 대한 알맞은 답을 하는 경우, 이메일(ID)을 찾을 수 있다. 
	@GetMapping("/findIDemail")
	public @ResponseBody String findEmail(
			@RequestParam("nick") String nick, 
			@RequestParam("answer") String answer,Model model) {

		MemberDTO memberDTOtoFindEmail = new MemberDTO();
		memberDTOtoFindEmail.setNick(nick);
		memberDTOtoFindEmail.setAnswer(answer);

		String email = memberService.findEmail(memberDTOtoFindEmail);
		model.addAttribute("email", email);
		return email;
	}

	// 7. 1) 비밀번호 분실시 비밀번호 찾는 페이지로 이동
	@RequestMapping("/findPasswords")
	public String finePasswords() {
		return "member/findPasswords";
	}

	// 7. 2) 비밀번호를 분실시 로그인을 할때 입력했던 이메일(ID)를 입력한 뒤 임시비밀번호 발급한 뒤에 분실한 회원의 이메일(ID)로 발송
	@GetMapping("/findPassword")
	public @ResponseBody MemberDTO findPassword(@RequestParam("email") String email, Model model) throws Exception {

		MemberDTO memberDTOtoFindPasswords = memberService.findPasswords(email);
		model.addAttribute("memberDTOtoFindPasswords", memberDTOtoFindPasswords);

		// 로그인을 할때 입력하던 이메일(ID)를 입력한 뒤 분실한 패스워드에 해당하는 이메일이 실제로 존재하는경우
		if (memberDTOtoFindPasswords != null) {

			// 임시비밀번호 발급
			UUID uid = UUID.randomUUID();
			String tempPasswords = uid.toString().substring(0, 6);

			// 암호화 시킨 임시 비밀번호를 반영
			memberDTOtoFindPasswords.setPasswords(tempPasswords);
			// 암호화 시킨 임시 비밀번호를 DB까지 반영하고 저장
			memberService.makeTemporaryPasswords(memberDTOtoFindPasswords);

			// 임시비밀번호를 이메일(ID)로 발송
			sendTempPasswords(tempPasswords, email);

		} else {

		}

		return memberDTOtoFindPasswords;
	}

	// 7. 3) 발급받은 임시비밀번호를 분실한 회원의 이메일(ID)로 발송
	public void sendTempPasswords(String tempPasswords, String email) {
		
		// 발신인(Sender)은 관리자 (flowerbudlah@gmail.com) 
		// 수신인 이메일(recipient)은 email, 보낼내용은 임시비밀번호(tempPasswords)
		String recipient = email;
		String code = tempPasswords;

		// (1) 발신인(Sender)의 메일 계정과 발신인의 비밀번호(구글 앱 비밀번호) 입력
		final String user = "flowerbudlah@gmail.com";
		final String password = "gepkhwdixvpnoldc";

		// (2) Property에 SMTP 서버 정보 설정
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		prop.put("mail.smtp.ssl.protocols", "TLSv1.2");

		// (3) SMTP 서버정보와 사용자 정보를 기반으로 Session 클래스의 인스턴스 생성
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		// (4) Message 클래스의 객체를 사용하여 수신자와 내용, 제목의 메시지를 작성
		MimeMessage message = new MimeMessage(session);

		try {
			message.setFrom(new InternetAddress(user));

			// 수신자 메일 주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

			// 제목(Subject)
			message.setSubject("고로고로(GoroGoroCommunity) 임시비밀번호입니다. ");

			// 내용(Text) 
			message.setText("임시비밀번호는 " + code + " 입니다.감사합니다. ");

			// (5) Transport 클래스를 사용하여 작성한 메세지를 전달한다. send message
			Transport.send(message);
			System.out.println("전송성공");

		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

}