<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>For the administrator Only</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script> 

</script>
<style>
body {
	background-image: url(http://localhost:8090/GoroGoroCommunity/image/bottom-bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
	background-attachment: fixed;
}
/* 슬라이더 영역 CSS */
.slider img {
	display: block;
	width: 100%;
	max-width: 100%;
	height: 300px;
}
</style>
</head>
<body>
	<!-- 메뉴부분 -->
	<c:import url="/WEB-INF/view/include/topMenu.jsp" />
	<!--가운데 그림-->
	<article class="slider">
		<img src="${root }image/jewely.png">
	</article>
	<!--메인화면에 내용 들어가는 부분  -->
	<div style="padding-left: 50px; padding-top: 50px; padding-bottom: 50px;">
		<div class="container">
		The Realtime information of ${nick}
		<table style="width: 1100px; margin: auto;">

		<thead>
			<tr>
				<th style="text-align: center;"></th>
				<th style="text-align: center;">Realtime</th>
			</tr>
		</thead>

		<tbody id="boardtable">
		
		
		<c:forEach items="${realTimeLoginRecordList}" var="realTimeLoginRecordList">
			<tr>
				<td style="text-align: center;">${realTimeLoginRecordList.loginRecordNo}</td>
				<td style="text-align: center;">
					<fmt:formatDate pattern="dd(E) MM yyyy hh:mm:ss" value="${realTimeLoginRecordList.loginRecordRealTime}"/>
				</td>
			</tr>
		</c:forEach> 
		
		
		</tbody>
			
</table> 
		
		</div>
	</div>
	<!-- 하단 -->
	<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>