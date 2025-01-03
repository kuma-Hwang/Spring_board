<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row"></div>
<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			Board List Page
			<button id='regBtn' type="button"
				class="btn btn-xs pull-right btn-info">Register New Board</button>
		</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
			<table width="100%"
				class="table table-striped table-bordered table-hover"
				id="dataTables-example">
				<thead>
					<tr>
						<th>#번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>수정일</th>
					</tr>
				</thead>

				<c:forEach items="${list}" var="board">
					<tr>
						<td><c:out value="${board.bno}" /></td>
						<td><a class='move' href='<c:out value="${board.bno}"/>'>
							<c:out value="${board.title}" /></a>
						</td>
						<td><c:out value="${board.writer}" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${board.regDate}" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${board.updateDate}" /></td>
					</tr>
				</c:forEach>

			</table>

			<div class='row'>
				<div class="col-lg-12">

					<form id='searchForm' action="/board/list" method='get'>
						<select name='type'>
							<option value=""
								<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
							<option value="T"
								<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
							<option value="C"
								<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
							<option value="W"
								<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
							<option value="TC"
								<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목or
								내용</option>
							<option value="TW"
								<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목or
								작성자</option>
							<option value="TWC"
								<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목or
								내용 or 작성자</option>
						</select> 
						<input type='text' name='keyword'
							value='<c:out value="${pageMaker.cri.keyword}" />' /> 
						<input type='hidden' name='pageNum'
							value='<c:out value="${pageMaker.cri.pageNum}" />' /> 
						<input type='hidden' name='amount'
							value='<c:out value="${pageMaker.cri.amount}" />' />
						<button class='btn btn-default'>Search</button>
					</form>
				</div>
			</div>
			
			<div class='pull-right'>
				<ul class ="pagination">
					
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage -1}">Previous</a>
						</li>
					</c:if>
					
					<c:forEach var="num" begin="${pageMaker.startPage}" 
					  end="${pageMaker.endPage}" >
						<li class='paginate_button ${pageMaker.cri.pageNum == num ? "active":""} '>
						<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
						<a href="${pageMaker.endPage +1 }">Next
						</a></li>
					</c:if>
				
				</ul>
			</div>
			
			<form id='actionForm' action="/board/list" method='get'>
				<input type="hidden" name='pageNum' value = '${pageMaker.cri.pageNum}'>
				<input type="hidden" name='amount' value = '${pageMaker.cri.amount}'>
				<input type="hidden" name='type' value = '<c:out value="${ pageMaker.
				cri.type}"/>'>
				<input type="hidden" name='keyword' value = '<c:out value="${ pageMaker.
				cri.keyword}"/>'>
			</form>

			<!-- https://www.w3schools.com/bootstrap4/bootstrap_modal.asp -->
			<!-- The Modal -->
			<div class="modal" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">Modal Heading</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">처리가 완료되었습니다.</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>

					</div>
				</div>
				<!-- End Modal -->

			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-6 -->
</div>
<!-- /.row -->


<%@ include file="../includes/footer.jsp"%>

<script>
	$(document).ready(function() {
				var result = "${result}";

				checkModal(result);

				//모달 창을 보여준 뒤에는 더 이상 모달창이 필요하지않음.
				history.replaceState({}, null, null); //뒤로가기

				function checkModal(result) {
					if (result === '' || history.state) {
						return;
					} else {
						if (parseInt(result) > 0) {
							$(".modal-body").html(
									"게시글" + parseInt(result) + "번이 등록되었습니다.");
						}

						$("#myModal").modal("show");
					}
				}

				$("#regBtn").on("click", function() {
					self.location = "/board/register";
				});
				
				var actionForm = $("#actionForm");
				$(".paginate_button a").on("click", function(e){
					e.preventDefault();
					
					console.log('click');
					
					actionForm.find("input[name='pageNum']").val($(this).attr("href"));
					actionForm.submit();
				});
				
				$(".move").on("click", function(e) {
					e.preventDefault();
					actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
						actionForm.attr("action","/board/get");
						actionForm.submit();
				});

			

			let searchForm = $("#searchForm");

			$("#searchForm button").on("click", function(e) {
				if (!searchForm.find("option:selected").val()) {
					alert("검색종류를 선택하세요");
					return false;
				}

				if (!searchForm.find("input[name='keyword']").val()) {
					alert("키워드를 입력하세요");
					return false;
				}
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();

				searchForm.submit();

			});

		});


</script>