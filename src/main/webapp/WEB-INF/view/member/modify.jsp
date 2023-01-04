<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${root }js/validation.js"></script>
<script type="text/javascript">

	$(document).ready(function(){			});
	
	//1. 회원정보수정 버튼을 누른 뒤에  
	function modifyMemberDTO(){
		
		var nick = $("#nick").val(); // 대화명
		var question = $("#question").val(); //질문
		var answer = $("#answer").val(); //답
		var passwords = $("#passwords").val(); //작성자
		var passwordsConfirm = $("#passwordsConfirm").val(); //작성자

		var formData = new FormData($('#modifyMemberDTO')[0]);	
		
		if(nick == ""){			
			alert("사용하실 닉네임을 입력해주세요.");
			$("#nick").focus();
			return;
		}
		
		if (passwords == "" || passwordsConfirm == ""){			
			alert("패스워드를 입력해주세요.");
			$("#passwords").focus();
			return;
		}
	
		if(passwords == passwordsConfirm){
			$.ajax({   
				url      : "${root}member/modifyProcess", 
		        data     : formData,
				contentType: false, //이것을 붙이고 나서 수정 업로드가 된것이다. 
				processData: false, // 이것을 붙이고 수정 업로드가 되었다. 
				cache    : false,
				async    : true,
				type     : "POST",    
				success  : function(obj){ 
					if(obj != null){        
						var result = obj.result;
			            if(result == "success"){                
							alert("수정을 성공하였습니다."); 
							location.href = "${root}main";
			            } else {                
			            	alert("수정을 실패하였습니다.");    
			                return;
			            }
			        }
				},           
				error	 : function(request,status,error){	
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			}) //아작스		
		} else if(passwords != passwordsConfirm) {
			alert("패스워드는 같아야합니다. "); 
		}	
	} //펑션의 끝
	
</script>
<style>
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
body{ background-color: white; }
</style>
</head>
<body>
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/topMenu.jsp"/>
<!--가운데 그림-->
<article class="slider"><img src="${root }image/Camping.jpg"></article>
<!-- 회원가입 폼 -->
<div class="container" style="margin-top:50px; margin-bottom:50px;">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-7"><h4>회원정보수정</h4>
		<div class="card shadow-none">
		<div class="card-body">
		<form method='post' modelAttribute="modifyMemberDTO" id="modifyMemberDTO">
		<input type="hidden" id="memberNo" name="memberNo" value="${signInMemberDTO.memberNo }"/>
			<table>
				<tr>
					<td>이메일(E-mail address)</td>
	  				<td><input type="email" id="email" name="email" value="${modifyMemberDTO.email}" readonly class="form-control"/></td>			
				</tr>
				<tr>
	 	 			<td>비밀번호</td>
	  				<td><input type="password" name="passwords" id="passwords" value="${modifyMemberDTO.passwords}" class="form-control pw"/></td>
				</tr>
				<tr>
					<td>↑ 위 비밀번호 확인</td>
	  				<td>
						<input type="password" name="passwordsConfirm" id="passwordsConfirm"  value="${modifyMemberDTO.passwords}"  class="form-control pw"/>
						<font id="checkPw" size="2"></font>
	  				</td>
				</tr>
				<tr>
					<td>닉네임</td>
	  				<td>
	  					<input type="text" id="nick" name="nick" value="${modifyMemberDTO.nick}" class="form-control">
	  					<font id="checkNick" size="2"></font>
	  				</td>
				</tr>
				<tr>
					<td>이메일 또는 비밀번호 분실시 질문&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>
						<select name="question" id="question" class="form-control" value="${modifyMemberDTO.question }">
							<option value="hometown">당신의 고향은 어디입니까?</option>
    						<option value="nickname">별명은 무엇인가요? </option>
    						<option value="firstlove">첫사랑은 누구인가요?</option>
    						<option value="pet">애완동물의 이름은?</option>
    						<option value="treasure">당신의 보물1호는 무엇인가요?</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>↑ 위 질문에 대한 답</td>
					<td><input type="text" name="answer" id="answer" class="form-control" value="${modifyMemberDTO.answer }"/></td>
				</tr>
				<tr>
	  				<td colspan = "2" align = "center">
	  					<div class="text-right" style="margin-top:50px; margin-bottom:50px;">
							<input type="button" class="btn btn-danger" onclick="javascript:modifyMemberDTO();" value="회원정보수정 완료"/>
							<a href="${root }member/getOut" class="btn btn-danger">회원탈퇴</a>
							<!-- http://localhost:8090/GoroGoroCommunity/member/getOut -->
						</div>
	  				</td>
				</tr>
			</table>
			</form>
<script>
$('.pw').focusout(function(){
	
	let isPassOk = false;
	
	let passwords = $("#passwords").val();
    let passwordsConfirm = $("#passwordsConfirm").val();
    
    if (passwords != "" && passwordsConfirm != ""){
    	if(passwords == passwordsConfirm){
    		let isPassOk = true;
    		$("#checkPw").html('비밀번호가 일치합니다. ');
        	$("#checkPw").attr('color','green');
        	
        } else {
        	let isPassOk = false;
        	$("#checkPw").html('불일치 합니다. 다시한번 확인해주세요!');
            $("#checkPw").attr('color','red');
          
        }
    }
})

//닉네임 중복검사
$("#nick").blur(function(){
	
	$.ajax({
		url : "${root}member/checkNickInModify",
		type : "post",
		data : {nick: $("#nick").val()},
		success : function(result){
			if(result == "unavailable"){
				$("#checkNick").html('중복된 닉네임! 사용불가'); 
				$("#checkNick").attr('color','red');
			}else if(result == "available"){
				$("#checkNick").html('사용가능합니다.');
	        	$("#checkNick").attr('color','green');
			}
		}
	});
});
</script>
		</div>
		</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottomInfo.jsp" />
</body>
</html>