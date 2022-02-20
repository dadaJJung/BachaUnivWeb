package com.worldfriends.bacha.dao;

import java.util.List;

import com.worldfriends.bacha.model.Options;
import com.worldfriends.bacha.model.Password;
import com.worldfriends.bacha.model.SortOption;
import com.worldfriends.bacha.model.Student;

public interface StudentDao extends BaseDao<Student, String> {
   int changePassword(Password password) throws Exception;

   // 관리자 호출 메소드
   int updateByAdmin(Student student) throws Exception;

   int changePasswordByAdmin(Password password) throws Exception;

   List<Student> selectListByNumSort(SortOption sortOption) throws Exception;

   List<Student> selectListByAlphabetSort(SortOption sortOption) throws Exception;
   
   int getCountByOption(Options options) throws Exception;
}