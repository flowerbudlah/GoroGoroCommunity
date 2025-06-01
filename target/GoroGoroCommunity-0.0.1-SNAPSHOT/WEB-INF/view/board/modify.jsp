<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:url var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GoroGoro Community(ゴロゴロ)</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<%String postNo = request.getParameter("postNo");%>
<c:set var="postNo" value="<%=postNo%>"/>
<script type="text/javascript">
	function modifyPost() {

		var title = $("#title").val();
		var content = $("#content").val();

		var formData = new FormData($('#modifyPostDTO')[0]);

		if (title == "") {
			alert("Please enter a title for your post.");
			$("#title").focus();
			return;
		}

		if (content == "") {
			alert("Please enter the contents.");
			$("#content").focus();
			return;
		}

		var yn = confirm("Do you want to revise the content of this post?");

		if (yn) {

			$.ajax({

				url : "modifyProcess",
				enctype : "multipart/form-data",
				data : formData,
				contentType : false,
				processData : false,
				cache : false,
				async : true,
				type : "POST",
				success : function(obj) {
					if (obj != null) {
						var result = obj.result;

						if (result == "success") {
							alert("The post's modification is successful.");
							location.href = "read?postNo=${postNo }";
						} else {
							alert("The post's modification was fail.");
							return;
						}
					}

				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			});
		}
	}

	function deleteImageFile() {

		//var postNo = $("#postNo").val(); 
		//var imageFileName = $("#imageFileName").val(); 

		var formData = new FormData($('#imageFilePostDTO')[0]);

		var yn = confirm("Do you want to delete the uploaded image file?");

		if (yn) {

			$.ajax({
				url : "deleteImageFile",
				data : formData,
				type : "POST",
				contentType : false,
				processData : false,
				cache : false,
				async : true,
				success : function(obj) {
					if (obj != null) {
						var result = obj.result;

						if (result == "success") {
							alert("Image file removal was successful.");
							return;
						} else {
							alert("Fail");
							return;
						}
					}

				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
				}
			})
		};
	}
</script>

</head>
<body>
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<article class="slider">
	<img src="${root }image/Teletobee03.png">
</article>
	<div class="container" style="margin-top: 200px; margin-bottom: 100px">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-7">
				<div class="card shadow-sm">
					<div class="card-body">
						<h4 class="card-title">postNo: ${postNo }</h4>
						<form id="imageFilePostDTO" name="imageFilePostDTO">
							<input type="hidden" id="postNo" name="postNo" value="${postNo }" />
							<input type="hidden" id="imageFileName" name="imageFileName" value="" />
						</form>
						<%-- This section appears only when there is an attached image --%>
						<c:if test="${PostDTOfromDB.imageFileName != '' }"> 
							Attached image: ${PostDTOfromDB.imageFileName }
							<button class="badge badge-pill badge-light" onclick="javascript:deleteImageFile();">Remove this image attachment</button>
						</c:if>
						<form id="modifyPostDTO" name="modifyPostDTO"
							enctype="multipart/form-data">
							<input type="hidden" id="postNo" name="postNo" value="${postNo }">
							<div class="form-group">
								<label for="writer">Writer</label>
								<input type="text" id="writer" name="writer" class="form-control" value="${PostDTOfromDB.writer }" disabled="disabled" />
							</div>
							<div class="form-group">
								<label for="regDate">Date of creation</label>
								<input type="text" id="regDate" name="regDate" class="form-control" value="<fmt:formatDate value="${PostDTOfromDB.regDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" disabled="disabled" />
							</div>
							<div class="form-group">
								<label for="title">Title</label> <input type="text" id="title" name="title" class="form-control" value="${PostDTOfromDB.title }" />
							</div>
							<div class="form-group">
								<label for="content">Content</label>
								<textarea id="content" name="content" class="form-control" rows="15" style="resize: none">${PostDTOfromDB.content }</textarea>
							</div>
							<label for="imageFile">
								New Attached Image:
								<input type="hidden" value="${PostDTOfromDB.imageFileName }" id="imageFileName" name="imageFileName " />
							</label>
							<div class="form-group">
								<input type="file" name="imageFile" id="imageFile" class="form-control" accept="image/*" />
							</div>
						</form>
						<div class="form-group">
							<div class="text-right">
								<button class="btn btn-primary" onclick="javascript:modifyPost();">Save Changes</button>
								<button class="btn btn-info" onclick="javascript:history.back();">Cancel</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
<!-- 
<form id="imageFilePostDTO" name="imageFilePostDTO">
	<input type="hidden" id="postNo" name="postNo" value="${postNo }"/>
	<input type="hidden" id="imageFileName" name="imageFileName" value=""/>
</form>
<c:if test="${PostDTOfromDB.imageFileName != '' }" > 
첨부 이미지: ${PostDTOfromDB.imageFileName }

<button class="badge badge-pill badge-light" onclick="javascript:deleteImageFile();">이 첨부파일 제거</button>
</c:if> 
 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>