<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>




<!-- Section: Team v.1 -->
<section class="team-section text-center my-5">


  <!-- Grid row -->
  <div class="row">

	<c:forEach var="alumnus" items="${list}" >

    <!-- Grid column -->
    <div class="col-lg-4 col-md-6 mb-10" style="margin-bottom:100px!important">
      <div class="avatar mx-auto">
        <img src="${root}student/avatar?studentNumber=${alumnus.studentNumber}" class="rounded-circle z-depth-1" alt="Sample avatar" style="width:100%">
      </div>
      <h5 class="font-weight-bold mt-4 mb-3">${alumnus.studentName}</h5>
      <p class=" blue-text"><strong>${alumnus.major} / ${alumnus.studentNumber}</strong></p>
      <p class="grey-text">  
         <c:out value="${fn:substring(alumnus.admissionYear,0,10)}"/> ~		       
		 <c:out value="${fn:substring(alumnus.graduationYear,0,10)}"/>
	  </p>
	  <p class="" style="min-height:50px">${alumnus.introduction}</p>
		 
     <div class="contact_icon ">

						<!--email -->
						<a class="p-2 fa-sm"
							href="contact_form?email=${alumnus.email}"> 
                        <i class="fa fa-envelope"></i>
						</a>

						<!-- Facebook-->
						<a class="p-2 fa-lg" href="" >
						 <i class="fa fa-facebook "> </i>
						</a>
						<!-- Twitter -->
						<a class="p-2 fa-lg" href="" > 
						 <i class="fa fa-twitter">
						</i>
						</a>
						<!--instagram -->
						<a class="p-2 fa-lg" href="" >
						 <i class="fa fa-instagram"></i>
						</a>
					</div>
    </div>
    <!-- Grid column -->
    
    </c:forEach>
    

  </div>
  <!-- Grid row -->

</section>
<!-- Section: Team v.1 -->