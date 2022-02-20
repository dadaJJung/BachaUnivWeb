<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script>

function showname () {
    var name = document.getElementById('ex_file');
    var list = [name.files.item(0).name];
    return list;
  };

	$(function() { //페이지가 로드되면 실행
		
		  $('#ex_file').change(function () {
			    var list = showname();
			   $('#fileList').html("<span>"+list[0]+"</span><br/>");
			
			    	    
			  });
			  
			     $('.filebox label[for="ex_file"]').mouseover(function(){
			    	 $('.filebox label[for="ex_file"]').removeClass('font-color');
			    	 $('.filebox label[for="ex_file"]').addClass('upload');
			     });
			         
			     $('.filebox label[for="ex_file"]').mouseout(function(){
			    	 $('.filebox label[for="ex_file"]').addClass('font-color');
			    	 $('.filebox label[for="ex_file"]').removeClass('upload');
			     });
		
		var check_id = false; //id 중복확인
		var check_pw = false; //비밀번호 일치여부 확인

		//제출 버튼 클릭시 id 중복과 비밀번호 일치 여부에 따라 동작
		$('#join-form').submit(function(e) {
			if (!check_id) {
				$('#studentNumber').focus();
				e.preventDefault(); //이벤트의 기본 동작 금지
			} else if (!check_pw) {
				$('#password').focus();
				e.preventDefault(); //이벤트의 기본 동작 금지
			}
		});

		//비밀번호 입력시 비밀번호 일치여부 확인
		$('#password').keyup(function(e) {
			checkPW();
		});
		$('#password2').keyup(function(e) {
			checkPW();
		});

		function checkPW() {
			// 비밀번호 일치 검사
			var password1 = $(':password').eq(0).val(); //':' jquery input selector
			var password2 = $(':password').eq(1).val();

			if (password1 == '' || password2 == '') {
				check_pw = false;
			}

			if (password1 != password2) {
				$('#check-pw-message').addClass('error').html(
						'The password dose not match');
				check_pw = false;
			} else {
				$('#check-pw-message').removeClass('error').html('');
				check_pw = true;
			}
		}

		//id 포커스 해제시 id 중복 여부 확인
		$('#studentNumber').focusout(
				function(e) {
					// 중복체크
					var studentNumber = $('#studentNumber').val();

					if (studentNumber == '') {
						check_id = false;
					}

					$.get('idcheck', {
						studentNumber : studentNumber
					}, function(data) {
						//console.log(data)
						if (!data) { // 사용자 ID 중복 아님
							$('#check-id-message').removeClass('error')
									.html('');
							check_id = true;

						} else { // 사용자 ID 중복
							$('#check-id-message').addClass('error').html(
									'This ID is already in use');
							check_id = false;
						}
					});
				});

		//form:errors 메세지 제어
		$('#studentName').keyup(function(e) {
			$('.studentName').html('');
		});
		$('#studentNumber').keyup(function(e) {
			$('.studentNumber').html('');
		});
		$('#email').keyup(function(e) {
			$('.email').html('');
		});
		$('#cellPhone').keyup(function(e) {
			$('.cellPhone').html('');
		});
		$('#admissionYear').keyup(function(e) {
			$('.admissionYear').html('');
		});
		$('#graduationYear').keyup(function(e) {
			$('.graduationYear').html('');
		});
		$('#major').keyup(function(e) {
			$('.major').html('');
		});
		$('#address').keyup(function(e) {
			$('.address').html('');
		});

		$('#introduction').keyup(function(e) {
			$('.introduction').html('');
		});
		
		
		$('#introduction').keyup(function(e) {
			var length = $('#introduction').val().length;
			if(length>70){
			   $('#check-introduction-length').addClass('error').html('maximum is 70 characters');
			}else{
				$('#check-introduction-length').removeClass('error').html('');
			}
		});

	});
</script>

<div class="py-5">
<form:form commandName="student" id="join-form"
		enctype="multipart/form-data" class="text-center border border-light p-5 mx-auto col-lg-5 col-md-8 col-sm-9 rounded " 
		style="  box-shadow: 1px 1px 5px -1px #777;">

    <p class="h4 mb-4">Sign up</p>

	<c:if test="${not empty error}">
	<div class="alert alert-light error" role="alert">${error}</div>
	</c:if>


    <div class="form-row mb-4">
        <div class="col-sm-6">
            <form:input path="studentNumber" class="form-control" placeholder="Student Number"/>
            <form:errors path="studentNumber" element="div" cssClass="error studentNumber" />
            <span id="check-id-message"></span>
        </div>
        <div class="col-sm-6">
	        <form:input path="studentName" class="form-control" placeholder="Name"/>
			<form:errors path="studentName" element="div"
				cssClass="error studentName" />            
        </div>
    </div>



    <!-- Password -->
    <div class="mb-4">
    <form:password path="password"  class="form-control" placeholder="Password" />
	<form:errors path="password" element="div" cssClass="error" />
	</div>
	
	<div class="mb-4">
	<input type="password" name="password2" id="password2" required  class="form-control" placeholder="Password" /> 
	<span id="check-pw-message"></span>	
    </div>

    <!-- Email -->
    <div class="mb-4">
    <form:input path="email"  class="form-control" placeholder="Email"/>
	<form:errors path="email" element="div" cssClass="error email" />
    </div>

    <!-- Phone Number -->
    <div class="mb-4">
    <form:input path="cellPhone" class="form-control" placeholder="Phone number" />
	<form:errors path="cellPhone" element="div" cssClass="error cellPhone" />
	</div>


    <!-- Address -->
    <div class="mb-4">
    <form:input path="address" class="form-control" placeholder="Address"/>
	<form:errors path="address" element="div" cssClass="error address" />
	</div>

    <!-- Major -->
    <div class="mb-4">
    <form:input path="major" class="form-control" placeholder="Major"/>
	<form:errors path="major" element="div" cssClass="error major" />
	</div>


   <!-- YEAR -->
   <div class="form-row mb-4">
        <div class="col-sm-6">
            <!-- admission -->  
            <form:input type="date" path="admissionYear" required="true"  class="form-control" placeholder="Admission Year"/>
			<form:errors path="admissionYear" element="div" cssClass="error" />          
        </div>
        <div class="col-sm-6">
            <!-- graduation -->
            <form:input type="date" path="graduationYear" required="true" class="form-control" placeholder="Graduation Year"/>
			<form:errors path="graduationYear" element="div" cssClass="error" />
        </div>
    </div>

    <!-- Introduction -->
    <div class="mb-4">
	<form:input path="introduction" class="form-control" placeholder="Introduction"/>
	<form:errors path="introduction" element="div" cssClass="error introduction" />
	<span id="check-introduction-length"></span>
	</div>




     <div class="filebox text-left">	
		<label for="ex_file" class="font-color">IMAGE UPLOAD</label> 
        <input type="file" id="ex_file" name="avatar" accept="image/*" id="defaultRegisterPhonePassword" class="form-control mb-4" placeholder="Profile Image" aria-describedby="defaultRegisterFormPhoneHelpBlock"/>
	    <span id="fileList" style="padding-left:10px"></span>
	</div> 


    <!-- Sign up button -->
    <button class="btn my-4 btn-block" type="submit" style="background-color: #ee3733;">Sign in</button>



   
</form:form>
</div>

<!-- Default form register -->
	


