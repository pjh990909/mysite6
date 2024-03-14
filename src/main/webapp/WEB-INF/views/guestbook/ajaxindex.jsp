<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">

<!-- Axios 라이브러리 포함 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<style>
.modal {
	display: block;
}

.modal .modal-content {
	width: 818;
	border: 1px solid #000000;
}
</style>


</head>

<body>
	<div id="wrap">

		<!-- header +nav -->
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- header +nav -->

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>방명록</h2>
				<ul>
					<li>일반방명록</li>
					<li>ajax방명록</li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">

				<div id="content-head" class="clearfix">
					<h3>일반방명록</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>방명록</li>
							<li class="last">일반방명록</li>
						</ul>
					</div>
				</div>
				<!-- //content-head -->

				<div id="guestbook">
					<form id="guestForm" action="${pageContext.request.contextPath}/guest/add" method="post">
						<table id="guestAdd">
							<colgroup>
								<col style="width: 70px;">
								<col>
								<col style="width: 70px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<td><label class="form-text" for="input-uname">이름</label></td>
									<td><input id="input-uname" type="text" name="name"></td>
									<td><label class="form-text" for="input-pass">패스워드</label></td>
									<td><input id="input-pass" type="password" name="password"></td>
								</tr>
								<tr>
									<td colspan="4"><textarea name="content" cols="72" rows="5"></textarea></td>
								</tr>
								<tr class="button-area">
									<td colspan="4" class="text-center"><button id="btnAdd" type="submit">등록</button></td>
								</tr>
							</tbody>

						</table>
						<!-- //guestWrite -->
						<input type="hidden" name="action" value="add">

					</form>

					<!-- 모달 창 컨텐츠 -->
					<div id="myModal" class="modal">
						<div id="guestbook" class="modal-content">
							<div class="closeBtn">×</div>
							<div class="m-header">패스워드를 입력하세요</div>
							<div class="m-body">
								<input class="m-no" type="password" name="password" value=""><br> <input class="m-password" type="text" name="no" value="">
							</div>
							<div class="m-footer">
								<button class="btnDelete" type="button">삭제</button>
							</div>
						</div>
					</div>
					<div id="guestbookListArea"></div>






				</div>
				<!-- //guestbook -->

			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->

		<!-- footer 불러오기 -->
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->
	</div>
	<!-- //wrap -->

</body>

<script>
document.addEventListener("DOMContentLoaded",function(){
	
	//리스트요청 데이타만 받을거
	 axios({
	        method: 'get',           // put, post, delete                   
	        url: '/mysite6/api/guestbooks',
	        headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
	        //params: guestbookVo,  //get방식 파라미터로 값이 전달
	        //data: guestbookVo,   //put, post, delete 방식 자동으로 JSON으로 변환 전달
	        responseType: 'json' //수신타입
	    })
	    .then(function (response) {
	        console.log(response); //수신데이타
	        
	    //리스트자리에 글을 추가한다
	    for(let i=0;i<response.data.length;i++){
	    	let guestVo = response.data[i];
	    	render(guestVo,"down");
	    }
	    
	    })
	    .catch(function (error) {
	        console.log(error);
	 	});
	 
	
	//등록버튼 클릭했을때
	let guestForm = document.querySelector("#guestForm");
	console.log("guestForm");
	
	guestForm.addEventListener("submit",function(event){
		event.preventDefault();
		console.log("글쓰기버튼 클릭");
	
	//폼데이터 수집	
	let name = document.querySelector('[name="name"]').value.trim();
	let password = document.querySelector('[name="password"]').value.trim();
	let content = document.querySelector('[name="content"]').value.trim();
	
	
	let guestVo = {
		name:name,
		password:password,
		content:content,
	};
	
	//서버데이터로 전송
	
	axios({
	        method: 'post',           // put, post, delete                   
	        url: '/mysite6/api/guestbooks/delete',
	        headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
	        params: guestVo,  //get방식 파라미터로 값이 전달
	        //data: guestbookVo,   //put, post, delete 방식 자동으로 JSON으로 변환 전달
	        responseType: 'json' //수신타입
	    })
	    .then(function (response) {
	        console.log(response); //수신데이타
	        console.log(response.data);
	    	let guestbookVo = response.data
	    	
	    	//그리기
	    	render(guestbookVo,"up");
	    	
	    	//폼비우기
	    	guestForm.reset();
	    })
	    .catch(function (error) {
	        console.log(error);
	 	});
	
	console.log(guestVo);
	
	});
	
	//모델창 호출버튼을 클릭했을때
	let guestbookListArea = document.querySelector("#guestbookListArea");
	guestbookListArea.addEventListener("click",function(event){
		console.log(event.target.tagName);
		
		if(event.target.tagName == "BUTTON"){
			//console.log("모달창 보이기");
			
			//let modal = document.querySelector(".modal");
			//modal.style.display = "block";
			let noTag = document.querySelector('[name="no"]');
			noTag.value = event.target.dataset.no
			
		}
		
		
	});
	
	//모달창에 삭제버튼을 클릭했을때 (진짜삭제)
	let btmDelete = document.querySelector('.btnDelete');
	btmDelete.addEventListener("click",function(){
		console.log("클릭");
		
		let no = document.querySelector('.m-no').value;
		let password = document.querySelector('.m-password').value;
		
		//데이타모으고
		let guestbookVo = {
				no:no,
				password:password
		}
		
		// 서버로 전송
		axios({
	        method: 'post',           // put, post, delete                   
	        url: '/mysite6/api/guestbooks',
	        headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
	        //params: guestbookVo,  //get방식 파라미터로 값이 전달
	        data: guestbookVo,   //put, post, delete 방식 자동으로 JSON으로 변환 전달
	        responseType: 'json' //수신타입
	    	})
		    .then(function (response) {
		        console.log(response); //수신데이타
		        console.log(response.data);
		    	let guestbookVo = response.data
	    	
	    		//그리기
	    		render(guestbookVo);
	    	
	    		//폼비우기
	    		guestForm.reset();
	    	})
	    	.catch(function (error) {
	        console.log(error);
	 		});
	
			console.log(guestVo);
	
		
	});
	
	
	
	
});
//방명록 글 그리기
function render(guestBookVo,dir) {
   //console.log("render()");
   //console.log(guestBookVo);
   
   let guestbookListArea = document.querySelector("#guestbookListArea");
   //console.log(guestbookListArea);
   
   
   let str = '';
   str += '<table class="guestRead">';
   str += '	   <colgroup>';
   str += '		   <col style="width: 10%;">';
   str += '		   <col style="width: 40%;">';
   str += '		   <col style="width: 40%;">';
   str += '		   <col style="width: 10%;">';
   str += '	   </colgroup>';
   str += '	   <tr>';
   str += '		   <td>'+ guestBookVo.no+'</td>';
   str += '		   <td>'+ guestBookVo.name+'</td>';
   str += '		   <td>'+ guestBookVo.reg_date+'</td>';
   str += '		   <td><button id="btnModal" type="button" data-no="'+ guestBookVo.no +'">삭제</button></td>';
   str += '	   </tr>';
   str += '	   <tr>';
   str += '		   <td colspan=4 class="text-left">'+ guestBookVo.content+'</td>';
   str += '	   </tr>';
   str += '</table>';
   
   
   if(dir == "down"){
   		guestbookListArea.insertAdjacentHTML("beforeend",str);
   }else if(dir == "up"){
	   guestbookListArea.insertAdjacentHTML("afterbegin",str);
   }else {
	   console.log("방향체크");
   }
   
   
   
   
}

</script>
</html>