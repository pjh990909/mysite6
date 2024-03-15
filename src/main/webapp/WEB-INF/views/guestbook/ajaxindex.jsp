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
/* 모달창 배경 회색부분*/
.modal {
	width: 100%; /* 가로전체 */
	height: 100%; /* 세로전체 */
	display: none; /* 시작할때 숨김처리 */
	position: fixed; /* 화면에 고정 */
	left: 0; /* 왼쪽에서 0에서 시작 */
	top: 0; /* 위쪽에서 0에서 시작 */
	z-index: 999; /* 제일 위에서 */
	overflow: auto; /* 내용이 많으면 스크롤 생김*/
	background-color: rgba(0, 0, 0, 0.4); /* 배경이 검정색에 반투명 */
}
/* 모달창 내용 흰색부분*/
.modal .modal-content {
	width: 600px;
	margin: 100px auto; /* 상하 100px, 좌우 가운데 */
	padding: 0px 20px 20px 20px; /* 안쪽 여백 */
	background-color: #ffffff; /* 배경색 흰색 */
	border: 1px solid #888888; /*테두리 모양 색 */
}
/*모달창 닫기버튼*/
.modal .modal-content .closeBtn {
	text-align: right;
	color: #aaaaaa;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
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
								<input class="m-password" type="password" name="password" value=""><br> <input class="m-no" type="hidden" name="no" value="">
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
	
	//돔트리가 생성완료 되었을때
	//리스트요청 데이타만 받을거야
	getListAndRender();
	
	//등록버튼 클릭했을때
	let guestForm = document.querySelector("#guestForm");
	guestForm.addEventListener("submit",addAndRender)
	
	
	//모델창 호출버튼을 클릭했을때
	let guestbookListArea = document.querySelector("#guestbookListArea");
	guestbookListArea.addEventListener("click", callModal);
	
	//모달창 닫기 버튼 (x) 클릭했을때
	let closeBtn = document.querySelector(".closeBtn");
	closeBtn.addEventListener("click",closeModal);
	
	
	
	
	//모달창에 삭제버튼을 클릭했을때 (진짜삭제)
	let btmDelete = document.querySelector('.btnDelete');
	btmDelete.addEventListener("click",DeleteAndRemove);
	
////////////함수들//////////////////	


//리스트가져오고 그리기
function getListAndRender() {
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

}

//글저장
function addAndRender(){
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
	
	/*{"name":"황일영", "password:"1234", "content": "안녕하세요"}*/
	//서버데이터로 전송
	axios({
	        method: 'post',           // put, post, delete                   
	        url: '${pageContext.request.contextPath}/api/guestbooks',
	        headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
	        //params: guestVo,  //get방식 파라미터로 값이 전달
	        data: guestVo,    //put, post, delete 방식 자동으로 JSON으로 변환 전달
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
	
	
}







	
});
//방명록 글 그리기
function render(guestBookVo,dir) {
   //console.log("render()");
   //console.log(guestBookVo);
   
   let guestbookListArea = document.querySelector("#guestbookListArea");
   //console.log(guestbookListArea);
   
   
   let str = '';
   str += '<table id="t-'+guestBookVo.no +'" class="guestRead">';
   str += '	   <colgroup>';
   str += '		   <col style="width: 10%;">';
   str += '		   <col style="width: 40%;">';
   str += '		   <col style="width: 40%;">';
   str += '		   <col style="width: 10%;">';
   str += '	   </colgroup>';
   str += '	   <tr>';
   str += '		   <td>'+ guestBookVo.no +'</td>';
   str += '		   <td>'+ guestBookVo.name +'</td>';
   str += '		   <td>'+ guestBookVo.reg_date +'</td>';
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
//모델창 호출버튼을 클릭했을때
function callModal(){
	
		console.log(event.target.tagName);
		
		if(event.target.tagName == "BUTTON"){
			//console.log("모달창 보이기");
			
			let modal = document.querySelector(".modal");
			modal.style.display = "block";
			
			
			let noTag = document.querySelector('[name="no"]');
			noTag.value = event.target.dataset.no
			
			
			let tag = document.querySelector('.m-password');
			
			tag.value=""
		}
		
}
//모달창 닫기 버튼 (x) 클릭했을때
function closeModal() {
	let modal = document.querySelector("#myModal");
	modal.style.display = "none";
}

//모달창에 삭제버튼을 클릭했을때 (진짜삭제)
function DeleteAndRemove(){
	console.log("클릭");
	let modal = document.querySelector("#myModal");
	modal.style.display = "none";
	
	let no = document.querySelector('.m-no').value;
	let password = document.querySelector('.m-password').value;
	
	//데이타모으고
	let guestbookVo = {
			no:no,
			password:password
	}
	console.log(password);
	// 서버로 전송
	axios({
        method: 'delete',           // put, post, delete                   
        url: '${pageContext.request.contextPath}/api/guestbooks/'+no,
        //url: '${pageContext.request.contextPath}/api/guestbooks/delete',//과제로 할때 쓴거
        headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
        params: guestbookVo,  //get방식 파라미터로 값이 전달
        //data: guestbookVo,   //put, post, delete 방식 자동으로 JSON으로 변환 전달
        responseType: 'json' //수신타입
    	})
	    .then(function (response) {
	        console.log(response); //수신데이타
	        console.log(response.data);
	    	
	        if(response.data == 1){
		        let tagid = "#t-" + no;
		        console.log(tagid);
		        let removeTable = document.querySelector(tagid);
		        console.log(removeTable);
		        
		        removeTable.remove();
	        }else{
	        	window.alert("비밀번호를 다시 확인해주세요");
	        }
	        //del(no)//과제로 할때 쓴거
    		
    	})
    	.catch(function (error) {
        console.log(error);
 		});
}


//삭제(과제)
function del(no){
	let tdTag = document.querySelector(".guestRead tr td");
	
	if(no == tdTag.textContent){
		console.log( tdTag.parentElement.parentElement.parentElement);
		tdTag.parentElement.parentElement.remove();
	
	}
	
}

</script>
</html>