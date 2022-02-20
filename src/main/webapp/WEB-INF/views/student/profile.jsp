<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:url value="/" var="root" />

<div class="py-5 container">

	<div class="row col-11 mx-auto justify-content-center">
        
        <h4 class="col-lg-11 col-md-12 col-sm-12 mx-auto" style="margin-bottom:50px!important; padding-bottom:20px!important; border-bottom: 1px dotted #8c8b8b;" >Student Info</h4>
        

		<div class="col-lg-3 col-md-4 col-sm-12">
			<div class="p-10" style="padding-bottom: 30px!important">
				<img src="avatar?studentNumber=${student.studentNumber}">
			</div>
		</div>


		<div class="col-lg-8 col-md-8 col-sm-12" >
			<div class="row">
				<div class="col-md-4 col-sm-12 label">Student Number</div>
				<div class="col-md-8 col-sm-12">${student.studentNumber}</div>
			</div>
			<hr />

			<div class="row">
				<div class="col-md-4 col-sm-12 label">Name</div>
				<div class="col-md-8 col-sm-12">${student.studentName}</div>
			</div>
			<hr />


			<div class="row">
				<div class="col-md-4 col-sm-12 label">Phone Number</div>
				<div class="col-md-8 col-sm-12">${student.cellPhone}</div>
			</div>
			<hr />

			<div class="row">
				<div class="col-md-4 col-sm-12 label">Email</div>
				<div class="col-md-8 col-sm-12">${student.email}</div>
			</div>
			<hr />

			<div class="row">
				<div class="col-md-4 col-sm-12 label">Address</div>
				<div class="col-md-8 col-sm-12">${student.address}</div>
			</div>
			<hr />

			<div class="row">
				<div class="col-md-4 col-sm-12 label">Major</div>
				<div class="col-md-8 col-sm-12">${student.major}</div>
			</div>
			<hr />

			<div class="row">
			

			
				<div class="col-md-4 col-sm-12 label">Admission Year</div>
				<div class="col-md-8 col-sm-12 sm-mb-100">
				   		<c:out value="${fn:substring(student.admissionYear,0,10)}"/>
				</div>
			</div>

			<div class="row">
				<div class="col-md-4 col-sm-12 label">Graduation Year</div>
				<div class="col-md-8 col-sm-12">				   		
				       <c:out value="${fn:substring(student.graduationYear,0,10)}"/>
                </div>
			</div>
			<hr />

			<div class="row">
				<div class="col-md-4 col-sm-12 label">Introduction</div>
				<div class="col-md-8 col-sm-12">${student.introduction}</div>
			</div>
			<hr />

			<div class="row">
				<div class="col-md-4 col-sm-12 label">Register Date</div>
				<div class="col-md-8 col-sm-12">
					<fmt:formatDate value="${student.regDate}" pattern="yyyy-MM-dd" />
				</div>
			</div>

			<div class="row">
				<div class="col-md-4 col-sm-12 label">Update Date</div>
				<div class="col-md-8 col-sm-12">
					<fmt:formatDate value="${student.updateDate}" pattern="yyyy-MM-dd" />
				</div>
			</div>
          

		</div>
		
		
	</div>		
            
			<div class="row col-sm-12 form-group justify-content-center" style="padding-top:50px!important">			
			   <a href="${root}student/changepassword" class="btn" style="background-color: #ee3733;"><i class="fa fa-lock"></i>&nbsp;Change password</a>
			   <a href="${root}student/edit" class="btn" style="background-color: #ee3733;"><i class="fa fa-edit"></i>&nbspEdit Info</a>
           </div>

</div>