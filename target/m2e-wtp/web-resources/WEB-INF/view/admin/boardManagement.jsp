<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script>

	// 1. Create a Category (카테고리 생성)
	function makeCategory() {

		var boardCategoryName = $("#boardCategoryName").val()

		if (boardCategoryName.length == 0) {
			alert('Please type in the category name.');
			return;

		} else {

			var formData = new FormData($('#newCategoryDTO')[0]);

			$.ajax({
				url : "${root}admin/makeCategory",
				data : formData,
				cache : false,
				async : true,
				contentType : false,
				processData : false,
				type : "POST",
				success : 
					function(obj) {
						if (obj != null) {
							var result = obj.result;

							if (result == null) {
								alert("This category name already exists. Please choose a different name.");
								return;

							} else {
								alert("New category is created successfully!");
								location.reload(true);
							}
						}
					},
				error : 
					function(request, status, error) {
						alert("code:" + request.status + "\n" + "message:"+ request.responseText + "\n" + "error:"+ error);
					}
				})
			}
	}

	// 2. Deleting a Category (카테고리 삭제)
	function deleteCategory() {

		var boardCategoryNo = $("#boardCategoryNo").val();

		var yn = confirm("Would you like to remove this category?");

		if (yn) {

			$.ajax({
				url : "${root}admin/deleteCategory",
				type : "POST",
				data : { boardCategoryNo : boardCategoryNo },
				dataType : "JSON",
				success : function(obj) {

					if (obj != null) {
						var result = obj.result;

						if (result == "success") {
							alert("The category was eliminated.");
							location.reload(true);
						} else {
							alert("The category is not eliminated. Please, confirm one more time.");
							return;
						}
					}
				},
				error : function(request, status, error) {
					alert("You don't have the right to delete The Category");
				}

			});
		}
	}

	// 3. Creating a new board (새로운 게시판 생성)
	function makeBoard() {

		var boardName = $("#boardName").val();

		if (boardName.length == 0) {
			alert('Please, enter a name of new board.');
			return;

		} else {

			var formData = new FormData($('#newBoardDTO')[0]);
			alert(formData);

			$.ajax({
				url : "${root}admin/makeNewBoard",
				data : formData,
				cache : false,
				async : true,
				contentType : false,
				processData : false,
				type : "POST",
				success : function(obj) {
					if (obj != null) {

						var result = obj.result;

						if (result == null) {
							
							alert("Sorry, You cannot use this board's name because This board's name is already in use in The Category, ");
							return false;

						} else {
							
							alert("A new board has been created.");
							location.reload(true);

						}
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:"+ error);
				}
			})	
		}
	}

	// 4. Chang a board's name (게시판 이름 변경)
	function changeBoardName() {
		
    	var boardName = $("#boardName").val(); 
    	var boardNo = $("#boardNo").val();
    	var boardCategoryNo = $("#boardCategoryNo1").val(); 
    
    	if (boardName.length === 0) {
        	alert("please, Enter the board's name that you want to change. ");
        	return;
    	}
    	
    	var formData = new FormData($('#boardDTOtoChange')[0]);

		$.ajax({
			url: "${root}admin/changeBoardName",
			data: formData,
			cache: false,
        	async: true,
        	contentType: false,
        	processData: false,
        	type: "POST",
        	success: function(obj) {

        		if (obj != null) {
        			var result = obj.result;
        			
        			if (result == null) {
        				
        				alert("A board with that name already exists in this category. Please choose a different name.");
        			
        			} else {
        				
        				alert("The Board's name is changed successfully.");
						location.reload(true);
                	}
            	}
        	},
        	error: function(request, status, error) {
            		alert("code:" + request.status + "\nmessage:" + request.responseText + "\nerror:" + error);
        	}
    	});
	}

	// 5. 게시판이 속한 카테고리의 변경 (Updating the board’s category)
	function changeCategory() {

		var boardName = $("#boardNameToUpdate").val();
		var boardNo = $("#boardNoToChangeCategory").val();
		var boardCategoryNo = $("#boardCategoryNo").val();
		var formData = new FormData($('#categoryDTOtoChange')[0]);
		
		console.log("전송할 게시판 이름:", boardName);
		console.log("전송할 게시판 번호:", boardNo);
		console.log("전송할 카테고리 번호:", boardCategoryNo);
		
		$.ajax({
			
			url : "${root}admin/changeCategory",
			data : formData,
			cache : false,
			async : true,
			contentType : false,
			processData : false,
			type : "POST",
			success : function(obj) {

						if ( obj.boardCategoryNo != undefined) {
						
							alert("The Category is moved successfully.");
							location.reload(true);
							
						} else {
							alert("Sorry, The board cannot be moved Because The Board's name has been already in The Category.");
						
						}
					}, 
			error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:"+ error);
					}
		})
	}
	
	// 6. 게시판 삭제 Deleting the board
	function deleteTheBoard(){
		
		var boardNo = $("#boardNo").val(); 
		var yn = confirm("Would you like to delete the board?");
		
		if(yn){
			$.ajax({
				url      : "${root}admin/deleteBoard",
				data     : { boardNo : boardNo },
				dataType : "JSON",
				cache    : false,
				async    : true,
				type     : "POST",
				success  : 
					function(obj) {
					
						if(obj != null){
						
							var result = obj.result;
						
							if(result == "success"){
							
							alert("The Board was deleted Successfully.");
							return;
							
							} else {
								alert("Fail('_')// The Board was not deleted.");
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
body {
	background-image: url(${root }image/bottom-bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
	background-attachment: fixed;
}
/* Slider's Part CSS */
.slider img {
	display: block;
	width: 100%;
	max-width: 100%;
	height: 300px;
}
</style>
</head>
<body>
<!-- Menu -->
<c:import url="/WEB-INF/view/include/topMenu.jsp" />
<!-- Middle's Picture-->
<article class="slider">
	<img src="${root }image/jewely.png">
</article>
<!-- Area for content on the main page -->
<div style="padding-top: 50px; padding-bottom: 50px;">
	<div class="container">
		<h3><strong>For the Administrator Only</strong></h3>
		<hr>
		<h5><strong>1. Categories</strong></h5>
			<form name="newCategoryDTO" method="post" id="newCategoryDTO" style="padding-top: 10px; padding-bottom: 10px">
				1) Creation of new Category<br>
				(1) new Category's Name :
				<input type="text" id="boardCategoryName" value="" name="boardCategoryName" style="width: 300px;">
				<button type="button" class="btn btn-warning btn-sm" style="text-align: right;" onClick="makeCategory();">Create</button>
			</form>
			<form name="deleteCategoryDTO" method="post" id="deleteCategoryDTO" style="padding-top: 10px; padding-bottom: 20px;">
				2) Deletion of The category<br>
				(1) The category to delete : 
				<select name="boardCategoryNo" id="boardCategoryNo" style="width: 300px;">
					<c:forEach var="CategoryListDTO" items="${CategoryList }">
						<option value="${CategoryListDTO.boardCategoryNo }">${CategoryListDTO.boardCategoryName }</option>
					</c:forEach>
				</select>
				<button type="button" class="btn btn-warning btn-sm" style="text-align: right;" onClick="deleteCategory();">Delete</button>
				<br>
				<font color="red">Please, Note that all boards and posts belonging to the category will also be deleted if you delete a category.</font>
			</form>
			<hr>
			
			<form name="newBoardDTO" method="post" id="newBoardDTO" style="padding-top: 10px; padding-bottom: 20px;">
				<h5><strong>2. Board</strong></h5>
				1) Creation of new Board<br>
				(1) The Category that new board will belong to :
				<select name="boardCategoryNo" style="width: 300px;">
					<c:forEach var="CategoryListDTO" items="${CategoryList }">
						<option value="${CategoryListDTO.boardCategoryNo }">${CategoryListDTO.boardCategoryName }</option>
					</c:forEach>
				</select>
				<br>
				(2) new Board Name to Create :
				<input type="text" id="boardName" name="boardName" value="" style="width: 300px;">
				<button type="button" class="btn btn-warning btn-sm" style="text-align: right;" onClick="makeBoard();">Create</button>
				<!-- button Type이 button으로 설정되면, 이 버튼을 작동시켜도 화면이 동기화되지 않는다. 
				반면, Button Type이 submit으로 설정되거나 아예 아무것도 설정되지 않는 경우 이 버튼을 작동시키면 화면이 동기화되여 새로고침이 된다. -->
			</form>

			<form id="boardDTOtoChange" method="post" style="padding-top: 20px; padding-bottom: 10px;">
			2) The Change of Board's name<br>
			(1) The Board to Update the name:
			<select name="boardNo" id="boardNo" style="width: 300px;" onchange="updateBoardCategoryNo();">
				<c:forEach var="BoardListDTO" items="${BoardList }">
					<option value="${BoardListDTO.boardNo }" data-category="${BoardListDTO.boardCategoryNo }">
						${BoardListDTO.boardNo } - ${BoardListDTO.boardName } (${BoardListDTO.boardCategoryNo })
            		</option>
            	</c:forEach>
            </select>
            <br>
            <!-- boardCategoryNo 값을 동적으로 설정 -->
            <input type="hidden" id="boardCategoryNo1" name="boardCategoryNo" value="">
            (2) The New Name of the board : 
            <input type="text" id="boardName" name="boardName" style="width: 300px;">
            <button class="btn btn-warning btn-sm" onClick="changeBoardName();">Edit</button>
			</form>
			<script>
				function updateBoardCategoryNo() {
					const selectedOption = document.getElementById("boardNo").selectedOptions[0];
					const categoryNo = selectedOption.getAttribute("data-category");
					document.getElementById("boardCategoryNo1").value = categoryNo;
				}
			</script>

			<form style="padding-top: 10px; padding-bottom: 20px;">
				3) Deleting a Board<br>
				(1) The board to delete:
				<select name="boardNo" style="width: 300px;">
					<c:forEach var="BoardListDTO" items="${BoardList }">
						<option value="${BoardListDTO.boardNo }">${BoardListDTO.boardNo }-${BoardListDTO.boardName }</option>
					</c:forEach>
				</select>
				<button class="btn btn-warning btn-sm" style="text-align: right;" onClick="deleteTheBoard();">Delete</button>
				<br>
				<font color="red">Please, Note that all posts belonging to this board will be deleted if you delete this board.</font>
			</form>

			<form id="categoryDTOtoChange" method="post" style="padding-top: 20px; padding-bottom: 10px;">
				4) The Change of Category<br>
				(1) The board to change the category :
				<select id="boardNoToChangeCategory" name="boardNo" style="width: 300px;" onchange="updateBoardName();">
					<c:forEach var="BoardListDTO" items="${BoardList }">
						<option value="${BoardListDTO.boardNo }" data-name="${BoardListDTO.boardName}">
							${BoardListDTO.boardNo }-${BoardListDTO.boardName }
						</option>
					</c:forEach>
				</select>
				<br>
				<!-- 이름을 동적으로 설정 Setting name dynamically -->
				<input type="hidden" id="boardNameToUpdate" name="boardName" value="">
				(2) The new Category to move to : 
				<select name="boardCategoryNo" style="width: 300px;">
					<c:forEach var="CategoryListDTO" items="${CategoryList }">
						<option value="${CategoryListDTO.boardCategoryNo }">${CategoryListDTO.boardCategoryName }</option>
					</c:forEach>
				</select>
				<button type="button" class="btn btn-warning btn-sm" style="text-align: right;" onClick="changeCategory();">
					Change the category of the board
				</button>
				<br>
				<font color="red">Please, select the category you want the board to move into. </font>
			</form>
		<script>
		function updateBoardName() {
		    var selectedOption = document.getElementById("boardNoToChangeCategory").selectedOptions[0];
		    var boardName = selectedOption.getAttribute("data-name");
		    document.getElementById("boardNameToUpdate").value = boardName;
		}
		</script>
	</div>
</div>
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>