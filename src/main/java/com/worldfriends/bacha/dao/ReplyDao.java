package com.worldfriends.bacha.dao;

import java.util.List;

import com.worldfriends.bacha.model.Reply;

public interface ReplyDao {
   int getCount(int boardId) throws Exception;
   
   int getCountRereply(int replyId) throws Exception;

   Reply selectOne(int replyId) throws Exception;

   List<Reply> selectList(int boardId) throws Exception;

   int insert(Reply reply) throws Exception;

   int update(Reply reply) throws Exception;

   int delete(int replyId) throws Exception;
   
   int increaseLikeCnt(int replyId) throws Exception;
   
}