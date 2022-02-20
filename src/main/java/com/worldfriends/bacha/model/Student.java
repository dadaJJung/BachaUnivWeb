package com.worldfriends.bacha.model;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;

import lombok.Data;

@Data
public class Student {
   @NotEmpty(message="Student Number cannot be blank")
   private String studentNumber;
   
   @NotEmpty(message="Password cannot be blank")
   private String password;
   
   @NotEmpty(message="Name cannot be blank")
   private String studentName;
   
   @NotEmpty(message="Phone number cannot be blank")
   private String cellPhone;
   
   @NotEmpty(message="Email cannot be blank")
   private String email;
   
   @NotEmpty(message="Address cannot be blank")
   private String address;
   
 //  @NotEmpty(message="입학일을 입력하세요.")
   private String admissionYear;
   
//   @NotEmpty(message="졸업일을 입력하세요.")
   private String graduationYear;
   
   @NotEmpty(message="Major cannot be blank")
   private String major;
   
   @Length(max=70, message = "Introduction cannot be too long (maximun is 70 characters)")
   private String introduction;
   
   private int grade;
   private Date regDate;
   private Date updateDate;
}