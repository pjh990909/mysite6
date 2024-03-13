<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css">

</head>


<body>
	<div id="wrap">

		<!-- header +nav -->
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- header +nav -->

		<div id="container" class="clearfix">
			<div id="aside">
				<h2>게시판</h2>
				<ul>
					<li><a href="">일반게시판</a></li>
					<li><a href="${pageContext.request.contextPath}/rboard/commentlist">댓글게시판</a></li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">

				<div id="content-head">
					<h3>일반게시판</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>게시판</li>
							<li class="last">일반게시판</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->

				<div id="board">
					<div id="list">
						<form action="" method="get">
							<div class="form-group text-right">
								<input type="text">
								<button type="submit" id=btn_search>검색</button>
							</div>
						</form>
						<table>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>group_no</th>
									<th>order_no</th>
									<th>depth</th>
									<th>댓글쓰기</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${requestScope.rList}" var="rboardVo">
									<tr>
										<td>${rboardVo.no}</td>
										<c:if test="${rboardVo.depth == 0}">
										<td class="text-left"><a href="">${rboardVo.title}</a></td>
										</c:if>
										<c:if test="${rboardVo.depth == 1}">
										<td class="text-left"><a href="">&nbsp;&nbsp;&#8627;${rboardVo.title}</a></td>
										</c:if>
										<c:if test="${rboardVo.depth == 2}">
										<td class="text-left"><a href="">&nbsp;&nbsp;&nbsp;&nbsp;&#8627;${rboardVo.title}</a></td>
										</c:if>
										<td>${rboardVo.group_no}</td>
										<td>${rboardVo.order_no}</td>
										<td>${rboardVo.depth}</td>
										<td><a href="${pageContext.request.contextPath}/rboard/commentform?group_no=${rboardVo.group_no}&order_no=${rboardVo.order_no}&depth=${rboardVo.depth}">[작성]</a></td>
										<c:if test="${authUser.no == rboardVo.user_no}">
											<td><a href="">[삭제]</a></td>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- //list -->
					<br> <br> <br> <br>
					<div id="writeForm2">
						<form action="${pageContext.request.contextPath}/rboard/commentwrite" method="get">
							<!-- 제목 -->
							<div class="form-group">
								<label class="form-text" for="txt-title">제목</label> <input type="text" id="txt-title" name="title" value="" placeholder="제목을 입력해 주세요">
							</div>

							<!-- 내용 -->
							<div class="form-group">
								<textarea id="txt-content" name="content"></textarea>
							</div>
							<input type="text" name ="group_no" value="${param.group_no}">
							<input type="text" name ="order_no" value="${param.order_no}">
							<input type="text" name ="depth" value="${param.depth}">

							<button id="btn_add" type="submit">등록</button>

						</form>
						<!-- //form -->
					</div>



				</div>
				<!-- //board -->
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

</html>
