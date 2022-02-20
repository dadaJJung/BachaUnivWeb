package com.worldfriends.bacha.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.worldfriends.bacha.model.Avatar;
import com.worldfriends.bacha.model.Login;
import com.worldfriends.bacha.model.Student;
import com.worldfriends.bacha.service.StudentService;
import com.worldfriends.bacha.exception.LoginFailException;

import com.worldfriends.bacha.controller.AccountController;

@Controller
public class AccountController {

	@Autowired
	StudentService service;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginForm(Login login, @ModelAttribute("url") String url) {
		login.setUrl(url);
		return "account/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginSubmit(@Valid Login login, BindingResult result, HttpSession session) throws Exception {
		// 유효성 검사 결과 실패
		if (result.hasErrors()) {
			return "account/login";
		}

		Student student = service.checkLogin(login); //예외 발생시 

		// System.out.println(member);
		session.setAttribute("USER", student); //여기서 예외 발생(로그인 실패)하면 handleLoginError()호출됨
		
		String url = login.getUrl();
		if(url!=null && !url.isEmpty()) return "redirect:/"+url;
		return "redirect:/";
	}
	


	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinForm(Student student) {
		return "account/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinSubmit(@Valid Student student, 
							 BindingResult result,
							 @RequestParam("avatar") MultipartFile mFile,
							 RedirectAttributes ra) throws Exception {
		// 유효성 검사 결과 실패
		if (result.hasErrors()) {
			return "account/join";
		}
		
		//아바타 저장
		if(mFile != null && !mFile.isEmpty()) {
			Avatar avatar = new Avatar(student.getStudentNumber(), mFile.getBytes());
			service.insertAvatar(avatar);
		}
		
		ra.addFlashAttribute("student", student); //redirect된 페이지에서 한 번 쓰이고 세션에서 제거
		service.create(student); //여기서 예외 발생(회원가입 실패)하면 handleError() 호출됨
		
		System.out.println(student);
		
		return "redirect:/login";
	}
	
	@RequestMapping(value="/join_success", method=RequestMethod.GET)
	public String joinSuccess() {
		return "account/join_success";
	}
	
	@ResponseBody	//리턴값은 뷰가 아님. response 객체의 body로 전송
	@RequestMapping(value="/idcheck", method=RequestMethod.GET)
	public boolean checkId(@RequestParam("studentNumber") String studentNumber) {
		try {
			return service.checkId(studentNumber); //id가 이미 존재하면 true 리턴
		}catch(Exception e) {
			e.printStackTrace();
			return true;
		}
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();	//session 완전히 삭제
		return "redirect:/login";
	}
	
	// 로그인 예외 발생시 호출됨
	@ExceptionHandler(LoginFailException.class)
	public String handleLoginError(HttpServletRequest request, Exception e) {
		request.setAttribute("login", new Login());	//모델 객체 전달해줘야 에러 안 남
		request.setAttribute("error", e.getMessage());
		return "account/login";
	}
	
//	//데이터베이스 예외 발생시 호출됨
//	@ExceptionHandler({SQLException.class, DataAccessException.class})
//	public String handleError() {
//		return "error/database_error"; //에러 화면 호출
//	}
	
	
}
