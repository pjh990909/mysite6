<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="${pageContext.request.contextPath }/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/assets/css/gallery.css" rel="stylesheet" type="text/css">

<style>
	.v-on{
		visibility: visible;
	}
	
	.v-off{
		visibility: hidden;
	}

</style>

</head>


<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- //header -->
		<!-- //nav -->

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>갤러리</h2>
				<ul>
					<li><a href="">일반갤러리</a></li>
					<li><a href="">파일첨부연습</a></li>
				</ul>
			</div>
			<!-- //aside -->
			<div id="content">

				<div id="content-head">
					<h3>갤러리</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>갤러리</li>
							<li class="last">갤러리</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->


				<div id="gallery">
					<div id="list">
						
						<c:if test="${!(empty sessionScope.authUser.no)}">
							<button  id="btnImgUpload" class="v-on" type="button">이미지올리기</button>
						</c:if>
						<div class="clear"></div>
					

						<ul id="viewArea">

							<!-- 이미지반복영역 -->
							<c:forEach items="${requestScope.gList}" var="galleryVo" varStatus="status">
								<li>
									<div class="view">
										<img class="imgItem" data-no="${galleryVo.no}" data-savename="${galleryVo.saveName}" data-content="${galleryVo.content}"
											data-user_no="${galleryVo.user_no}" src="${pageContext.request.contextPath}/upload/${galleryVo.saveName}">
										<div class="imgWriter">
											작성자: <strong>${galleryVo.name}</strong>
										</div>
									</div>
								</li>
							</c:forEach>
							<!-- 이미지반복영역 -->


						</ul>
					</div>
					<!-- //list -->
				</div>
				<!-- //board -->
			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->


		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->

	</div>
	<!-- //wrap -->

	<!-- 이미지등록 팝업(모달)창 -->
	<div id="addModal" class="modal">
		<div class="modal-content">
			<form action="${pageContext.request.contextPath}/gallery/upload" method="post" enctype="multipart/form-data">
				<div class="closeBtn">×</div>
				<div class="m-header">간단한 타이틀</div>
				<div class="m-body">
					<input type="hidden" name="userNo" value="${authUser.no}">
					<div>
						<label class="form-text"></label> <input id="addModalContent" type="text" name="content" value="">
					</div>
					<div class="form-group">
						<label class="form-text">이미지선택</label> <input id="file" type="file" name="file" value="">
					</div>
				</div>
				<div class="m-footer">
					<button type="submit">저장</button>
				</div>
			</form>
		</div>
	</div>


	<!-- 이미지보기 팝업(모달)창 -->
	<div id="viewModal" class="modal">
		<div class="modal-content">
			<div class="closeBtn">×</div>
			<div class="m-header">간단한 타이틀</div>
			<div class="m-body">
				<div>
					<img id="viewModelImg" src="">
					<!-- ajax로 처리 : 이미지출력 위치-->
					<br> <input class="m-no" type="text" name="no" value="">
				</div>
				<div>
					<p id="viewModelContent"></p>
				</div>
			</div>
			<div class="m-footer">
				<button>삭제</button>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		
		//등록모델창 호출버튼을 클릭했을때
		let authNo = "${sessionScope.authUser.no}";
		if(authNo != ""){
			let btnImgUpload = document.querySelector("#btnImgUpload");
			btnImgUpload.addEventListener("click", calluploadModal);
		}
		

		//등록모달창 닫기 버튼 (x) 클릭했을때
		let closeBtn = document.querySelector("#addModal .closeBtn");
		closeBtn.addEventListener("click", closeuploadModal);

		//보기 및 삭제 모델창 호출버튼을 클릭했을때
		let list = document.querySelector("#list .imgItem");
		list.addEventListener("click", calldeleteModal);

		//보기 및 삭제 모달창 닫기 버튼 (x) 클릭했을때
		let closeBtn2 = document.querySelector("#viewModal .closeBtn");
		closeBtn2.addEventListener("click", closedeleteModal);

		////////////함수들//////////////////

		//등록모델창 호출버튼을 클릭했을때
		function calluploadModal() {

			let addModal = document.querySelector("#addModal");
			addModal.style.display = "block";

		}

		//등록모달창 닫기 버튼 (x) 클릭했을때
		function closeuploadModal() {
			let addModal = document.querySelector("#addModal");
			addModal.style.display = "none";
		}

		//보기 및 삭제 모델창 호출버튼을 클릭했을때
		function calldeleteModal(event) {
			console.log("sad");
			
			let viewModal = document.querySelector("#viewModal");
			viewModal.style.display = "block";

			let noTag = document.querySelector('[name="no"]');
			noTag.value = event.target.dataset.no

			let imgTag = document.querySelector("#viewModelImg");
			imgTag.src = "${pageContext.request.contextPath}/upload/"
					+ event.target.dataset.savename;

			let contentTag = document.querySelector("#viewModelContent");
			contentTag.textContent = event.target.dataset.content;

		}

		//보기 및 삭제 모달창 닫기 버튼 (x) 클릭했을때
		function closedeleteModal() {
			let viewModal = document.querySelector("#viewModal");
			viewModal.style.display = "none";
		}

	})
</script>




</html>

