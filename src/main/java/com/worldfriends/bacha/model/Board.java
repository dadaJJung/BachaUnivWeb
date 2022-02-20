package com.worldfriends.bacha.model;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;

import lombok.Data;

@Data
public class Board {
   private int boardId;
   @Length(max=60, message = "Title cannot be too long (maximun is 60 characters)")
   @NotEmpty(message = "Title cannot be blank")
   private String title;
   private String writer;
   private int readCnt;
   @NotEmpty(message = "Content cannot be blank")
   private String content;
   private Date regDate;
   private Date updateDate;
   private List<Attachment> attachments; //첨부 파일 목록
   
   private int replyNum;
   private boolean hasAttachment;
   private String writerName;
   private int seq;
}