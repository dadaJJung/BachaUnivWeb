package com.worldfriends.bacha.model;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;

import lombok.Data;

@Data
public class Login {
	@NotEmpty(message = "Student Number cannot be blank")
	private String studentNumber;
	
	@NotEmpty(message = "Password cannot be blank")
	//@Length(min=4, message = "minimum is 4 characters")
	private String password;
	
	private String url;
}
