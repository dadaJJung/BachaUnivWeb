package com.worldfriends.bacha.controller;

import java.net.URL;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.worldfriends.bacha.dao.BoardDao;
import com.worldfriends.bacha.model.Attachment;
import com.worldfriends.bacha.model.Board;
import com.worldfriends.bacha.model.Options;
import com.worldfriends.bacha.model.Pagination;
import com.worldfriends.bacha.model.SortOption;
import com.worldfriends.bacha.model.Student;
import com.worldfriends.bacha.service.BoardService;
import com.worldfriends.bacha.util.S3Util;

@Controller
@RequestMapping("/board")
public class BoardController {
   @Autowired
   BoardService service;
   @Autowired
   BoardDao dao;
	
   S3Util s3 = new S3Util();
   String bucketName = "upload-attachment";

   
   @RequestMapping(value = "/list", method = RequestMethod.GET)
   public void list(@RequestParam(value = "page", defaultValue = "1") int page, 
                @RequestParam(value = "option", defaultValue = "reg_date") String option, 
                @RequestParam(value = "keyOption", defaultValue = "title") String keyOption,
                @RequestParam(value = "keyword", defaultValue = "") String keyword,
                Model model) throws Exception {
      // ???????????? ????????? ??????
      List<Board> listNotice = service.getListNotice();

      // ?????? ??? ????????? ?????? ??????
      Options options = new Options(keyOption, keyword);
      int totalSize = dao.getCountByOption(options);
      Pagination pagination = service.getPagination(page, listNotice.size(), totalSize);
      SortOption sortOption = new SortOption(pagination, option, keyOption, keyword);
      List<Board> list = service.getList(sortOption);
      
      // view??? ?????? ?????? ??????
      model.addAttribute("option", option);
      model.addAttribute("keyOption", keyOption);
      model.addAttribute("keyword", keyword);
      model.addAttribute("pagination", pagination);
      model.addAttribute("list", list);
      model.addAttribute("listNotice", listNotice);
      // board/list ?????? ??????
   }

   @RequestMapping(value = "/create", method = RequestMethod.GET)
   public void createForm(Board board) {

   }

   
   
   
   
   
   
   
   @RequestMapping(value = "/create", method = RequestMethod.POST)
   public String createSubmit(@Valid Board board,
                        BindingResult result,
                        MultipartHttpServletRequest request) throws Exception {
      // ????????? ?????? ?????? ??????
      if (result.hasErrors())
         return "board/create";
      
      List<MultipartFile> attachments = request.getFiles("files");

      
      if(!service.create(board, attachments)) return "board/create";
      return "redirect:list";
   }
   
   
   
   
   
   
   
   
   @RequestMapping(value = "/view/{boardId}", method = RequestMethod.GET)
   public String view(@PathVariable int boardId, Model model) throws Exception {
      service.increaseReadCnt(boardId); //????????? ??????
      Board board = service.getBoard(boardId);
      model.addAttribute(board);
      return "board/view";
   }
   
   @RequestMapping(value="/download/{attachmentId}", method=RequestMethod.GET)
   public String download(@PathVariable int attachmentId, Model model) throws Exception{
      Attachment file = service.getAttachment(attachmentId);
      
	  //URL url = new URL(s3.getFileURL(bucketName, "upload"+file.getLocation()));
      String path = "upload"+file.getLocation();
      System.out.println("here  "+path);
      model.addAttribute("type", "application/octet-stream");
      model.addAttribute("path", path);
      model.addAttribute("fileName", file.getFileName());
      
      //file.readyDownload("c:/temp/upload/", model);
      
      return "download";    //????????? ?????? ??? ??????. beanNameResolver??? ?????????
   }

   @RequestMapping(value = "/edit/{boardId}", method = RequestMethod.GET)
   public String edit(@PathVariable int boardId, Model model) throws Exception {
      Board board = service.getBoard(boardId);
      model.addAttribute(board);
      return "board/edit";
   }
   
   @RequestMapping(value = "/edit/{boardId}", method = RequestMethod.POST)
   public String editSubmit(@PathVariable int boardId,
                      @Valid Board board, 
                      BindingResult result,
                      MultipartHttpServletRequest request) throws Exception {

      // ????????? ?????? ?????? ??????
      if (result.hasErrors())
         return "board/edit";
      
      List<MultipartFile> attachments = request.getFiles("files");
      
      if(!service.update(board, attachments)) return "board/edit";
      return "redirect:/board/view/"+boardId;
   }
   
   @RequestMapping(value="/delete/{boardId}", method=RequestMethod.GET)
   public String editForm(@PathVariable int boardId, HttpSession session) throws Exception{
      Student user = (Student) session.getAttribute("USER");
      Board board = service.getBoard(boardId);
      if(user==null || !board.getWriter().equals(user.getStudentNumber())) //??????????????? ??????
         return "redirect:/board/list";
      if(!service.delete(boardId)) return "board/view/"+boardId;
      return "redirect:/board/list";
   }
   
   @ResponseBody   //view??? ???????????? ?????????????????? ?????? ????????? ?????? ??????(??????)
   @RequestMapping(value="/delete_attachment/{attachmentId}", method=RequestMethod.DELETE)
   public boolean delete(@PathVariable int attachmentId) throws Exception{
      return service.deleteAttachment(attachmentId); //???????????? ??????
   }

   // ?????????????????? ?????? ????????? ?????????
   @ExceptionHandler({ SQLException.class, DataAccessException.class })
   public String handleError() {
      return "error/database_error"; // ?????? ?????? ??????
   }
}