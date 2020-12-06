<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/registerForm.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<script>
	$(function(){
		$("#findIdForm").submit(function(){
			if($("#findIdForm>input[type=text]").val() =="" ){
				alert("회원 정보를 입력하세요.");
				return false;
			}
			
			var url="/home/registFindId";
			var data = $("#findIdForm").serialize();
			$.ajax({
				type : 'POST',
				url : url,
				data : data,
				success : function(result){
					console.log(result);
					alert(result);
				},error : function(){
					console.log("아이디 찾기 에러");
				}
			});
			return false;
		});
		
		$("#findPwdForm").submit(function(){
			var url = "/home/registFindPwd";
			var data = $("#findPwdForm").serialize();
			$.ajax({
				type : 'POST',
				url : url,
				data : data,
				success : function(result){
					if(result>0){
						alert("등록된 메일로 임시 비밀번호가 발송되었습니다.\n이메일 확인 후 로그인을 진행해주세요.");						
					}else{
						alert("입력한 정보와 일치하는 회원 정보가 없습니다.");
					}
				},error : function(){
					console.log("비밀번호 찾기 에러");
				}
			});
			return false;
		});
	});
</script>

<div class="registerMainDiv" style='text-align:center'>
	<h1 style='margin:120px 0 35px 0'>아이디 비밀번호 찾기</h1>
	<hr id="hr2"/>
	<p id="t1">아이디 비밀번호를 잊어버리셨나요?<br/>
	가입 시 등록한 이메일을 입력하시면 임시 비밀번호를 보내드립니다.</p>

	<div id="cntbox">
	<div style='margin:0; text-align:center'>
		<div class="find">
			<b id="findId"><span class="l">&emsp;|</span> 아이디 찾기</b>
		</div>
		<form id="findIdForm">
			<input type="text" name="username" placeholder="  이름을 입력해주세요"/><br/>
			<input type="text" name="email" placeholder="  가입 시 등록한 이메일을 입력해주세요"/><br/>
			<input type="submit" class="mint_Btn" value=" 아이디 찾기"  style='width:700px; height:60px; font-size:22px; letter-spacing:1px; border-radius:7px'/>
		</form>

		<div class="find">
			<b id="findPwd"><span class="l">&emsp;|</span> 비밀번호 찾기</b>
		</div>
		<form id="findPwdForm">
			<input type="text" name="username" placeholder="  이름을 입력해주세요"/><br/>
			<input type="text" name="userid" placeholder="  아이디를 입력해주세요"/><br/>
			<input type="text" name="email" placeholder="  가입 시 등록한 이메일을 입력해주세요"/><br/>
			<input type="submit" class="WMint_Btn" value= "비밀번호 찾기" style='width:700px; height:60px; font-size:22px; letter-spacing:1px; border-radius:7px; border:1px solid #00B0B0'/><br/>
			<input type="button" class="mint_Btn" value="로그인" onclick="location.href='/home/login'" style='width:700px; height:60px; font-size:22px; letter-spacing:1px; border-radius:7px'/>
		</form>
	</div>
	</div>
</div>