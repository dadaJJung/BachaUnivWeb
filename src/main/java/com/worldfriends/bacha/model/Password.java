package com.worldfriends.bacha.model;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class Password {
	@NotEmpty(message = "Password cannot be blank")
	private String studentNumber;
	
	@NotEmpty(message = "New Password cannot be blank")
	private String newPassword;
	
	@NotEmpty(message = "Current Password cannot be blank")
	private String oldPassword;
}
