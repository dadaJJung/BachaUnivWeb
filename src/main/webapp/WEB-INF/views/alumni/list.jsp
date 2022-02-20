<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script>
   $(document)
         .ready(
               function() {

                  var id = document
                        .getElementById("<c:out value="${option}"/>");
                  id.classList.remove('before_selected');

                  $('#search-btn')
                        .click(
                              function() {
                                 var keyOption = $('.form-control')
                                       .eq(0).val();
                                 if (keyOption == 'ID')
                                    keyOption = 'student_number';
                                 else if (keyOption == 'Name')
                                    keyOption = 'student_name';
                                 else if (keyOption == 'Major')
                                    keyOption = 'major';

                                 var keyword = $('.form-control')
                                       .eq(1).val();
                                 window.location.href = "${root}alumni/list?keyOption="
                                       + keyOption
                                       + "&keyword="
                                       + keyword;
                              });
               });
</script>

<div class="py-5">
   <!-- Section: Team v.3 -->
   <section class="container">
      <h4
         style="margin-bottom: 50px !important; padding-bottom: 20px !important; border-bottom: 1px dotted #8c8b8b;">Our
         Alumni</h4>

      <div class="border rounded col-10 mx-auto justify-content-center row">
         <div class="text-center row justify-content-md-center col-12 mx-auto"
            style="margin: 20px 0px !important" id="sort_option">
            <a href="../alumni/list"
               class="right col-lg-3 col-md-12 before_selected"
               id="graduation_year"><i
               class="fa fa-angle-right mr-2 align-baseline"></i>GRADUATION YEAR</a> <a
               href="../alumni/list?option=student_number"
               class="right col-lg-3 col-md-12 mb-10 before_selected"
               id="student_number"><i
               class="fa fa-angle-right mr-2 align-baseline"></i>STUDENT ID</a> <a
               href="../alumni/list?option=student_name"
               class="col-lg-3 col-md-12 before_selected" id="student_name"><i
               class="fa fa-angle-right mr-2 align-baseline"></i>NAME</a> <a
               href="../alumni/list?option=major"
               class="right col-lg-3 col-md-12 before_selected" id="major"><i
               class="fa fa-angle-right mr-2 align-baseline"></i>MAJOR</a>
         </div>
      </div>

      <div class="col-10 mx-auto border-bottom my-4"></div>

      <jsp:include page="list_content.jsp"></jsp:include>

   </section>
   <!-- Section: Team v.3 -->

   <!-- page block -->
   <%@ taglib tagdir="/WEB-INF/tags/util" prefix="iot"%>
   <iot:pagination pagination="${pagination}" link="list"></iot:pagination>
   <!-- search -->
   <div id="search" class="row justify-content-center mr-0 mt-3">
      <select id="search-tag" class="form-control">
         <option>ID</option>
         <option>Name</option>
         <option>Major</option>
      </select>
      <div id="search-content" class="active-cyan-4 ml-1">
         <input class="form-control radius-style" type="text"
            placeholder="Search" aria-label="Search">
      </div>
      <button id="search-btn" type="button" class="btn btn-primary">
         <i class="fa fa-search"></i>
      </button>
   </div>
</div>
