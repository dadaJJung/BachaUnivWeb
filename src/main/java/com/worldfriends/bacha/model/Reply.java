package com.worldfriends.bacha.model;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Reply {
   private int replyId;
   private int boardId;
   private int replyLevel; //0이면 top-level 댓글, 1이면 답댓글
   private int parent;
   private String writer;
   private String content;
   private int deleted; //1이면 삭제된 댓글, 아니면 0
   private int likeCnt; //좋아요 개수
   private Date regDate;
   private Date updateDate;
   
   private String writerName;
   private String writerMajor;
   private int rereplyNum;
}