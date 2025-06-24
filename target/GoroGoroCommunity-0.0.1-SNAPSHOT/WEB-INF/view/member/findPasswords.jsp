<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

function findPasswords(){
	
	$.ajax({
			type: 'get',
			url : '${root}member/findPassword',
			data : $("form[name = toFindPasswords]").serialize(), 
			success : 
				function(result){
					
					// 테이블 초기화 Table initialization
					$('#findPasswords').empty();
					
					// 검색결과가 전혀없는 경우 There is no search result 
					if(result.length == 0){
						
						str="<img src='${root }image/banner/cryingPeko.jpg' width='50px;'><br>"; 
						str+="Sorry, There is no user information for the email you entered.<br>Please check and enter it again!<br><br>"; 
						str+="<a href='${root }member/findPasswords' class='btn btn-success btn-sm'>Back to previous page</a>"; 
						$('#findPasswords').append(str);
						
					} else {
						str="A temporary password has been issued to the email address you entered.<br>Please, Check the e-mail!";
						$('#findPasswords').append(str);
					}
				}
			})
}
</script>
<style>
.slider img {
	display:block;
	width:100%;
	max-width:100%;
	height:300px; 
}
body{
	background-image: url(http://localhost:8080/GoroGoroCommunity/image/bottom-bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
	background-attachment: fixed;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<article class="slider">
	<img src="${root }image/candy03.jpg">
</article>
<div class="container" style="margin-top:60px; margin-bottom:60px; ">
	<div class="row">
	<div class="col-lg-4 col-sm-6"></div>
		<div class="card-body" id="findPasswords">
			Do you have Forgotten your password?<br>
			First, please enter the <strong>email</strong> that you entered when you sign in!
			<form action="javascript:findPasswords()" name="toFindPasswords" autocomplete="off" style="margin-top:20px;">
				<input type="email" id="email" name="email">
				<button class="btn btn-info btn-sm">Submit</button>
			</form>
		</div>
	</div>
</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>