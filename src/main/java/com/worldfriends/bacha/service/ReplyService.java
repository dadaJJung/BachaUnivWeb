package com.worldfriends.bacha.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.worldfriends.bacha.model.Attachment;
import com.worldfriends.bacha.model.Avatar;
import com.worldfriends.bacha.model.Board;
import com.worldfriends.bacha.model.Login;
import com.worldfriends.bacha.model.Pagination;
import com.worldfriends.bacha.model.Password;
import com.worldfriends.bacha.model.Reply;
import com.worldfriends.bacha.model.Student;

public interface ReplyService {
	

	
	int getCount(int boardId) throws Exception;
	Reply create(Reply reply) throws Exception;
	Reply update(Reply reply) throws Exception;
	boolean delete(int replyId) throws Exception;
	Reply getReply(int replyId) throws Exception;
	List<Reply> getList(int boardId) throws Exception;
	boolean like(int replyId) throws Exception;
	
}

