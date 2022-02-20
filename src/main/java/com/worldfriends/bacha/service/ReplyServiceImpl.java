package com.worldfriends.bacha.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.worldfriends.bacha.dao.ReplyDao;
import com.worldfriends.bacha.dao.StudentDao;
import com.worldfriends.bacha.model.Reply;

@Service
public class ReplyServiceImpl implements ReplyService{

   @Autowired
   ReplyDao dao;
   
   @Autowired
   StudentDao studentDao;
   
   @Transactional
   @Override
   public Reply create(Reply reply) throws Exception {
      dao.insert(reply);
      Reply nreply = dao.selectOne(reply.getReplyId());
      nreply.setWriterName(studentDao.selectOne(reply.getWriter()).getStudentName());
      nreply.setWriterMajor(studentDao.selectOne(reply.getWriter()).getMajor());
      nreply.setRereplyNum(dao.getCountRereply(reply.getReplyId()));
      return nreply;
   }

   @Transactional
   @Override
   public Reply update(Reply reply) throws Exception {
      dao.update(reply);
      return dao.selectOne(reply.getReplyId());
   }

   @Transactional
   @Override
   public boolean delete(int replyId) throws Exception {
      return dao.delete(replyId) == 1;
   }

   @Override
   public Reply getReply(int replyId) throws Exception {
      Reply reply = dao.selectOne(replyId);
      reply.setWriterName(studentDao.selectOne(reply.getWriter()).getStudentName());
      reply.setWriterMajor(studentDao.selectOne(reply.getWriter()).getMajor());
      reply.setRereplyNum(dao.getCountRereply(reply.getReplyId()));
      return reply;
   }

   @Override
   public List<Reply> getList(int boardId) throws Exception {
      List<Reply> list = dao.selectList(boardId);
      for(Reply reply:list) {
         reply.setWriterName(studentDao.selectOne(reply.getWriter()).getStudentName());
         reply.setWriterMajor(studentDao.selectOne(reply.getWriter()).getMajor());
         reply.setRereplyNum(dao.getCountRereply(reply.getReplyId()));
      }
      return list;
   }

   @Transactional
   @Override
   public boolean like(int replyId) throws Exception {
      return dao.increaseLikeCnt(replyId) == 1;
   }

   @Override
   public int getCount(int boardId) throws Exception {
      return dao.getCount(boardId);
   }


}