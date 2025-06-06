<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
function searchList(){

	const keyword = $("#keyword").val();

	if (keyword == ""){
		alert("검색어를 입력해주세요.");
		$("#keyword").focus();
		return;
	}

	$.ajax({
		type: 'get',
		url : '${root}admin/searchMemberList',
		data : $("form[name=search-form]").serialize(),
		success :
			function(result){
	
				// 테이블 초기화
				$('#boardtable').empty();
				
				$("#resultLength").html("총"+result.length+'명의 회원이 검색되었습니다.');
				
				if(result.length>=1){
					
					result.forEach(
							function(item){
								str='<tr>'
									str+="<td><center>"+item.memberNo+"</center></td>"; //회원번호
									str+="<td><center>"+item.email+"</center></td>"; //제목
									str+="<td><center>"+item.nick+"</center></td>"; //작성자
									str+="<td><center><a href='${root }myPage/myPosts?memberNo="+item.memberNo+"'>"+item.postCount+"<a></center></td>"; //게시글 수
									str+="<td><center>"+item.replyCount+"</center></td>"; //댓글 수 
									str+="<td><center>"+item.reportCount+"</center></td>"; //신고당한 건수
									str+="<td><center>"+item.signUp_Date+"</center></td>"; //가입일
									str+="<td><center><a href='${root }admin/realTimeAboutLogin?nick="+item.nick+"'>상세보기</a></center></td>"; // 상세로그인일시
									str+="<td><center>"+item.flagCount+"</center></td>"; 
									str+="<td><center><a href=''>일시정지</a></center></td>";
								str+="</tr>"
								
								$('#boardtable').append(str);
							}
					)

				} else {
						str='검색결과가 없습니다.'; 
						$('#boardtable').append(str);
				}
			} // function의 끝
		}) // ajax의 끝
	} // function의 끝

	// 회원아이디 일시정지
	function makeIdSuspend(email){
	var yn = confirm("이 아이디를 일시정지 시키겠나요? 오늘부터 10일간 일시정지됩니다.");
	if (yn) {
		$.ajax({
			url		 : "${root}admin/makeIdSuspend",
			type     : "POST",
			data	 : { email : email },
			dataType : "JSON",
			success	 : function(obj) {
				if (obj != null && obj.result === "successfulPause") {
					alert("아이디 일시정지되었습니다. 오늘부터 10일간 정지됩니다.");
					location.reload();
				} else {
					alert("일시정지 실패");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"+ request.responseText + "\n" + "error:" + error);
			}
		});
	}
}

</script>
<style>
body {
	background-image: url(http://localhost:8090/GoroGoroCommunity/image/banner/bottom-bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
	background-attachment: fixed;
}
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
body{ background-color: white; }
table{border: 1px solid gray; }
th{color: black; background-color: gold; text-align:center; border: 1px solid black;}
td{text-align:center; border: 1px solid black;}
</style>
</head>
<body>
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!--가운데 그림-->
<article class="slider">
	<img src="${root }image/yamamotoshinji_sapporo_clockTower.jpg">
</article>
<!--메인화면에 내용 들어가는 부분  -->
<div style="padding-top:50px; padding-bottom:100px">
<div class="container">
<h4>For the Administrator Only</h4>
	<%--Ajax 검색기능 시작--%>	
	<form action="javascript:searchList()" name="search-form" autocomplete="off" style="margin-top:30px; margin-bottom:30px;">
			<select name="type">
				<option value="email">email</option>
				<option value="nick">Nick</option>
			</select>			
			<input type="text" value="" name="keyword" id="keyword" required="required"/> <!-- required="required"  -->
			<input type="button" onclick="javascript:searchList()" class="btn btn-warning btn-sm" value="Search"/>
	</form>
	<font id="resultLength" size="3"></font>
	<%--Ajax 검색기능 끝--%>	
	<table style="width: 1100px; margin: auto;">
		<thead>
			<tr>
				<th style="text-align: center;">No</th>
				<th style="text-align: center;">Email</th>
				<th style="text-align: center;">Nick</th>
				<th style="text-align: center;">게시글수</th>
				<th style="text-align: center;">댓글수</th>
				<th style="text-align: center;">신고받은 게시글수</th>
				<th style="text-align: center;">Date of Sign Up</th>
				<th style="text-align: center;">SignIn real-time record</th>
				<th style="text-align: center;">Flag(Number of valid reports)</th>
				<th style="text-align: center;">ID status</th>
				<th style="text-align: center;">Pause</th>
				<th style="text-align: center;">Active</th>
			</tr>
		</thead>
		<tbody id="boardtable">
		<c:forEach items="${allMemberList}" var="allMemberList">
			<tr>
				<td style="text-align: center;">${allMemberList.memberNo }</td>
				<td style="text-align: center;">${allMemberList.email}</td>
				<td style="text-align: center;">${allMemberList.nick }</td>
				<td style="text-align: center;"><a href="${root }myPage/myPosts?memberNo=${allMemberList.memberNo}">${allMemberList.postCount}</a></td>
				<td style="text-align: center;">${allMemberList.replyCount}</td>
				<td style="text-align: center;">${allMemberList.reportCount}</td>
				<td style="text-align: center;">
					<fmt:formatDate pattern="yyyy-MM-dd(E) hh시 mm분 ss초" value="${allMemberList.signUpDate }"/>
				</td>
				<!-- 로그인 정보 -->
				<td style="text-align: center;">
					<a href="${root }admin/realTimeAboutLogin?nick=${allMemberList.nick }">details</a>
				</td>
				<td style="text-align: center;">${allMemberList.flagCount }</td>
				<td style="text-align: center;">
				<c:choose>
					<c:when test="${allMemberList.accountStatus eq 'suspend'}" >
					Temporarily suspended login until ${allMemberList.suspensionEndDate}
					<fmt:formatDate pattern="yyyy-MM-dd(E) hh시 mm분 ss초" value="${allMemberList.suspensionEndDate }"/>
						
					</c:when>
					<c:otherwise>
						Sign in available
					</c:otherwise>
				</c:choose>
			
					<br>
					
				</td>
				<td style="text-align: center;">
					<!-- 이메일 값을 makeIdSuspend 함수에 전달 -->
					<a href="javascript:makeIdSuspend('${allMemberList.email}');">일시정지</a>
					
					
				</td>
				<td style="text-align: center;">
					<a href="javascript:makeIdActive()">정지취소</a>
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