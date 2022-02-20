package com.worldfriends.bacha.model;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Attachment {
	public Attachment(int boardId, String fName, String newName) {
		fileName = fName;
		location = newName;
		this.boardId = boardId;
	}
	
	private int attachmentId;
	private String fileName; //원본 파일명
	private String location;  //서버에서의 파일명
	private int boardId;  //게시글 ID
	private Date regDate;
}
