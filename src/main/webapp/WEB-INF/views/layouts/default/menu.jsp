<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Navbar -->
<nav
   class="navbar fixed-top navbar-expand-lg navbar-light white scrolling-navbar">
   <div class="container">

      <!-- Brand -->
      <a class="navbar-brand" href="${root}"> <img
         src="${root}resources/images/logo.png" alt="BACHA" width="200px" />
      </a>

      <!-- Collapse -->
      <button class="navbar-toggler" type="button" data-toggle="collapse"
         data-target="#navbarSupportedContent"
         aria-controls="navbarSupportedContent" aria-expanded="false"
         aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
      </button>

      <!-- Links -->
      <div class="collapse navbar-collapse" id="navbarSupportedContent">

         <!-- Left -->
         <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" 
               href="${root}">HOME</a></li>
            <li class="nav-item"><a class="nav-link"
               href="${root}alumni/list">ALUMNI</a></li>
            <li class="nav-item"><a class="nav-link"
               href="${root}board/list">BOARD</a></li>
            <li class="nav-item">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
            <c:choose>
               <c:when test="${not empty USER}">
                  <c:if test="${USER.studentNumber=='admin'}">
                     <li class="nav-item"><a class="nav-link"
                        href="${root}admin/student/list">MANAGEMENT</a></li>
                  </c:if>
                  <li class="nav-item"><a class="nav-link"
                     href="${root}student/profile">PROFILE
                  </a></li>
                  <li class="nav-item"><a class="nav-link" href="${root}logout"><i class="fa fa-sign-in-alt"></i>LOGOUT</a></li>
               </c:when>
               <c:otherwise>
                  <li class="nav-item"><a class="nav-link" href="${root}login">LOGIN</a></li>
                  <li class="nav-item"><a class="nav-link" href="${root}join">JOIN</a></li>
               </c:otherwise>
            </c:choose>
         </ul>
      </div>

   </div>
</nav>
<!-- Navbar -->