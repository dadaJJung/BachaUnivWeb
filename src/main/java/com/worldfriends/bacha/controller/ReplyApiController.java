package com.worldfriends.bacha.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.worldfriends.bacha.controller.ReplyApiController;
import com.worldfriends.bacha.model.Reply;
import com.worldfriends.bacha.service.ReplyService;

@RestController
@RequestMapping("/api/reply/{boardId}")
public class ReplyApiController {

	@Autowired
	ReplyService service;

	@RequestMapping(method=RequestMethod.GET)
	public List<Reply> getList(@PathVariable int boardId) throws Exception{
		return service.getList(boardId);
	}
	
	@RequestMapping(value="/{replyId}", method=RequestMethod.GET)
	public Reply get(@PathVariable int boardId, @PathVariable int replyId) throws Exception{
		return service.getReply(replyId);
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Reply insert(@PathVariable int boardId, @RequestBody Reply reply) throws Exception{
		return service.create(reply);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Reply update(@PathVariable int boardId, @RequestBody Reply reply) throws Exception{
		return service.update(reply);
	}
	
	@RequestMapping(value = "/{replyId}", method=RequestMethod.DELETE)
	public boolean delete(@PathVariable int boardId,@PathVariable int replyId) throws Exception{
		return service.delete(replyId);
	}
	
	
	
}
