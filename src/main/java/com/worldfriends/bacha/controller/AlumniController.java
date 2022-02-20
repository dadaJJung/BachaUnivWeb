package com.worldfriends.bacha.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.worldfriends.bacha.dao.StudentDao;
import com.worldfriends.bacha.model.Board;
import com.worldfriends.bacha.model.Options;
import com.worldfriends.bacha.model.Pagination;
import com.worldfriends.bacha.model.SortOption;
import com.worldfriends.bacha.model.Student;
import com.worldfriends.bacha.service.StudentService;

@Controller
@RequestMapping("/alumni")
public class AlumniController {

   @Autowired
   StudentService service;
   @Autowired
   StudentDao dao;

   @RequestMapping(value = "/list", method = RequestMethod.GET)
   public void list(@RequestParam(value = "page", defaultValue = "1") int page,
         @RequestParam(value = "option", defaultValue = "graduation_year") String option,
         @RequestParam(value = "keyOption", defaultValue = "student_name") String keyOption,
         @RequestParam(value = "keyword", defaultValue = "") String keyword, Model model) throws Exception {
      
      Options options = new Options(keyOption, keyword);
      int totalSize = dao.getCountByOption(options);
      Pagination pagination = service.getPagination(page, totalSize);
      SortOption sortOption = new SortOption(pagination, option, keyOption, keyword);
      List<Student> list;
      
      if (option.equals("student_name") || option.equals("major")) { // 알파벳으로 정렬할 경우(이름, 전공)
         list = service.getListByAlphabetSort(sortOption);
      } else { // 숫자로 정렬할 경우(입학년도, 졸업년도, 학번)
         list = service.getListByNumSort(sortOption);
      }

      model.addAttribute("option", option);
      model.addAttribute("keyOption", keyOption);
      model.addAttribute("keyword", keyword);
      model.addAttribute("pagination", pagination);
      model.addAttribute("list", list);

   }

   @RequestMapping(value = "/contact_form", method = RequestMethod.GET)
   public void contactForm(@RequestParam("email") String email, Model model) throws Exception {
      model.addAttribute("email", email);
   }
}