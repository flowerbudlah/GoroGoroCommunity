<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GoroGoro Community(ゴロゴロ)</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function takeQuestion() {

		const nick = $("#nick").val();

		if (nick == "") {
			alert("Please enter your search sentence!");
			$("#nick").focus();
			return;
		}

		$.ajax({
			type	: 'get',
			url 	: '${root}member/takeQuestion',
			data	: $("form[name=search-form]").serialize(),
			success : function(result) {
				
				// 테이블 초기화 Table Initialization
				$('#findEmail').empty();
				
				// 검색결과가 전혀없는 경우 If there are no search results at all
				if (result.length == 0) {
					str = "<img src='${root }image/banner/cryingPeko.jpg' width='100px;'><br>";
					str += "입력하신 닉네임에 대한 회원정보가 없으니<br> 다시 한번 확인하시고 입력해주세요!<br><br>";
					str += "<a href='${root }member/findEmail' class='btn btn-success btn-sm'>이전으로 돌아가기</a>";
							
					$('#findEmail').append(str);

				} else {
				
					str = "Please, Answer the questions below ('_')<br><br><strong>" + result.question + "</strong><br>";
					str += "<form action='javascript:findEmail()' name='search-form2'>";
					str += "<input type='text' id='answer' name='answer'>";
					str += "<input type='hidden' value='"+result.nick+"' id='nick' name='nick'>";
					str += "<button class='btn btn-warning btn-sm'>Submit</button></form>";
							
					$('#findEmail').append(str);
				}
			}
		})
	}

	function findEmail() {
		const answer = $("#answer").val();
		if (answer == "") {
			alert("Please, Enter the answer to the security question.");
			$("#answer").focus();
			return;
		}

		$.ajax({
			type : 'get',
			url : '${root}member/findIDemail',
			data : $("form[name=search-form2]").serialize(),
			success : function(result) {
				
				// 테이블 초기화 Table Initialization
				$('#findEmail').empty();

				// 검색결과가 전혀없는 경우 If there are no search results at all
				if (result.length == 0) {
					str = "<img src='${root }image/banner/cryingPeko.jpg' width='100px;'><br>";
					str += "Sorry, There is no user information.<br>Please check again and enter it.";
					$('#findEmail').append(str);
				
				// In case that An email is found as searching result.
				} else {
					str = "<img src='${root }image/banner/bluePekko.png' width='100px;'><br>";
					str += "Your E-mail is <strong>" + result + "</strong> .";
					$('#findEmail').append(str);
				}
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
	background-image: url(http://localhost:8080/GoroGoroCommunity/image/bottom-bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
	background-attachment: fixed;
}
#findEmail {
	text-align: center;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<article class="slider">
	<img src="${root }image/candy04.jpg">
</article>
<div class="container" style="margin-top: 60px; margin-bottom: 60px;">
	<div class="row">
		<div class="card-body" id="findEmail">
			Have you forgotten the <strong>email</strong> address using when Signing in?<br>
			First, enter the nickname and answer the questions below!<br>
			What is the <strong>nickname</strong> that you have used?
			<form action="javascript:takeQuestion()" name="search-form" autocomplete="off" style="margin-top: 20px;">
				<input type="text" id="nick" name="nick">
					<button class="btn btn-warning btn-sm">Submit</button>
			</form>
		</div>
	</div>
</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>