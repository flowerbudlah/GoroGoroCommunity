<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GoroGoro Community(ゴロゴロ)</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script type="text/javascript">

	// Go to the main page of board. 
	function goMain() {
		var boardNo = $("#boardNo").val();
		location.href = "${root}board/main?boardNo=${boardNo}";
	}

	// Creating a post. 
	function writeProcess() {

		var maxLength = 50; 
		
		var title = $("#title").val();

		var content = $("#content").val();

		var formData = new FormData($('#writePostDTO')[0]);

		if (title == "") {
			alert("Please, Enter the title.");
			$("#title").focus();
			return;
		}

		if (content == "") {
			alert("Please, Enter the content of Post");
			$("#content").focus();
			return;
		}

		var yn = confirm("Would you like to add this post ?");
		
		if (yn) {
			
			if($("#title").val().length > maxLength){
				alert("The title can be up to 50 characters long.");
				return;

			} else {

				$.ajax({
					url : "${root}board/writeProcess",
					enctype : "multipart/form-data",
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
								alert("Successfully, a Post is added.");
								goMain();
							} else {
								alert("Sorry, a Post is not added.");
								return;
							}
						}
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "message:"+ request.responseText + "\n" + "error:" + error);
					}
				})
			}
		}
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
	<img src="${root }image/Teletobee03.png">
</article>
	<div class="container" style="margin-top: 100px; margin-bottom: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-7">
				<div class="card shadow-sm">
					<div class="card-body">
						<h4 class="card-title">Writing</h4>
						<form id="writePostDTO" name="writePostDTO" method="post" enctype="multipart/form-data">
							<input type="hidden" name="boardNo" id="boardNo" value="${boardNo }"> <input type="hidden" id="writer" name="writer" value="${signInMemberDTO.nick }" />
							<div class="form-group">
								<label for="title">Title</label> <input type="text" id="title" name="title" class="form-control" />
							</div>
							<div class="form-group">
								<label for="content">Content</label>
								<textarea id="content" name="content" class="form-control" rows="10" style="resize: none"></textarea>
							</div>
							<!-- The Start about adding a image -->
							<div class="form-group">
								<label for="imageFile">Attached Image</label> 
								<input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*">
							</div>
							<!-- The End about adding a image -->
						</form>
						<div class="form-group">
							<div class="text-right">
								<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:goMain();">Go to Main</button>
								<button type="button" class="btn btn-info btn-sm" onclick="javascript:writeProcess();">Complete</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>