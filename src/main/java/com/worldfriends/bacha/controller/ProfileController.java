package com.worldfriends.bacha.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.worldfriends.bacha.model.Avatar;
import com.worldfriends.bacha.model.Password;
import com.worldfriends.bacha.model.Student;
import com.worldfriends.bacha.service.StudentService;

@Controller
@RequestMapping("/student")
public class ProfileController {

	@Autowired
	StudentService service; // AccountController의 service와 같은 객체(빈은 싱글톤이므로)

	public void setStudent(HttpSession session, Model model) throws Exception {
		Student s = (Student) session.getAttribute("USER");
		Student student = service.getStudent(s.getStudentNumber()); // 등록일, 수정일 정보 얻기 위해 다시 검색
		model.addAttribute("student", student);
	}

	// 회원정보 뷰로 이동
	@RequestMapping("/profile")
	public void profile(HttpSession session, Model model) throws Exception {
		setStudent(session, model);
		// return 생략시 url로 이동
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public void editForm(HttpSession session, Model model) throws Exception {
		setStudent(session, model);
		// return 생략시 url로 이동
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public String editSubmit(HttpSession session, @Valid Student student, BindingResult result,
			@RequestParam("avatar") MultipartFile mFile) throws Exception {

		// 유효성 검사 실패시 정보 수정 페이지로 돌아감
		if (result.hasErrors())
			return "student/edit";

		// 수정 실패시 정보 수정 페이지로 돌아감
		if (!service.update(student)) {
			result.reject("updateFail", "비밀번호가 일치하지 않습니다.");
			return "student/edit";
		}

		// 아바타 저장
		if (mFile != null && !mFile.isEmpty()) {
			Avatar avatar = new Avatar(student.getStudentNumber(), mFile.getBytes());
			service.updateAvatar(avatar);
		}

		session.setAttribute("USER", student); // 수정된 정보로 덮어씀

		return "redirect:/student/profile";
	}

	// 아바타 이미지 내보내기
	@RequestMapping(value = "/avatar", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getAvatar( // ResponseEntity: HttpResponse를 추상화해주는 객체
			@RequestParam("studentNumber") String studentNumber) throws Exception {
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG); // mime type 지정
		// body, header, 응답코드
		return new ResponseEntity<byte[]>(service.getAvatar(studentNumber), headers, HttpStatus.OK);
	}

//	// 데이터베이스 예외 발생시 호출됨
//	@ExceptionHandler({ SQLException.class, DataAccessException.class })
//	public String handleError() {
//		return "error/database_error"; // 에러 화면 호출
//	}

	// 비밀번호 바꾸는 폼
	@RequestMapping(value = "/changepassword", method = RequestMethod.GET)
	public void changepasswordForm(Password password) throws Exception {

		// return 생략시 url로 이동, member/changepassword.jsp
	}

	// 실제 비밀번호 변경
	@RequestMapping(value = "/changepassword", method = RequestMethod.POST)
	public String changepassword(HttpSession session, @Valid Password password, BindingResult result) throws Exception {

		// 유효성 검사 실패시 정보 수정 페이지로 돌아감
		if (result.hasErrors())
			return "student/changepassword";
		
		
		// 수정 실패시 정보 수정 페이지로 돌아감
		if (!service.changepassword(password)) {
			result.reject("updateFail", "기존 비밀번호가 일치하지 않습니다.");
			return "student/changepassword";
		}
		
		Student student = service.getStudent(password.getStudentNumber());
		session.setAttribute("USER",student);  //session 멤버를 비밀번호 바뀐 멤버로
		
		return "redirect:/student/profile";

		
		// return 생략시 url로 이동, member/changepassword.jsp
	}
	
	

}
