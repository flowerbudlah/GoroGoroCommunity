<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign-in</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function signIn() {

		var email = $("#email").val();
		var passwords = $("#passwords").val();

		if (email == "") {
			alert("Please, enter your Email. ");
			$("#email").focus();
			return;
		}

		if (passwords == "") {
			alert("Please, enter your Password. ");
			$("#passwords").focus();
			return;
		}

		var formData = new FormData($('#tmpSignInMemberDTO')[0]);

		$
				.ajax({
					url : "${root}member/signInProcess",
					data : formData,
					cache : false,
					async : true,
					contentType : false,
					processData : false,
					type : "post",
					success :

					function(data, textStatus, xhr) {

						if (data == 'loginFail') {
							
							alert('Please, Confirm your E-mail and passwords one more time. ');

						} else if (data == 'loginSuccess') {

							alert("Sign-in successful ('_')/");
							location.href = "${root}";

						} else {

							alert('This ID is suspended. ');
							alert(data);

						}
					},

					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "message:"+ request.responseText + "\n" + "error:"+ error);
					}
				})
	}
</script>
<style>
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
	<img src="${root }image/candy05.jpg">
</article>
<!-- Log In Form -->
	<div class="container" style="margin-top: 50px; margin-bottom: 50px;">
		<div class="row">
			<div class="col-lg-4 col-sm-6"></div>
			<div class="card shadow-none">
				<div class="card-body">
					<form action="javascript:signIn()" method="post"
						name="tmpSignInMemberDTO" id="tmpSignInMemberDTO">
						<div class="form-group">
							<label for="email">E-mail(ID)</label>
							<input type="email" name="email" id="email" class="form-control" />
						</div>
						<div class="form-group">
							<label for="passwords">Password</label>
							<input type="password" name="passwords" id="passwords" class="form-control" />
						</div>
						<div class="form-group ">
							<div class="text-left">
								Have you forgotten<a href="${root }member/findEmail"> Email</a> or <a href="${root }member/findPasswords" style="">Password</a>?
							</div>
							<br>
							<div class="text-right">
								<button class="btn btn-danger">Sign-In</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="col-sm-3"></div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>