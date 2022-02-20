package com.worldfriends.bacha.interceptor;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.worldfriends.bacha.model.Board;
import com.worldfriends.bacha.model.Login;
import com.worldfriends.bacha.model.Student;
import com.worldfriends.bacha.service.BoardService;

@Component
public class BoardInterceptor extends HandlerInterceptorAdapter {
	
   @Autowired
   ServletContext context; 
   
   @Autowired
   BoardService service;

   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
     

	   Map pathVariables  = (Map)request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
	   String value= (String) pathVariables.get("boardId");
	   int boardId = Integer.parseInt(value);
	   Board board = service.getBoard(boardId);
	   

	   HttpSession session = request.getSession();
	   Student user = (Student) session.getAttribute("USER");
	   
	   	   
	   if (user==null || !user.getStudentNumber().equals(board.getWriter())){ 
	         response.sendRedirect(context.getContextPath() + "/board/list"); 
	   }
	   
	        return super.preHandle(request, response, handler);
	   
	  
      }
     


}