<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<div class="py-5">

<div class="container col-lg-7 col-md-8 col-sm-10 border border-light rounded" style=" box-shadow: 1px 1px 5px -1px #777;">
  <br/>
  <p class="h4 mb-4 text-center">CONTACT</p>
  <p class="text-center">${email}</p>

  
  <div class="row col-12 mt-30">
    <form class="col-sm-10 mx-auto" action="mailto:${email}" method="post" enctype="text/plain">
      
      <div class="row">
      
        <div class="col-sm-6 form-group">
          <input class="form-control" id="name" name="name" placeholder="Name" type="text" required>
        </div>
      
        <div class="col-sm-6 form-group">
          <input class="form-control" id="email" name="email" placeholder="Email" type="email" required>
        </div>
        
      </div>
      
      <textarea class="form-control" id="comments" name="comments" placeholder="Comment" rows="5"></textarea><br>
      
      <div class="row">
        <div class="col-sm-12 form-group text-center">
          <button class="btn" type="submit" style="background-color: #ee3733;">Send</button>
          <a class="btn" href="javascript:history.back()"   style="background-color: #ee3733;" >Cancel</a>
        </div>
      </div> 
    
    </form>
    
    
  </div>
</div>

</div>
