<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--Carousel Wrapper-->
<div id="carousel-example-1z" class="carousel slide carousel-fade"
   data-ride="carousel">

   <!--Indicators-->
   <ol class="carousel-indicators">
      <li data-target="#carousel-example-1z" data-slide-to="0"
         class="active"></li>
      <li data-target="#carousel-example-1z" data-slide-to="1"></li>
      <li data-target="#carousel-example-1z" data-slide-to="2"></li>
   </ol>
   <!--/.Indicators-->

   <!--Slides-->
   <div class="carousel-inner" role="listbox">
      <!--First slide-->
      <div class="carousel-item active">
         <img class="d-block w-100" src="resources/images/header1.jpg"
            alt="First slide">
         <!--Caption-->
            <div class="carousel-caption mb-4">
                <div class="animated fadeInLeft">
                    <h1 class="h1-responsive">LỄ TỐT NGHIỆP</h1>
                    <p class="caption-eng">GRADUATION</p>
                </div>
            </div>
            <!--Caption-->

      </div>
      <!--/First slide-->

      <!--Second slide-->
      <div class="carousel-item">
         <img class="d-block w-100" src="resources/images/header2.jpg"
            alt="Second slide">
         <!--Caption-->
            <div class="carousel-caption">
                <div class="animated fadeInLeft">
                    <h1 class="h1-responsive">PHỐI CẢNH TỔNG THỂ</h1>
                    <p class="caption-eng">TOTAL LIFE</p>
                </div>
            </div>
            <!--Caption-->

      </div>
      <!--/Second slide-->

      <!--Third slide-->
      <div class="carousel-item">
         <img class="d-block w-100" src="resources/images/header3.jpg"
            alt="Third slide">

         <!--Caption-->
            <div class="carousel-caption">
                <div class="animated fadeInLeft">
                    <h1 class="h1-responsive">TRƯỜNG TRẺ, NĂNG ĐỘNG</h1>
                    <p class="caption-eng">DREAMS, DYNAMIC</p>
                </div>
            </div>
            <!--Caption-->

      </div>
      <!--/Third slide-->

   </div>
   <!--/.Slides-->

   <!--Controls-->
   <a class="carousel-control-prev" href="#carousel-example-1z"
      role="button" data-slide="prev"> <span
      class="carousel-control-prev-icon" aria-hidden="true"></span> <span
      class="sr-only">Previous</span>
   </a> <a class="carousel-control-next" href="#carousel-example-1z"
      role="button" data-slide="next"> <span
      class="carousel-control-next-icon" aria-hidden="true"></span> <span
      class="sr-only">Next</span>
   </a>
   <!--/.Controls-->

</div>
<!--/.Carousel Wrapper-->





<div class="container my-5">
   <!-- Section: Magazine v.1 -->
   <section class="magazine-section">


      <!-- Grid row -->
      <div class="row">

         <!-- Grid column -->
         <div class="col-lg-6 col-md-12 pr-4">

            <!-- Featured news -->
            <div class="single-news mb-4">

               <!-- Excerpt -->
               <h3 class="font-weight-bold dark-grey-text mb-3">
                  <span>Board</span> <a href="${root}board/list" class="float-right"><i
                     class="fa fa-plus"></i></a>
                  <hr class="style10" style="width: 100%">
               </h3>
               <!--    
               <p class="dark-grey-text">Nam libero tempore, cum soluta nobis
                  est eligendi optio cumque nihil impedit quo minus id quod maxime
                  placeat facere possimus, omnis voluptas assumenda est, omnis dolor
                  repellendus.</p>
             -->
            </div>
            <!-- Featured news -->

            <jsp:include page="board/list_content.jsp"></jsp:include>

         </div>
         <!-- Grid column -->

         <!-- Grid column -->
         <div class="col-lg-6 col-md-12 pl-4">

            <!-- Featured news -->
            <div class="single-news mb-4">

               <!-- Excerpt -->
               <h3 class="font-weight-bold dark-grey-text mb-3">
                  <span>Alumni</span> <a href="${root}alumni/list"
                     class="float-right"><i class="fa fa-plus"></i></a>
                  <hr class="style10" style="width: 100%">
               </h3>
               <!--                
               <p class="dark-grey-text">Sed ut perspiciatis unde voluptatem
                  omnis iste natus error sit voluptatem accusantium doloremque
                  laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore
                  veritatis et quasi architecto beatae.</p>
                -->
            </div>
            <!-- Featured news -->

            <!-- Alumni Info !!!!!!!!!!!!!!!!!!!!!!!! -->
            <div class="single-news mb-4">



               <!-- Grid row -->
               <div class="row">

                  <c:forEach var="alumnus" items="${alumniList}">


                     <!-- Grid column -->
                     <div class="col-md-3">

                        <!--Image-->
                        <div class="view overlay rounded z-depth-1 mb-4">
                           <img
                              src="${root}student/avatar?studentNumber=${alumnus.studentNumber}"
                              class="img-fluid" alt="Sample avatar" style="width: 100%">

                        </div>

                     </div>
                     <!-- Grid column -->

                     <!-- Grid column -->
                     <div class="col-md-9">

                        <!-- Excerpt -->
                        <p class="font-weight-bold dark-grey-text">${alumnus.studentName}
                        </p>
                        <p class="font-weight-bold dark-grey-text">${alumnus.major}
                           / ${alumnus.studentNumber }</p>
                        <div class="d-flex justify-content-between">
                           <div class="col-11 text-truncate pl-0 mb-3">
                              <a href="alumni/list" class="dark-grey-text">${alumnus.introduction}</a>
                           </div>
                           <a href="alumni/list"><i class="fa fa-angle-double-right"></i></a>
                        </div>

                     </div>
                     <!-- Grid column -->


                  </c:forEach>

               </div>
               <!-- Grid row -->



            </div>
            <!-- Alumni Info!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->

         </div>
         <!-- Grid column -->

      </div>
      <!-- Grid row -->

   </section>
   <!-- Section: Magazine v.1 -->
</div>