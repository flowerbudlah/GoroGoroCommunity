<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("root", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GoroGoro Community(ゴロゴロ)</title>
<link rel="icon" type="image/x-icon" href="/GoroGoroCommunity/image/favicon.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
<style>
.slider img {
	display: block;
	width: 100%;
	max-width: 100%;
	height: 300px;
}
body {
	background-image: url(image/bottom-bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
	background-attachment: fixed;
}
thead {
	background-color: gold;
}
h1 {
	font-family: 'Single Day', cursive;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<article class="slider">
	<img src="${root }/image/candy01.png">
</article>
<!--Post List (게시글 리스트)-->
<div class="container" style="margin-top: 50px; margin-bottom: 50px;">
	<div class="card-body">
		<h1 class="card-title">${boardName }</h1>
			<c:choose>
				<c:when test="${searchCount == null}"></c:when>
				<c:otherwise>Total ${searchCount} Posts were searched.</c:otherwise>
			</c:choose>
			<table class="table table-hover">
				<thead>
					<tr>
						<th class="text-center d-none d-md-table-cell">No</th>
						<th class="w-50">Title</th>
						<th class="text-center d-none d-md-table-cell">Writer</th>
						<th class="text-center d-none d-md-table-cell">Date</th>
						<th class="text-center d-none d-md-table-cell">Views</th>
						<th class="text-center d-none d-md-table-cell">Like</th>
					</tr>
				</thead>
				<tbody id="boardtable">
					<!-- The post's List of This board -->
					<c:forEach var="postDTO" items="${postList }">
						<tr>
							<td class="text-center d-none d-md-table-cell">${postDTO.postNo }</td>
							<td>
								<!-- title -->
								<a href='read?postNo=${postDTO.postNo}' style="color: black">
									<c:choose>
										<c:when test="${boardNo == 1 }">[${boardName }]</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>${postDTO.title }
									<!-- If There is a Uploaded file. -->
									<c:if test="${not empty postDTO.imageFileName}">
										<img src="${root }/image/uploadingPhoto.png" width=20px;>
										<!-- <img src="/GoroGoroCommunity/image/uploadingPhoto.png" width=20px;> -->

									</c:if>
							
									 <!-- Number of comments (if any) -->
									 <font color="red">[${postDTO.replyCount }]</font>
								</a>
							</td>
							<td class="text-center d-none d-md-table-cell">
								<c:choose>
									<c:when test="${postDTO.boardNo == 2 }">Anonymous</c:when>
									<c:otherwise>${postDTO.writer}</c:otherwise>
								</c:choose>
							</td>
							<td class="text-center d-none d-md-table-cell">
								<fmt:formatDate value="${postDTO.regDate }" pattern="yyyy-MM-dd" />
							</td>
							<td class="text-center d-none d-md-table-cell">${postDTO.viewCount }</td>
							<td class="text-center d-none d-md-table-cell">${postDTO.sameThinking }</td>
						</tr>
					</c:forEach>
					<!-- 검색결과 게시글 -->
					<c:forEach var="postDTO" items="${searchList }">
						<tr>
							<td class="text-center d-none d-md-table-cell">${postDTO.postNo }</td>
							<td>
								<%-- 제목 부분 --%>
								<a href='read?postNo=${postDTO.postNo}' style="color: black">
									<c:choose>
										<c:when test="${boardNo == 1 }">[${boardName }]</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
										${postDTO.title }
										<!-- 업로드 파일이 있다면 -->
									<c:if test="${postDTO.imageFileName != '' }">
										<img src="/GoroGoroCommunity/image/uploadingPhoto.png" width=20px;>
									</c:if>
									<!-- 댓글이 있을경우, 댓글 수-->
									<font color="red">[${postDTO.replyCount }]</font>
								</a>
							</td>
							<td class="text-center d-none d-md-table-cell">
								<c:choose>
									<c:when test="${postDTO.boardNo == 2 }">Anonymous</c:when>
									<c:otherwise>${postDTO.writer}</c:otherwise>
								</c:choose>
							</td>
							<td class="text-center d-none d-md-table-cell">
								<fmt:formatDate value="${postDTO.regDate }" pattern="yyyy-MM-dd" />
							</td>
							<td class="text-center d-none d-md-table-cell">${postDTO.viewCount }</td>
							<td class="text-center d-none d-md-table-cell">${postDTO.sameThinking }</td>
						</tr>
					</c:forEach>
					<!-- 검색 끝 -->
				</tbody>
			</table>
			<!-- 글쓰기버튼 -->
			<c:choose>
				<c:when test="${signInMemberDTO.signIn == true }">
					<!-- 글쓰기버튼은 로그인을 한 사람만 보인다. -->
					<c:choose>
						<c:when test="${boardNo == 1 }">
							<%--관리자게시판 인경우 --%>
							<c:choose>
								<c:when test="${signInMemberDTO.memberNo == 1}">
									<%--관리자 게시판인경우, 관리자만 글쓰기 버튼을 보고 --%>
									<div class="text-right">
										<a href="write?boardNo=${boardNo }" class="btn btn-warning">Write</a>
									</div>
								</c:when>
								<c:otherwise></c:otherwise>
							<%--관리자게시판 인경우, 관리자가 아니라면 글쓰기버튼은 안보인다.  --%>
							</c:choose>
						</c:when>
						<c:otherwise>
							<%--관리자게시판이 아닌 경우, 글쓰기 버튼은 로그인을 한 사람이라면 다 보인다.  --%>
							<div class="text-right">
								<a href="write?boardNo=${boardNo }" class="btn btn-warning">Write</a>
							</div>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
			<!-- [이전]1 2 3 4 5 6 7 8 9 10 [다음] 페이지 시작 -->
			<c:choose>
				<c:when test="${searchListPageDTO.prePage >= 0 }">
					<!-- 검색을 한 경우의 페이지 -->
					<div class="d-none d-md-block">
						<ul class="pagination justify-content-center" id="page">
							<!-- 이전 -->
							<c:choose>
								<c:when test="${searchListPageDTO.prePage <= 0 }">
									<li class="page-item disabled">
										<a href="#" class="page-link">Prev</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a href="searchResult?boardNo=${boardNo}&type=${type }&keyword=${keyword }&page=${pageDTO.prePage}"class="page-link">이전</a>
									</li>
								</c:otherwise>
							</c:choose>
							<!-- 1 2 3 4 5 6 7 8 9 10 -->
							<c:forEach var="idx" begin="${searchListPageDTO.min }"
								end="${searchListPageDTO.max }">
								<c:choose>
									<c:when test="${idx == searchListPageDTO.currentPage }">
										<li class="page-item active">
											<a href="searchResult?boardNo=${boardNo}&type=${type }&keyword=${keyword }&page=${idx}" class="page-link">${idx}</a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="page-item">
											<a href="searchResult?boardNo=${boardNo}&type=${type }&keyword=${keyword }&page=${idx}" class="page-link">${idx}</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<!-- 다음 -->
							<c:choose>
								<c:when test="${searchListPageDTO.max >= searchListPageDTO.pageCount }">
									<!--맨 마지막 페이지인 경우에는 다음 버튼이 안 보이도록 함 (최대페이지가 전체페이지개수보다 크면 다음이 안 보이도록 함) -->
									<li class="page-item disabled">
										<a href="#" class="page-link">Next</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a href="searchResult?boardNo=${boardNo }&type=${type }&keyword=${keyword }&page=${searchPageDTO.prePage}" class='page-link'>Next</a>
									</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<!-- 메인 게시판의 그 일반적인 그 페이징(Paging) -->
					<div class="d-none d-md-block">
						<ul class="pagination justify-content-center" id="page">
							<!-- 이전 -->
							<c:choose>
								<c:when test="${pageDTO.prePage <= 0 }">
									<li class="page-item disabled">
										<a href="#" class="page-link">Prev</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a href="main?boardNo=${boardNo}&page=${pageDTO.prePage}" class="page-link">Prev</a>
									</li>
								</c:otherwise>
							</c:choose>
							<!-- 1 2 3 4 5 6 7 8 9 10 -->
							<c:forEach var="idx" begin="${pageDTO.min }" end="${pageDTO.max }">
								<c:choose>
									<c:when test="${idx == pageDTO.currentPage }">
										<li class="page-item active"><a
											href="main?boardNo=${boardNo}&page=${idx}" class="page-link">${idx}</a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="page-item">
											<a href="main?boardNo=${boardNo}&page=${idx}" class="page-link">${idx}</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<!-- 다음 -->
							<c:choose>
								<c:when test="${pageDTO.max >= pageDTO.pageCount }">
									<!--맨 마지막 페이지인 경우에는 다음 버튼이 안 보이도록 함 (최대페이지가 전체페이지개수보다 크면 다음이 안 보이도록 함) -->
									<li class="page-item disabled">
										<a href="#" class="page-link">Next</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a href="main?boardNo=${boardNo}&type=${type }&keyword=${keyword }&page=${pageDTO.nextPage}" class="page-link">Next</a>
									</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>
		<!-- 페이징 끝 -->
	</div>
	<!-- The Function of Searching -->
	<form action="searchResult" name="search-form" autocomplete="off" class="text-center" style="margin-top: 30px;">
		<select id="type" name="type">
			<option value="titleANDcontent">Title + Content</option>
			<option value="title">Title</option>
			<option value="content">Content</option>
				<c:choose>
					<%-- 익명 게시판인 경우, 작성자가 안나온다.
					If it is an anonymous board, the author will not appear. --%>
					<c:when test="${boardNo == 2 }"></c:when>
					<c:otherwise>
						<option value="writer">Writer</option>
					</c:otherwise>
				</c:choose>
			</select>
			<input type="text" value="" name="keyword" id="keyword" required="required" />
			<input type="hidden" id="boardNo" name="boardNo" value="${boardNo }" />
		<button onclick="searchResult" class="btn btn-warning btn-sm">Search</button>
	</form>
</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>