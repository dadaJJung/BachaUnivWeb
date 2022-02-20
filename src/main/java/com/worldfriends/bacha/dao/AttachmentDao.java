package com.worldfriends.bacha.dao;

import java.util.List;

import com.worldfriends.bacha.model.Attachment;

public interface AttachmentDao {
   int getCount(int boardId) throws Exception;

    Attachment selectOne(int attachmentId) throws Exception;

    List<Attachment> selectList(int boardId) throws Exception;

    int insert(Attachment attachment) throws Exception;

    int delete(int attachmentId) throws Exception;

    int deleteByBoardId(int boardId) throws Exception;

}