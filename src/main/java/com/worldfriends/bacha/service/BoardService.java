package com.worldfriends.bacha.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.worldfriends.bacha.model.Attachment;
import com.worldfriends.bacha.model.Board;
import com.worldfriends.bacha.model.Pagination;
import com.worldfriends.bacha.model.SortOption;

public interface BoardService {
   boolean create(Board board, List<MultipartFile> fileList) throws Exception;
   boolean update(Board board, List<MultipartFile> fileList) throws Exception;
   boolean delete(int boardId) throws Exception;
   Board getBoard(int boardId) throws Exception;
   List<Board> getList(SortOption sortOption) throws Exception;
   Pagination getPagination(int page, int noticeNum, int totalSize) throws Exception;
   Pagination getPaginationHome(int page, int noticeNum, int totalSize) throws Exception;
   boolean increaseReadCnt(int boardId) throws Exception;
   
   //첨부파일
   Attachment getAttachment(int attachmentId) throws Exception;
   //List<Attachment> getAttachments(int boardId) throws Exception;// getBoard에서 처리
   //boolean insertAttachment(Attachment attachment) throws Exception; //create에서 처리
   boolean deleteAttachment(int attachmentId) throws Exception;
   //boolean deleteByBoardId(int boardId) throws Exception; //delete에서 처리
   List<Board> getListNotice() throws Exception;
}