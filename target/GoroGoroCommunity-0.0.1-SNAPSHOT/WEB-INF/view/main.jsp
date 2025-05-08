<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GoroGoro Community(ゴロゴロ)</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<!-- Main's screen slide -->
<link rel="stylesheet" href="css/slide.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
<style>
/* slider CSS */
.slider img {
	display: block;
	width: 100%;
	max-width: 100%;
	height: 300px;
}
.card-title {
	font-family: 'Single Day', cursive;
}
body {
	background-image: url(image/bottom-bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
	background-attachment: fixed;
}
h3 {
	background-color: #222;
	color: white;
	text-align: center;
	padding: 10px;
	font-family: 'Single Day', cursive;
}
thead {
	background-color: gold;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<!-- Slider's section-->
<div class="slide slide_wrap">
	<div class="slide_item item1"></div>
	<div class="slide_item item2"></div>
	<div class="slide_item item3"></div>
	<div class="slide_prev_button slide_button"></div>
	<div class="slide_next_button slide_button"></div>
	<ul class="slide_pagination"></ul>
</div>
<script src="js/slide.js"></script>
<div class="container" style="margin-top: 30px; margin-bottom: 80px">
	<div class="card-body">
		<div>
			<h3>Please Sign in as administrator(ID: admin@gorogoro.com)</h3>
				<p class="text-center" style="margin-bottom: 50px">
					please, Sign in with the administrator ID(<strong>admin@gorogoro.com</strong>), Password(<strong>1111</strong>)<br> 
					to confirm the function of the administrator Only page.
					<br><br>
					管理者IDでログインしてから<strong>管理者ページ</strong>の機能を確認してください！ <br>
					<strong>管理者ID: admin@gorogoro.com パスワード: 1111</strong>
					<br><br>
					관리자 아이디로 로그인을 해서 관리자페이지의 기능을 살펴봐주세요! <br>
					<strong>관리자 아이디: admin@gorogoro.com 비밀번호: 1111</strong>
				</p>
			<h3>Additional planned features</h3>
				<p class="text-center" style="margin-bottom: 50px">
					1. I’m planning to create a board with a feature that allows users to upload multiple photo files.<br>
					2. I’m planning to create a board with a feature that allows users to upload .pdf files, audio file other than image file.
					<br><br>
					1. 複数件の 写真ファイルをアップロードできる機能の掲示板を作る予定。<br>
					2. 写真ファイルだけでなく、pdfとか音楽ファイルなどをアップロードできる掲示板を作る予定。
					<br><br>
					1. 사진파일을 하나가 아닌 여러건을 올릴수있게<br>
					2. 사진 파일뿐아니라 pdf, 음악파일등을 업로드 할 수 있는 기능
				</p>
			</div>
			<h3>Notice</h3>
				<div class="table-responsive">
					<table class="table table-hover">	
						<thead>
							<tr>
								<th class="text-center d-none d-md-table-cell" style="color: black">No</th>
								
								 
								<th class="w-50">Title</th>
								<th class="text-center d-none d-md-table-cell" style="color: black">Writer</th>
								<th class="text-center d-none d-md-table-cell" style="color: black">Date</th>
								<th class="text-center d-none d-md-table-cell" style="color: black">Views</th>
								<th class="text-center d-none d-md-table-cell" style="color: black">Like</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="postDTO" items="${postList }">
								<tr>
									<td class="text-center d-none d-md-table-cell">${postDTO.postNo }</td>
									<td>
										<a href='${root }board/read?&postNo=${postDTO.postNo}' style="color: black"> <c:choose>
												<c:when test="${postDTO.boardNo == 1 }">[Notice]</c:when>
												<c:otherwise></c:otherwise>
											</c:choose> ${postDTO.title } 
											<!-- 업로드 파일이 있다면 In case that there is a Uploading file --> 
											<c:if test="${postDTO.imageFileName != '' }">
												<img src="/image/uploadingPhoto.png" width=20px;>
											</c:if> 
											<!-- In case that there is a reply, It shows count of reply.--> 
											<font color="red">[${postDTO.replyCount }]</font>
										</a>
									</td>
									<td class="text-center d-none d-md-table-cell">${postDTO.writer }</td>
									<td class="text-center d-none d-md-table-cell"><fmt:formatDate value="${postDTO.regDate }" pattern="yyyy-MM-dd" /></td>
									<td class="text-center d-none d-md-table-cell">${postDTO.viewCount }</td>
									<td class="text-center d-none d-md-table-cell">${postDTO.sameThinking }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>		
			<div class="text-right">
				<a href="${root }board/main?boardNo=1" class="btn btn-danger" style="color: white">More...</a>
			</div>
		</div>
	</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>