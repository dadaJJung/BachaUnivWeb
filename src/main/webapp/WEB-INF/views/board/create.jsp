<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<c:url value="/resources/bower_components/tinymce/tinymce.min.js"
	var="tinymce" />
<script src="${tinymce}"></script>
<script>
	function showname() {
		var name = document.getElementById('files');
		var list = [];

		for (var i = 0; i < name.files.length; i++) {
			list[i] = name.files.item(i).name;
		}

		return list;
	};

	$(document).ready(
			function() {
				$('#files').change(
						function() {
							var list = showname();

							for (var i = 0; i < list.length; i++) {
								$('#fileList').append(
										"<p>" + list[i]
												+ "</p>");

							}
						});

				$('#title').keyup(
						function(e) {
							var length = $('#title').val().length;
							if (length > 60) {
								$('#check-title-length').addClass('error')
										.html('maximum is 60 characters');
							} else {
								$('#check-title-length').removeClass('error')
										.html('');
							}
						});

				//form:errors 메세지 제어
				$('#title').keyup(function(e) {
					$('.boardTitle').html('');
				});
				$('#content').keyup(function(e) {
					$('.content').html('');
				});

				tinymce.init({
					selector : 'textarea',
					language : 'en',
					height : "200"
				});

				
				$('.filebox label[for="files"]').mouseover(
						function() {
							$('.filebox label[for="files"]').removeClass(
									'font-color');
							$('.filebox label[for="files"]').addClass(
									'upload');
						});

				$('.filebox label[for="files"]').mouseout(function() {
					$('.filebox label[for="files"]').addClass('font-color');
					$('.filebox label[for="files"]').removeClass('upload');
				});

			});
</script>





<div class="py-5">
	<div class="container col-lg-9 col-md-10 col-sm-11 mx-auto">
		<h4
			style="margin-bottom: 50px !important; padding-bottom: 20px !important; border-bottom: 1px dotted #8c8b8b;">
			create form</h4>

		<!-- action 태그 생략시 현재 url로 전송, form:form에서 method 생략시 post 방식 -->
		<form:form commandName="board" enctype="multipart/form-data">


           <form:hidden path="writerName" value="${USER.studentName}" />
           <form:hidden path="writer" value="${USER.studentNumber}" />


		  <div class="mb-3">
             <label for="writerName"><span class="title">WRITER : </span>${USER.studentName} (${USER.studentNumber})</label>
		  </div>


			<div class="md-form mb-3">
				<label for="title">TITLE</label>
				<form:input path="title" class="form-control" />
				<form:errors path="title" element="div" cssClass="error boardTitle" />
				<span id="check-title-length"></span>
			</div>
			

		<div class="mt-4 filebox row">
			<div class="col-md-3">
				<label for="files" class="font-color"><i class="fa fa-paperclip title"></i>  FILE UPLOAD</label> 
				<input type="file" name="files" id="files" multiple="multiple">
			</div>
			<div class="col-md-9 pt-10">
				<p id="fileList"></p>
			</div>
		</div>


			<div class="mt-4">
				<form:textarea path="content" class="form-control" />
				<form:errors path="content" element="div" cssClass="error content" />
			</div>




			<div class="md-form text-center ">
				<button type="submit" class="btn red-button">
					<i class="fa fa-check"></i> SUBMIT
				</button>

				<a href="../board/list" class="btn red-button"> <i
					class="fa fa-undo mr-2"></i> CANCEL
				</a>
			</div>



		</form:form>

	</div>
</div>