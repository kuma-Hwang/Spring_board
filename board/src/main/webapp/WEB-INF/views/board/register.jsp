<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp"%>

	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Tables</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board List Page</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<form role="form" action="/board/register" method="post">
						<div>
							<label>Title</label> <input class="form-control" name='title'>
						</div>
						
						<div class="form-group">
							<label>Text area</label> 
							<textarea class="form-control" rows="3" name='content'></textarea>
						</div>
						
						<div class="form-group">
							<label>Writer</label> 
							 <input class="form-control" name='writer'>
						</div>
						<button type="submit" class="btn btn-default btn-success">Submit Button</button>
						<button type="submit" class="btn btn-default">Reset Button</button>
					
					
					
					
					
						
					</form>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-6 -->
	</div>
	<!-- /.row -->


	<%@ include file="../includes/footer.jsp"%>