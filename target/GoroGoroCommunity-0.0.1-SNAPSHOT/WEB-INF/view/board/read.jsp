<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath()); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GoroGoro Community(ゴロゴロ)</title>
<link rel="icon" type="image/x-icon" href="image/favicon.png">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">    

	function goMain(){
		var boardNo = $("#boardNo").val();
		location.href = "main?boardNo=${readPostDTO.boardNo}";
	}

	function deletePost(){
		var postNo = $("#postNo").val();
		var yn = confirm("Would you like to delete this post ?");
		
		if(yn){
			
			$.ajax({
				url      : "deletePost",
				type     : "POST",
				data	 : { postNo : postNo },
				dataType : "JSON",
				success  :
					function(obj) {
					
						if(obj != null){
							
							var result = obj.result;
							
							if(result == "success"){
								alert("This post was deleted.");
								goMain();
							
							} else {
								alert("Sorry, This post was not deleted.");
								return;
							}
						}
					},
				error    : function(request, status, error) {
				
					if(request.status == "200"){
						alert("You cannot delete this post."); 
					} else {
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						
					}
            	}
			});
		}
	}
	
	function report(){
		location.href = "report";
	}
	
	function like(){
		var postNo = $("#postNo").val();
		var yn = confirm("Do you feel the same way?");
		
		if(yn){
			
			$.ajax({
				url      : "like",
				type     : "POST",
				data : { postNo : postNo },
				dataType : "JSON",
				success  : function(obj) {
					
					if(obj != null){
						var result = obj.result;
						
						if(result == "success"){
							alert("You feel the same way.");
							return;
						} else {
							alert("Sorry, There is a problem with feeling the same way. ");
							return;
						}
					}
				},
				error    : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	}

	function writeReplyProcess(){
		
		var replyContent = $("#replyContent").val();

		if (replyContent == ""){
			alert("please, enter the content ! ");
			$("#replyContent").focus();
			return;
		}

		var yn = confirm("Would you like to add a comment ?");
		
		if(yn){
			
			$.ajax({
				url      : "writeReplyProcess",
                data     : $("#writeReplyDTO").serialize(),
                dataType : "JSON",
                cache    : false,
                async    : true,
                type     : "POST",
                success  : function(obj) {
                	writeReplyCallback(obj);
                },
                error: function(request,status,error){
                	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
			})
		};
	}

	// 7. The callback method to comment 
	function writeReplyCallback(obj){

		if(obj != null){
			var result = obj.result;

			if(result == "success"){
				alert("Successfully, Commenting!");
				location.href = "read?postNo=${postNo}";
				return;
			} else {
				alert("Sorry, Try one more time !");
				return;
			}
		}
	}

	function removeReply(replyNo){
		
		var yn = confirm("Do you want to remove the comment ?");
		
		if(yn){
			$.ajax({
				url      : "removeReply",
				data     : { replyNo : replyNo },
				dataType : "JSON",
				cache    : false,
				async    : true,
				type     : "POST",
				success  : function(obj) {
					if(obj != null){
						var result = obj.result;
						if(result == "success"){
							alert("Successfully, The comment was Removed.");
							location.href = "read?postNo=${postNo}";
						} else {
							alert("Sorry, There is a problem with deleting the comment.");
							return;
						}
					}
				},
				error	 : function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
		};
	}

</script>
<style>
.reply {
	font-size: 12px;
}
.replyWriter {
	text-align: left;
	position: absolute;
}
.replyRegDate {
	text-align: right;
	position: relative;
}
.slider img {
	display: block;
	width: 100%;
	max-width: 100%;
	height: 300px;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<article class="slider">
	<img src="${root }/image/candy02.jpg">
	<!-- https://image/candy02.jpg -->
	<!-- https://gorogorocommunity-production.up.railway.app/image/candy01.png -->
</article>
<div class="container" style="margin-top: 100px; margin-bottom: 100px;">
	<div class="row">
		<div class="col-sm-3"></div>
			<div class="col-sm-7">
				<div class="card shadow-none">
					<div class="card-body">
						<h4 class="card-title"></h4>
						<div class="form-group">
							<label for="postNo">No</label>
							<input type="text" id="postNo" name="postNo" class="form-control" value="${readPostDTO.postNo}" disabled="disabled" />
							<input type="hidden" id="boardNo" name="boardNo" value="${readPostDTO.boardNo}" />
						</div>
						<div class="form-group">
							<label for="writer">Writer</label>
							<c:choose>
								<c:when test="${readPostDTO.boardNo == 2 }">
									<input type="text" id="writer" name="writer" class="form-control" value="Anonymous" disabled="disabled" />
								</c:when>
								<c:otherwise>
									<input type="text" id="writer" name="writer" class="form-control" value="${readPostDTO.writer}" disabled="disabled" />
								</c:otherwise>
							</c:choose>
						</div>
						<div class="form-group">
							<label for="regDate">The article's original creation date</label>
							<input type="text" id="regDate" name="regDate" class="form-control" value="<fmt:formatDate value="${readPostDTO.regDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" disabled="disabled" />
						</div>
						<div class="form-group">
							<label for="title">Title</label>
							<input type="text" id="title" name="title" class="form-control" value="${readPostDTO.title}" disabled="disabled" />
						</div>
						<!-- Attached image and Content of the article -->
						<div class="form-group">
						<c:if test="${not empty readPostDTO.imageFileName}">
							<div class="form-group">
									<label for="fileName">Attached Image</label>
									<img src="${readPostDTO.imageFileName}" width=100%; height=250px; />
									<!-- <img src="/GoroGoroCommunity/upload/${readPostDTO.imageFileName}" width=100%; height=250px; /> -->
								</div>
</c:if>
						
						
						
							<label for="content">Content</label>
							<textarea id="content" name="content" class="form-control" rows="15" style="resize: none" disabled="disabled">${readPostDTO.content}</textarea>
						</div>
						<div class="form-group">
							<label for="board_content">Comment [${readPostDTO.replyCount }]</label>
						</div>
						<!-- Taking the comment -->
						<div class="reply">
							<ul>
								<c:forEach var="reply" items="${replyList}">
									<li>
										<div class="replyWiter">
											Commenter : ${reply.replyWriter}&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
											Date and time of the comment : <fmt:formatDate value="${reply.replyRegDate}" pattern="yyyy-MM-dd hh:mm:ss" />
											<c:choose>
												<c:when test="${signInMemberDTO.nick == reply.replyWriter || signInMemberDTO.memberNo == 1 || signInMemberDTO.nick == readPostDTO.writer }">
													<a class="badge badge-pill badge-light" style="font-size: 13px;" onclick="javascript:removeReply(${reply.replyNo});">
														X
														<!-- The button to remove this comment -->
														<input type="hidden" id="replyNo" name="replyNo" value="${reply.replyNo}"/>
													</a>
												</c:when>
												<c:otherwise></c:otherwise>
											</c:choose>
										</div>
										<textarea id="replyContent" name="replyContent" class="form-control" rows="3" style="resize: none" disabled="disabled">${reply.replyContent }</textarea>
									</li>
									<br>
								</c:forEach>
							</ul>
						</div>	
						<!-- Comment Writing part Start ( This section is seen only by sign-in User. ) -->
						<c:choose>
							<c:when test="${signInMemberDTO.signIn == true }">
								<form id="writeReplyDTO" name="writeReplyDTO">
									<input type="hidden" name="postNo" id="postNo" value="${postNo }">
									<!-- The Writing Form of Comment -->
									<div class="reply">
										<input type="hidden" id="replyWriter" name="replyWriter" value="${signInMemberDTO.nick }" />
										<textarea id="replyContent" name="replyContent" class="form-control" rows="3" style="resize: none" placeholder="Please leave a comment! Kindly use polite language!"></textarea>
										<div class="text-right">
											<button type="button" class="btn btn-info btn-sm" onclick="javascript:writeReplyProcess();">Complete</button>
										</div>
									</div>
								</form>
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
						<!-- Comment Writing part End ( This section is seen only by sign-in User. ) -->
					</div>
					<!-- The button of Same thought -->
					<div class="form-group"  style="margin-top: 50px; margin-bottom: 100px;">
						<center>
							<a href="read?postNo=${postNo}" onclick="javascript:like();">
								<input type="hidden" id="postNo" name="postNo" value="${postNo}" />
								<img src="${root }/image/sameFeeling.png" width="100" height="100">
							</a>
							<br><strong>★${readPostDTO.sameThinking }★</strong>
						</center>
					</div>
					<div class="form-group">
						<div class="text-right">
							<button type="button" class="btn btn-primary btn-sm" onclick="javascript:goMain();">Back to List</button>
							<a href="modify?postNo=${postNo }" class="btn btn-info btn-sm">Edit</a>
							<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:deletePost();">Delete</button>
							<c:choose>
								<%-- 로그인을 한 회원에게만 보이는 게시글 신고버튼 The button to report for posts visible only to logged-in users --%>
								<c:when test="${signInMemberDTO.signIn == true }">
									<a href="report?postNo=${postNo }" class="btn btn-danger btn-sm">Report Post</a>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
							&emsp;&emsp;
						</div>
					</div>
				</div>
			</div>
		</div>
	<div class="col-sm-3"></div>
</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>