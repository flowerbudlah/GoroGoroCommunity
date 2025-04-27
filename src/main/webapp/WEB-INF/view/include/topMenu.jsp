<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
<style>
.main {
	text-align: center;
	margin: 0;
	padding: 0;
	font-size: 18px;
}
.main li {
	display: inline-block;
	font-weight: bolder;
	list-style: none;
}
.main ul {
	opacity: 0;
	transition: opacity 0.5s;
	pointer-events: none;
	position: absolute;
	padding-left: 0px;
}
.main:after {
	content: '';
	display: block;
	clear: both;
}
.main>li {
	font-color: white;
	margin-right: 15px;
	margin-left: 15px;
	margin-top: 10px;
	margin-bottom: 10px;
	line-height: 30px;
}
.main>li ul li {
	float: left;
	list-style: none;
	font-weight: bolder;
	font-size: 15px;
	position: relative;
	margin: 0 auto;
}
.main>li:hover ul {
	opacity: 1;
	pointer-events: auto;
}
.ml-auto {
	font-size: 15px;
}
.navbar-collapse {
	font-family: 'Single Day', cursive;
}
button:focus {
  outline: none;
  box-shadow: none;
}
</style>
<script type="text/javascript">
	function signOut() {

		$.ajax({
			url : "${root}member/signOut",
			type : "POST",
			success : function() {
				alert("sign Out");
				location.href = "${root}main";
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		})
	}
</script>
<nav class="navbar navbar-expand-md bg-light navbar-dark fixed-top shadow-lg">
	<!--Hamburger Button-->
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navMenu">
		<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 30 30">
        	<path stroke="#000" stroke-width="4" stroke-linecap="round" stroke-miterlimit="10" d="M4 7h22M4 15h22M4 23h22" />
    	</svg>
	</button>
	<!--Banner -->
	<a class="navbar-brand" href="${root }main">
		<img src="${root}image/banner/pinkPeko.gif" height="50px">
		<img src="${root}image/banner/banner.png" height="50px">
	</a>
	<!-- "게시판 메뉴"와 마이페이지과 관리자전용페이지, 로그인, 회원가입 등장 -->
	<div class="collapse navbar-collapse" id="navMenu">
		<ul class="navbar-nav main">
			<li>
				<a href="${root }board/main?boardNo=1" style="color: black;'">Notice</a>
			</li>
			<c:forEach var="CategoryListDTO" items="${CategoryList}">
				<li class="nav-item">${CategoryListDTO.boardCategoryName }
					<ul>
						<c:forEach var="BoardListDTO" items="${BoardList }">
							<c:choose>
								<c:when test="${CategoryListDTO.boardCategoryNo == BoardListDTO.boardCategoryNo }">
									<!-- menu List -->
									<li>
										<a href="${root }board/main?boardNo=${BoardListDTO.boardNo}" style="color: black;'"> ${BoardListDTO.boardName } </a>
									</li>
									<br>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
			<li>
				<a href="${root }board/main?boardNo=2" style="color: black;'">Anonymous</a>
			</li>
		</ul>
		<ul class="navbar-nav main">
			<li>My Page
				<ul>
					<c:choose>
						<c:when test="${signInMemberDTO.signIn == true }">
							<!-- If You want to see this menus, You should sign in -->
							<li>
								<a href="${root }member/modify" style="color: black;">Account Settings</a>
							</li>
							<br>
							<li>
								<a href="${root }myPage/myPosts?memberNo=${signInMemberDTO.memberNo}" style="color: black;">My Post</a>
							</li>
							<br>
							<li>
								<a href="${root }myPage/reportList?reporter=${signInMemberDTO.nick}" style="color: black;">My Report</a>
							</li>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
				</ul>
			</li>
			<li>Admin Page
				<ul>
					<c:choose>
						<c:when test="${signInMemberDTO.signIn == true }">
							<li>
								<a href="${root }admin/memberManagement" style="color: black;">User Management</a>
							</li>
							<br>
							<li>
								<a href="${root }admin/postManagement" style="color: black;'">Post Management</a>
							</li>
							<br>
							<li>
								<a href="${root }admin/boardManagement" style="color: black;">Board Management</a>
							</li>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
				</ul>
			</li>
		</ul>
		<!-- Sign-in & Sign-up section (edit member information, sign-out, cancel membership) -->
		<ul class="navbar-nav ml-auto">
			<c:choose>
				<c:when test="${signInMemberDTO.signIn == true }">
					<!-- Logged in -->
					Hello, <strong>${signInMemberDTO.nick}</strong>!&emsp;
					<li>
						<a href="javascript:signOut();" attr-a="onclick : attr-a" style="color: black;">Sign Out</a>
					</li>
				</c:when>
				<c:otherwise>
					<!-- Not logged in -->
					<li class="nav-item">
						<a href="${root }member/signIn" style="color: black;">Sign In</a>
					</li>
					&emsp;
					<li class="nav-item">
						<a href="${root }member/signUp" style="color: black;">Sign Up For Free</a>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
		<a class="navbar-brand">
			<img src="${root}image/banner/smilingPekko.png" height="50px">
		</a>
	</div>
</nav>