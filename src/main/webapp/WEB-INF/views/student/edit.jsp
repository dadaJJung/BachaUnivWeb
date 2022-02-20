<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script>
    
    function showname () {
	    var name = document.getElementById('ex_file');
	    var list = [name.files.item(0).name];
	    return list;
	  };
	  
	$(document).ready(function(){
		
		  $('#ex_file').change(function () {
		    var list = showname();
		   $('#fileList').html(list[0]+"<br/>");
		
		    	    
		  });
		  
		     $('.filebox label[for="ex_file"]').mouseover(function(){
		    	 $('.filebox label[for="ex_file"]').removeClass('font-color');
		    	 $('.filebox label[for="ex_file"]').addClass('upload');
		     });
		         
		     $('.filebox label[for="ex_file"]').mouseout(function(){
		    	 $('.filebox label[for="ex_file"]').addClass('font-color');
		    	 $('.filebox label[for="ex_file"]').removeClass('upload');
		     });
		  
		});	
 
</script>


<div id="edit-form"
	class="edit-form col-8 mx-auto"
	style="padding: 40px !important;">
	<h4
		style="margin-bottom: 50px !important; padding-bottom: 20px !important; border-bottom: 1px dotted #8c8b8b;">Edit
		Profile</h4>
	<form:form commandName="student" enctype="multipart/form-data">

		<div class="row">

			<div class="col-lg-3 col-md-4 col-sm-12">
			
			  <img src="avatar?studentNumber=${student.studentNumber}" class="mb-10">
			  <div class="filebox text-center" style="width:150px">	
				<label for="ex_file" class="font-color">IMAGE UPLOAD</label> 
				<input type="file" id="ex_file" name="avatar">
				<p id="fileList" style="text-overflow: ellipsis;   overflow: hidden; 
				"></p>
			 </div> 
			 
			</div>




			<div class="col-lg-9 col-md-8 col-sm-12" id="info">

				<div class="mb-2">
					<label for="studentName"><span class="label">NAME :</span> ${student.studentName }</label>
					<form:hidden path="studentName" class="form-control" />
				</div>

				<div class="mb-2">
					<label for="studentNumber"><span class="label">STUDENT NUMBER :</span>
						${student.studentNumber}</label>
					<form:hidden path="studentNumber" />
				</div>


				<div class="mb-2">
					<label for="major"><span class="label">MAJOR :</span> ${student.major}</label>
					<form:hidden path="major" class="form-control" />
				</div>

				<div class="mb-2">
				
					<label for="admissionYear"><span class="label">ADMISSION YEAR : </span>
					 <c:out value="${fn:substring(student.admissionYear,0,10)}"/>
					</label>
					<form:hidden path="admissionYear" class="form-control" />
				</div>

				<div>
					<label for=graduationYear><span class="label">GRADUATION YEAR :</span>
					<c:out value="${fn:substring(student.graduationYear,0,10)}"/>
					</label>
					<form:hidden path="graduationYear" class="form-control" />
				</div>

				<div class="md-form">
					<label for="cellPhone">PHONE NUMBER</label>
					<form:input path="cellPhone" class="form-control" />
					<form:errors path="cellPhone" />
				</div>

				<div class="md-form">
					<label for="email">EMAIL</label>
					<form:input path="email" class="form-control" />
					<form:errors path="email" />
				</div>

				<div class="md-form">
					<label for="address">ADDRESS</label>
					<form:input path="address" class="form-control" />
					<form:errors path="address" />
				</div>

				<div class="md-form">
					<label for="introduction">INTRODUCTION</label>
					<form:input path="introduction" class="form-control" />
				</div>


				<div class="md-form">
					<label for="password">PASSWORD</label>
					<form:password path="password" class="form-control" />
					<form:errors path="password" cssClass="error" />
				</div>

				<form:errors cssClass="error" element="div" />

			</div>
		</div>

		<div class="md-form text-center">
			<button type="submit" class="btn" style="background-color: #ee3733;">
				<i class="fa fa-check"></i>&nbsp;submit
			</button>
		   <a href="../student/profile" class="btn red-button">
		  <i class="fa fa-undo"></i>&nbsp;CANCEL </a>
		</div>
	</form:form>
</div>