package com.worldfriends.bacha.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.worldfriends.bacha.dao.AttachmentDao;
import com.worldfriends.bacha.dao.BoardDao;
import com.worldfriends.bacha.dao.ReplyDao;
import com.worldfriends.bacha.dao.StudentDao;
import com.worldfriends.bacha.model.Attachment;
import com.worldfriends.bacha.model.Board;
import com.worldfriends.bacha.model.Pagination;
import com.worldfriends.bacha.model.SortOption;
import com.worldfriends.bacha.util.S3Util;
import com.worldfriends.bacha.util.UploadFileUtils;

@Service
public class BoardServiceImpl implements BoardService {
   @Autowired
   BoardDao dao;
   
   @Autowired
   ReplyDao replyDao;
   
   @Autowired
   AttachmentDao attachmentDao;
   
   @Autowired
   StudentDao studentDao;
   
   S3Util s3 = new S3Util();
   String bucketName = "upload-attachment";

   
   
   
   @Transactional
   @Override
   public boolean create(Board board, List<MultipartFile> fileList) throws Exception {
      int result = dao.insert(board); //삽입된 행의 개수 리턴. boardId에 id 값(시퀀스)이 들어옴
      upload(board.getBoardId(), fileList);
      return result == 1;
   }
   

   public boolean upload(int boardId, List<MultipartFile> fileList) throws Exception{
      for(MultipartFile file:fileList) {
         if(!file.isEmpty()) {
            Attachment attachment = save(boardId, file);
            attachmentDao.insert(attachment);
         }
      }
      return true;
   }
   

   
   public Attachment save(int boardId, MultipartFile file) throws Exception{
	 
	   
	  String fname = file.getOriginalFilename(); //원본 파일명
	  String uploadpath = "upload";
	  String newName = UploadFileUtils.uploadFile(uploadpath, file.getOriginalFilename(), file.getBytes());

	  
//      long fileNo = System.currentTimeMillis();
//      String newName = fileNo+"_"+fname;   //unique한 파일명을 만듦
//      String path = "c:/temp/upload/" + newName; 
//      file.transferTo(new File(path)); //실제 경로에 파일 저장
	  
      return new Attachment(boardId, fname, newName); 
   }

   
 
   
   @Transactional
   @Override
   public boolean update(Board board, List<MultipartFile> fileList) throws Exception {
      int result = dao.update(board);
      upload(board.getBoardId(), fileList);//첨부파일 삽입   
      return result == 1;
   }

   @Transactional
   @Override
   public boolean delete(int boardId) throws Exception {
      attachmentDao.deleteByBoardId(boardId); //게시물 삭제 시 연결된 첨부파일도 함께 삭제
      int result = dao.delete(boardId);
      return result==1;
   }

   @Override
   public Board getBoard(int boardId) throws Exception {
      Board board = dao.selectOne(boardId);
      List<Attachment> attachments = attachmentDao.selectList(boardId);
      board.setAttachments(attachments);
      board.setReplyNum(replyDao.getCount(board.getBoardId()));
      return board;
   }

   @Override
   public List<Board> getList(SortOption sortOption) throws Exception {
      List<Board> list = dao.selectListByOption(sortOption);
      for(Board board:list) {
         board.setReplyNum(replyDao.getCount(board.getBoardId()));
         board.setHasAttachment(attachmentDao.getCount(board.getBoardId())>0?true:false);
         board.setSeq(dao.getCount()-board.getSeq()+1); //역순으로 수정
      }
      return list;
   } 
   
   @Override
   public List<Board> getListNotice() throws Exception {
      List<Board> list = dao.selectListUser("admin");
      for(Board board:list) {
         board.setReplyNum(replyDao.getCount(board.getBoardId()));
         board.setHasAttachment(attachmentDao.getCount(board.getBoardId())>0?true:false);
      }
      return list;
   } 

   @Override
   public Pagination getPagination(int page, int noticeNum, int totalSize) throws Exception {
      return new Pagination(page, totalSize, 15, 10, noticeNum);
   }
   @Override
   public Pagination getPaginationHome(int page, int noticeNum, int totalSize) throws Exception {
      return new Pagination(page, totalSize, 10, 10, noticeNum);
   }

   @Transactional
   @Override
   public boolean increaseReadCnt(int boardId) throws Exception {
      return dao.increaseReadCnt(boardId)==1;
   }

   @Override
   public Attachment getAttachment(int attachmentId) throws Exception {
      return attachmentDao.selectOne(attachmentId);
   }

   @Transactional
   @Override
   public boolean deleteAttachment(int attachmentId) throws Exception {
      return attachmentDao.delete(attachmentId)==1;
   }

}