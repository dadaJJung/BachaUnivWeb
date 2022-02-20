package com.worldfriends.bacha.service;

import java.util.List;

import com.worldfriends.bacha.model.Avatar;
import com.worldfriends.bacha.model.Login;
import com.worldfriends.bacha.model.Student;
import com.worldfriends.bacha.model.Pagination;
import com.worldfriends.bacha.model.Password;
import com.worldfriends.bacha.model.SortOption;

public interface StudentService {
   Student checkLogin(Login login) throws Exception;

   boolean create(Student student) throws Exception;

   boolean checkId(String studentNumber) throws Exception;

   boolean update(Student student) throws Exception;

   Student getStudent(String studentNumber) throws Exception;

   Pagination getPagination(int page) throws Exception;
   
   Pagination getPagination(int page, int totalSize) throws Exception;
   
   Pagination getPaginationHome(int page, int totalSize) throws Exception;

   List<Student> getListByNumSort(SortOption sortOption) throws Exception;

   List<Student> getListByAlphabetSort(SortOption sortOption) throws Exception;

   // 아바타 처리
   byte[] getAvatar(String studentNumber) throws Exception;

   boolean insertAvatar(Avatar avatar) throws Exception;

   boolean updateAvatar(Avatar avatar) throws Exception;

   boolean deleteAvatar(String studentNumber) throws Exception;

   boolean changepassword(Password password) throws Exception;

}