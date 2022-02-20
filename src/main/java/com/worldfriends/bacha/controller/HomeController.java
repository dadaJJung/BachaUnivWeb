package com.worldfriends.bacha.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.worldfriends.bacha.dao.BoardDao;
import com.worldfriends.bacha.dao.StudentDao;
import com.worldfriends.bacha.model.Board;
import com.worldfriends.bacha.model.Options;
import com.worldfriends.bacha.model.Pagination;
import com.worldfriends.bacha.model.SortOption;
import com.worldfriends.bacha.model.Student;
import com.worldfriends.bacha.service.BoardService;
import com.worldfriends.bacha.service.StudentService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

   @Autowired
   BoardService service;
   @Autowired
   StudentService studentService;
   @Autowired
   BoardDao dao;
   @Autowired
   StudentDao studentDao;

   @RequestMapping(value = "/", method = RequestMethod.GET)
   public String home(@RequestParam(value = "page", defaultValue = "1") int page,
         @RequestParam(value = "option", defaultValue = "reg_date") String option,
         @RequestParam(value = "keyOption", defaultValue = "title") String keyOption,
         @RequestParam(value = "keyword", defaultValue = "") String keyword, Model model) throws Exception {

      // 공지사항 리스트 추출
      List<Board> listNotice = service.getListNotice();

      // 목록 및 페이지 정보 추출
      Options options = new Options(keyOption, keyword);
      int totalSize = dao.getCountByOption(options);
      Pagination pagination = service.getPaginationHome(1, listNotice.size(), totalSize);
      SortOption sortOption = new SortOption(pagination, option, keyOption, keyword);
      List<Board> list = service.getList(sortOption);
      

      //alumniList
      Options alOptions = new Options("student_name", "");
      int alTotalSize = studentDao.getCountByOption(alOptions);
      Pagination alPagination = studentService.getPaginationHome(1, alTotalSize);
      SortOption alSortOption = new SortOption(alPagination,"graduation_year", "student_name", "");
      List<Student> alumniList = studentService.getListByNumSort(alSortOption);

    		  

      // view에 넘길 정보 구성
      model.addAttribute("alumniList", alumniList);
      model.addAttribute("option", option);
      model.addAttribute("keyOption", keyOption);
      model.addAttribute("keyword", keyword);
      model.addAttribute("pagination", pagination);
      model.addAttribute("list", list);
      model.addAttribute("listNotice", listNotice);

      return "home";
   }
}