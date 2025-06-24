<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Account Information</title>
<link rel="icon" type="image/x-icon" href="${root }image/favicon.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${root }js/validation.js"></script>
<script type="text/javascript">
// 1. 회원정보수정 버튼 누르면 작동 
// If user click the button of Complete to edit, this ajax method will operate.
function modifyInformation() {

	var nick = $("#nick").val();
	var question = $("#question").val();
	var answer = $("#answer").val();
	var passwords = $("#passwords").val();
	var passwordsConfirm = $("#passwordsConfirm").val();

	var formData = new FormData($('#modifyMemberDTO')[0]);

	if (nick == "") {
		alert("Enter the nick.");
		$("#nick").focus();
		return;
	}

	if (passwords == "" || passwordsConfirm == "") {
		alert("Enter your password. ");
		$("#passwords").focus();
		return;
	}

	// 회원정보 수정 페이지에서 입력한 비밀번호가 같으면
	if (passwords == passwordsConfirm) {

		// 입력한 닉네임의 중복 확인실시 (Checking duplication of entered nickname)
		$.ajax({
			url : "${root}member/checkNickInModify",
			type : "post",
			data : { nick : $("#nick").val() },
			success : function(result) {
				
				if (result == "unavailable") {
					
					alert("That nickname is already in use. Please try another one.");

				} else if (result == "available") {
					
					// Since the nickname is not duplicated, proceed with modifying member information.
					$.ajax({
						url : "${root}member/modifyProcess",
						data : formData,
						contentType : false, // 이것을 안붙이면 "수정에 실패했습니다"가 나온다. 
						processData : false, // 이것을 안붙이면 아예 회원정보 수정 버튼이 작동조차 안한다. 
						type : "POST",
						success : function(obj) {
									
									if (obj != null) {
										var result = obj.result;
										
										if (result == "success") {
											
											alert("Successfully, Updating !");
											location.href = "${root}main";
											
										} else {
											alert("Fail of Updating.");
											return;
										}
									}
								},
						error : function(request, status, error) {
									alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n"+ "error:" + error);
								}
						})
					}
				}
			})

		} else if (passwords != passwordsConfirm) {
			alert("Please make sure both passwords are the same. ");
		}
	}
</script>
<style>
/* slider's section CSS */
.slider img {
	display: block;
	width: 100%;
	max-width: 100%;
	height: 300px;
}
body {
	background-color: white;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<article class="slider">
	<img src="${root }image/candy04.jpg">
</article>
	<div class="container" style="margin-top: 50px; margin-bottom: 50px;">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-7">
				<h4>Update Account Information</h4>
				<div class="card shadow-none">
					<div class="card-body">
						<form method='post' modelAttribute="modifyMemberDTO" id="modifyMemberDTO">
							<input type="hidden" id="memberNo" name="memberNo" value="${signInMemberDTO.memberNo }" />
							<table>
								<tr>
									<td>E-mail address</td>
									<td><input type="email" id="email" name="email" value="${modifyMemberDTO.email}" readonly class="form-control" /></td>
								</tr>
								<tr>
									<td>Password</td>
									<td><input type="password" name="passwords" id="passwords" value="${modifyMemberDTO.passwords}" class="form-control pw" /></td>
								</tr>
								<tr>
									<td>↑Confirm Password</td>
									<td>
										<input type="password" name="passwordsConfirm" id="passwordsConfirm" value="${modifyMemberDTO.passwords}" class="form-control pw" />
										<font id="checkPw" size="2"></font>
									</td>
								</tr>
								<tr>
									<td>Nick</td>
									<td>
										<input type="text" id="nick" name="nick" value="${modifyMemberDTO.nick}" class="form-control">
										<font id="checkNick" size="2"></font>
									</td>
								</tr>
								<tr>
									<td>The security question</td>
									<td>
										<select name="question" id="question" class="form-control">
											<option value="Where  is your hometown?">Where  is your hometown?</option>
    										<option value="What is your nickname?">What is your nickname?</option>
    										<option value="Who is your first Lover?">Who is your first Lover?</option>
    										<option value="What is your pet's name?">What is your pet's name?</option>
    										<option value="What is a precious thing in your life? ">What is a precious thing in your life?</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>Answer to above security question&nbsp;&nbsp;&nbsp;</td>
									<td><input type="text" name="answer" id="answer" class="form-control" value="${modifyMemberDTO.answer }" /></td>
								</tr>
								<tr>
									<td>
										<font size=2>
											↑ The security question and answer are used<br>when you forget your email or password during Sign-in.
										</font>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<div class="text-right" style="margin-top: 50px; margin-bottom: 50px;">
											<input type="button" class="btn btn-primary" onclick="javascript:modifyInformation();" value="Complete to edit" />
											<a href="${root }member/getOut" class="btn btn-danger">Delete Account</a>
										</div>
									</td>
								</tr>
							</table>
						</form>
						<script>
							
							$("#question").val("${modifyMemberDTO.question }");

							$('.pw').focusout(
								function() {
									let isPassOk = false;
									
									let passwords = $("#passwords").val();
									let passwordsConfirm = $("#passwordsConfirm").val();

									if (passwords != "" && passwordsConfirm != "") {
										
										if (passwords == passwordsConfirm) {
											
											let isPassOk = true;
											$("#checkPw").html('Passwords match.');
											$("#checkPw").attr('color','green');

										} else {
											
											let isPassOk = false;
											$("#checkPw").html('They don’t match. Please double-check.');
											$("#checkPw").attr('color', 'red');

										}
									}
								})

							// checking Nick duplication 
							$("#nick").blur(
									
								function() {

									$.ajax({
										url : "${root}member/checkNickInModify",
										type : "post",
										data : {nick : $("#nick").val()},
										success : 
												function(result) {
													if (result == "unavailable") {
														
														$("#checkNick").html('This Nick is unavailable Because it is duplicate.');
														$("#checkNick").attr('color','red');
															
													} else if (result == "available") {

														$("#checkNick").html('This Nick is available.');
														$("#checkNick").attr('color','green');
																
													}
												}
										});
								});
						</script>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>