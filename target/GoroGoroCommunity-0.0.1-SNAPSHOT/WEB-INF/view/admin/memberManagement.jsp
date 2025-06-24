<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en" scope="session" />
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>For the Administrator Only</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
function searchList(){

	const keyword = $("#keyword").val().trim();

	if (keyword === ""){
		alert("Please, write a search sentence.");
		$("#keyword").focus();
		return;
	}

	$.ajax({
		type: 'get',
		url : '${root}admin/searchMemberList',
		data : $("form[name = search-form]").serialize(),
		success : 

			function(result){

				$('#boardtable').empty();

				$("#resultLength").html("Total " + result.length + " members were searched.");

				if(result.length >= 1){

					result.forEach(function(item){
						let str = '<tr>';
						str += "<td><center>" + item.memberNo + "</center></td>";
						str += "<td><center>" + item.email + "</center></td>";
						str += "<td><center>" + item.nick + "</center></td>";
						str += "<td><center><a href='${root}myPage/myPosts?memberNo=" + item.memberNo + "'>" + item.postCount + "</a></center></td>";
						str += "<td><center>" + item.replyCount + "</center></td>";
						str += "<td><center>" + item.reportCount + "</center></td>";
						str += "<td><center>" + item.signUp_Date + "</center></td>";
						str += "<td><center><a href='${root}admin/realTimeAboutLogin?nick=" + item.nick + "'>Details</a></center></td>";
						str += "<td><center>" + item.flagCount + "</center></td>";
						str += "<td><center><a href=''>Pause</a></center></td>";
						str += "</tr>";

						$('#boardtable').append(str);
					});

			} else {
				$('#boardtable').append("<tr><td colspan='10' style='text-align:center;'>There is no Search result.</td></tr>");
			}
		}
	});
}
	function makeIdSuspend(email){

		var yn = confirm("Do you want to make this ID(Email) pause? Signing-in will be suspended for 10 days From today.");
	
		if (yn) {
			$.ajax({
				url		 : "${root}admin/makeIdSuspend",
				type     : "POST",
				data	 : { email : email },
				dataType : "JSON",
				success	 : function(obj) {
					
					if (obj != null && obj.result === "successfulPause") {
						alert("This ID(Email) was suspended. The user will not be able to Sign in for 10 days From today.");
						location.reload();
					} else {
						alert("Pause failed");
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"+ request.responseText + "\n" + "error:" + error);
				}
			});
		}
	}

	function makeIdActive(email){
		
		var yn = confirm("Do you want to make this ID(Email) activate?");
		
		if (yn) {
			
			$.ajax({
			url		 : "${root}admin/makeIdActive",
			type     : "POST",
			data	 : { email : email },
			dataType : "JSON",
			success	 : function(obj) {
				
				if (obj != null && obj.result === "successOfmakingActive") {

					alert("This user can user sign-in from now on.");
					location.reload();

				} else {

					alert("Sorry, I have made This ID not activate.");

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
	background-image: url(http://localhost:8080/GoroGoroCommunity/image/banner/bottom-bg.jpg);
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
<!-- The Menu -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<article class="slider">
	<img src="${root }image/candy05.jpg">
</article>
<div style="padding-top:50px; padding-bottom:100px">
<div class="container">
<h4>For the Administrator Only</h4>
	<%--Ajax 검색기능 시작--%>	
	<form action="javascript:searchList()" name="search-form" autocomplete="off" style="margin-top:30px; margin-bottom:30px;">
			<select name="type">
				<option value="email">email</option>
				<option value="nick">nick</option>
			</select>			
			<input type="text" value="" name="keyword" id="keyword" required="required"/>
			<input type="button" onclick="javascript:searchList()" class="btn btn-warning btn-sm" value="Search"/>
	</form>
	<font id="resultLength" size="3"></font>
	<%--Ajax Searching End--%>	
	<table style="width: 1100px; margin: auto;">
		<thead>
			<tr>
				<th style="text-align: center;">No</th>
				<th style="text-align: center;">Email</th>
				<th style="text-align: center;">Nick</th>
				<th style="text-align: center;">Number of posts</th>
				<th style="text-align: center;">Number of comments</th>
				<th style="text-align: center;">Number of reported posts</th>
				<th style="text-align: center;">Date of Sign Up</th>
				<th style="text-align: center;">SignIn real-time record</th>
				<th style="text-align: center;">Flag(Number of valid reports)</th>
				<th style="text-align: center;">ID status</th>
				<th style="text-align: center;">Pause/Active</th>
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
					<fmt:formatDate pattern="dd(E) MM yyyy hh:mm:ss" value="${allMemberList.signUpDate }"/>
				</td>
				<!-- Real-time information about Signing In-->
				<td style="text-align: center;">
					<a href="${root }admin/realTimeAboutLogin?nick=${allMemberList.nick }">details</a>
				</td>
				<td style="text-align: center;">${allMemberList.flagCount }</td>
				<td style="text-align: center;">
			 <c:choose>
					<c:when test="${allMemberList.accountStatus eq 'suspend'}" >
						Sign-In suspended until <fmt:formatDate pattern="dd(E) MM yyyy hh:mm:ss" value="${allMemberList.suspensionEndDate }"/>
					</c:when>
					<c:otherwise>
						Sign in available
					</c:otherwise>
				</c:choose>
					<br>
				</td>
				<td style="text-align: center;">
					<a href="javascript:makeIdSuspend('${allMemberList.email}');">Pause</a>
					<c:if test="${allMemberList.accountStatus eq 'suspend'}" >
						<br><a href="javascript:makeIdActive('${allMemberList.email}')">Activate</a>
					</c:if>
				</td>	
			</tr>
		</c:forEach> 
		</tbody>
	</table> 
</div>
</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp"/>
</body>
</html>