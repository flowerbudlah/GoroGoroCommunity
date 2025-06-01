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
	function reportProcess() {

		var detail = $("#detail").val();
		var formData = new FormData($('#submitReportDTO')[0]);

		if (detail == "") {
			alert("Please enter the contents.");
			$("#detail").focus();
			return;
		}

		var yn = confirm("Would you like to report this post to the administrator?");

		if (yn) {

			$.ajax({
				url : "${root}board/reportProcess",
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
									alert("It will be processed within 1~2 days from the date of report.");
									history.go(-2);
									return;
								} else {
									alert("I am sorry that your report failed.");
									return;
								}
							}
						},
				error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
						}
			})
		}
	}
</script>
<style>
/* Slider's section CSS */
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
						<h5 class="card-title">Report Form</h5>
						<p>
							<!-- 양식에 맞게 신고를 하시면 관리자에게 <strong>해당 글(글 번호:${postNo })</strong>의 신고접수가 됩니다. <br>
							신고가 접수된 게시물은 관리자의 판단 하에 처리되며, 법적처벌을 받을 수도 있습니다. -->
							If you submit a report using the proper form, <strong>the post (Post Index: ${postNo})</strong> will be reported to the
							administrator. Once received, the report will be reviewed at the administrator's discretion, and legal action may be taken if necessary.
						</p>
						<form id="submitReportDTO" name="submitReportDTO" method="post" enctype="multipart/form-data">
							<input type="hidden" id="postNo" name="postNo" value="${postNo }">
							<input type="hidden" id="reporter" name="reporter" value="${signInMemberDTO.nick }">
							<div class="form-group">
								<label>Reporter</label>
								<input type="text" value="${signInMemberDTO.nick }" class="form-control" disabled />
							</div>
							<div class="form-group">
								<label>Recipient</label> <input type="text" value="Administrator" class="form-control" disabled />
							</div>
							<div class="form-group">
								<label for="reason">Reason for Report</label>
								<select name="reason" id="reason" class="form-control">
									<!-- 
									<option value="명예훼손, 모욕, 비방, 허위사실 유포 등">명예훼손, 모욕, 비방, 허위사실 유포 등</option>
									<option value="광고, 도배 등">광고, 도배 등</option>
									<option value="음란물">음란물</option>
									<option value="개인정보침해">개인정보침해</option>
									<option value="저작권침해">저작권침해</option>
									<option value="기타(해당 게시판의 주제와 맞지않는내용 등)">기타(해당 게시판의 주제와 맞지않는내용 등)</option>
									 -->
									<option value="Defamation, insults, slander, spreading false information">Defamation, insults, slander, spreading false information</option>
									<option value="Advertisements, spam, etc.">Advertisements, spam, etc.</option>
									<option value="Pornographic content">Pornographic content</option>
									<option value="Invasion of privacy">Invasion of privacy</option>
									<option value="Copyright infringement">Copyright infringement</option>
									<option value="Other (Off-topic content, etc.)">Other (Off-topic content, etc.)</option>
								</select>
							</div>
							<div class="form-group">
								<label for="detail">Detailed Description</label>
								<textarea id="detail" name="detail" class="form-control" rows="10" style="resize: none"></textarea>
							</div>
							<div class="form-group">
								<label for="imageFile">Attached Image(s)</label>
								<input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*">
							</div>
						</form>
						<div class="form-group">
							<div class="text-right">
								<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back();">Go Back to Previous Page</button>
								<button type="button" class="btn btn-info btn-sm" onClick="javascript:reportProcess();">Submit to Administrator</button>
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