<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<!-- jQuery -->
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Material Design Bootstrap -->
<link
   href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.5.0/css/mdb.min.css"
   rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!--  bootstrap stylesheet -->
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<c:set value="${pageContext.request.contextPath}/" var="root"
   scope="request" />
<script src="<c:url value="/resources/js/common.js"/>"></script>
<link rel="stylesheet" href="${root}/resources/css/main.css" />


<script>
   var offset = 200;
   var duration = 500;
   $(window).scroll(function() {
      if ($(this).scrollTop() > offset) {
         $('.back-to-top').fadeIn(400);
      } else {
         $('.back-to-top').fadeOut(400);
      }
   });
   $('.back-to-top').click(function(event) {
      event.preventDefault();
      $('html, body').animate({
         scrollTop : 0
      }, 600);
      return false;
   });
</script>
</head>

<body>
   <tiles:insertAttribute name="menu" />
   <div id="body">
      <tiles:insertAttribute name="body" />
   </div>
   <footer> <tiles:insertAttribute name="footer" /> </footer>
   <!-- Go To Top Link -->
   <a href="#" class="back-to-top"> 
      <i class="fa fa-angle-up"></i>
   </a>
</body>
<!-- material design bootstrap -->
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.4.5/js/mdb.min.js"></script>
</html>