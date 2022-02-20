<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<script>
	$(function() {

		//form:errors 메세지 제어
		$('#studentNumber').keyup(function(e) {
			$('.studentNumber').html('');
		});
		$('#password').keyup(function(e) {
			$('.password').html('');
		});
	});
</script>




<div class="py-5">
<form:form commandName="login"
	class="text-center border border-light p-5 mx-auto col-lg-5 col-md-7 col-sm-8 rounded" 
	style=" box-shadow: 1px 1px 5px -1px #777;">

	<div class="login-form">
		<c:if test="${not empty login.url }">
			<!-- URL이 있으면 다른 페이지에서 강제 이동된 것 -->
			<div class="alert alert-primary mt-4 mb-4" role="alert">
				Login is required
			</div>
		</c:if>
	</div>

	<p class="h4 mb-4">Sign in</p>

	<c:if test="${not empty error}">
		<div class="alert alert-light error" role="alert">${error}</div>
	</c:if>

	<!-- id -->
	<div class="mb-4">
		<form:input path="studentNumber" class="form-control"
			placeholder="Student Number" />
		<!-- name과 id가 userId로 정해짐 -->
		<form:errors path="studentNumber" element="div"
			cssClass="error studentNumber" />
		<!-- BindingResult 결과메시지 출력 -->
	</div>

	<!-- Password -->
	<div class="mb-4">
		<form:password path="password" class="form-control"
			placeholder="Password" />
		<form:errors path="password" element="div" cssClass="error password" />
	</div>

	<div class="d-flex justify-content-around">
		<div>
			<!-- Remember me -->
			<div class="custom-control custom-checkbox">
				<input type="checkbox" class="custom-control-input"
					id="defaultLoginFormRemember"> <label
					class="custom-control-label" for="defaultLoginFormRemember">Remember
					me</label>
			</div>
		</div>
		<div>
			<!-- Forgot password -->
			<a href="">Forgot password?</a>
		</div>
	</div>

	<!-- Sign in button -->
	<button class="btn btn-block my-4" style="background-color: #ee3733;" type="submit">Sign
		in</button>

	<!-- Register -->
	<p>
		Not a member? <a href="/bacha/join">Register</a>
	</p>



</form:form>
</div>
<!-- Default form login -->