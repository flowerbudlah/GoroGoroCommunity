<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${root }js/validation.js"></script>
<script type="text/javascript">

	function signIn() {
		location.href = "${root}member/signIn";
	}

	function signUpProcess() {

		var email = $("#email").val();
		var nick = $("#nick").val();
		var question = $("#question").val();
		var answer = $("#answer").val();
		var passwords = $("#passwords").val();
		var passwordsConfirm = $("#passwordsConfirm").val();

		var emailValidity = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/); 

		var formData = new FormData($('#signUpMemberDTO')[0]);

		if (email == "") {
			alert("please, Write your E-mail.");
			$("#email").focus();
			return;
		}

		if (nick == "") {
			alert("please, Write your nick.");
			$("#nick").focus();
			return;
		}

		if (passwords == "" || passwordsConfirm == "") {
			alert("please, Write your password.");
			$("#passwords").focus();
			return;
		}

		var yn = confirm("Would you like to join us?");

		if (yn) {

			if ((passwords == passwordsConfirm) && (emailValidity.test($("#email").val()))) {

				$.ajax({
					url : "${root}member/checkEmail",
					type : "post",
					data : { email : email },
					success :
						
						function(data) {
							
							if (data == "unavailable") {
								alert("The Email(ID) is already in use and cannot be used.");

							} else if (data == "available") {

									$.ajax({
										url : "${root}member/checkNick",
										type : "post",
										data : {nick : nick},
										success :
											function(data) {
												
												if (data == "unavailable") {
													
													alert("The nickname you write is already in use and cannot be used. Please, write a different nickname!");
												
												} else if (data == "available") {
													
													$.ajax({
														url : "${root}member/signUpProcess",
														data : formData,
														cache : false,
														async : true,
														contentType : false,
														processData : false,
														type : "POST",
														success : function(obj) {
																	
																	if (obj != null) {
																		
																		var result = obj.result;
																		
																		if (result == "success") {
																			
																			alert("Signing Up has been successful. Let's go to the sign-in page.");
																			signIn();
																		
																		} else {
																			
																			alert("Failure  of Signing up.");
																			return;
																		}
																	}
																},
														error : function(request, status, error) {
																	alert("code:" + request.status + 
																	"\n" + "message:" + request.responseText + 
																	"\n" + "error:" + error);
																}
														}) // 회원가입 아작스의 끝
													} // 사용가능한 닉네임 체크여부 else if의 끝
												} // 닉네임 체크 function(data)
											})// 닉네임 중복 아작스
											
							} // 이메일 중복 체크 아작스 
						} // 이메일 중복체크 function(data)
					})// 이메일 중복 아작스
			
			} else if (passwords != passwordsConfirm) {
				alert("The passwords you entered do not match. Please try again. ");
			
			// In case that the email used as ID does not match the format. 
			} else if (!emailValidity.test($("#email").val())) {
				alert("Please, write your email in the correct format and try signing up again! ex) abc@nate.com");
			}

		}//yn의 끝
	} //signUpProcess()의 끝
</script>
<style>
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
body{ background-color: white; }
</style>
</head>
<body>
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<article class="slider">
	<img src="${root }image/Teletobee03.png">
</article>
<div class="container" style="margin-top:50px; margin-bottom:50px;">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7"><h4>Sign Up</h4>
		<div class="card shadow-none">
		<div class="card-body">
		<form name="signUpMemberDTO" method="post" id="signUpMemberDTO">
			<table>
				<tr>
					<td>E-mail address</td>
	  				<td>
	  					<div class="input-group">
	  						<input type="email" id="email" name="email" class="form-control"/>
						</div>
						<font id="checkId" size="2"></font>
	  				</td>			
				</tr>
				<tr>
	 	 			<td>Password</td>
	  				<td><input type="password" name="passwords" id="passwords" class="form-control pw"/></td>
				</tr>
				<tr>
					<td>↑ Confirm the password above</td>
	  				<td>
						<input type="password" name="passwordsConfirm" id="passwordsConfirm" class="form-control pw"/>
						<font id="checkPw" size="2"></font>
	  				</td>
				</tr>
				<tr>
					<td>Nickname</td>
	  				<td>
	  					<input type="text" id="nick" name="nick" class="form-control">
	  					<font id="checkNick" size="2"></font>
	  				</td>
				</tr>
				<tr>
					<td>Questions when you forget your email or password&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
					<td>↑ Answer to the question above</td>
					<td><input type="text" name="answer" id="answer" class="form-control"/></td>
				</tr>
				<tr>
	  				<td colspan = "2" align = "center">
	  					<div class="text-right" style="margin-top:50px; margin-bottom:50px;">
							<button type="button" class="btn btn-danger" onclick="javascript:signUpProcess();">Complete</button>
						</div>
	  				</td>
				</tr>
			</table>
		</form>
<script>

	// 비밀번호와 확인용 비밀번호의 일치여부 체크
	$('.pw').focusout(function() {

		let isPassOk = false;

		let passwords = $("#passwords").val();
		let passwordsConfirm = $("#passwordsConfirm").val();

		if (passwords != "" && passwordsConfirm != "") {
			if (passwords == passwordsConfirm) {
				let isPassOk = true;
				$("#checkPw").html('The passwords was matched.');
				$("#checkPw").attr('color', 'green');
			} else {
				let isPassOk = false;
				$("#checkPw").html('There is a mismatch in passwords. Please check again!');
				$("#checkPw").attr('color', 'red');
			}
		}
	})

	// 이메일 검사 (Checking Email)
	$("#email").keyup(
			
			function() {

				var emailValidity = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);

				// Email Validation
				if (!emailValidity.test($("#email").val())) {
					$("#checkId").html('Please, Enter your email in the correct format.');
					$("#checkId").attr('color', 'red');
					return false;
				}
				
				$.ajax({
					url : "${root}member/checkEmail",
					type : "post",
					data : {email : $("#email").val()},
					success : 
						function(data) {
							if (data == "unavailable") {
								$("#checkId").html("Because of Duplicate Email, You'd better another ID");
								$("#checkId").attr('color', 'red');
							} else if (data == "available") {
								$("#checkId").html('You can use This Email as ID.');
								$("#checkId").attr('color', 'green');
							}
						}
					});
				});
	
	// 닉네임 중복검사 (checking Nickname duplication. )
	$("#nick").blur(
			
			function() { //foucusout, keyup, change, blur
				
				$.ajax({
					url : "${root}member/checkNick",
					type : "post",
					data : {nick : $("#nick").val()},
					success : function(result) {
						if (result == "unavailable") {
							$("#checkNick").html("This nickname is already in use by another user, so we recommend that you use a different nickname.");
							$("#checkNick").attr('color', 'red');
						} else if (result == "available") {
							$("#checkNick").html('You can use this nickname.');
							$("#checkNick").attr('color', 'green');
						}
					}
				})
				
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