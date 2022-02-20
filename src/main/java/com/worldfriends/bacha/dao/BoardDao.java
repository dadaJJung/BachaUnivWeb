package com.worldfriends.bacha.dao;

import java.util.List;

import com.worldfriends.bacha.model.Board;
import com.worldfriends.bacha.model.Options;
import com.worldfriends.bacha.model.SortOption;
import com.worldfriends.bacha.model.Student;

public interface BoardDao extends BaseDao<Board, Integer> {
   List<Board> selectListUser(String writer) throws Exception;
   int increaseReadCnt(int boardId) throws Exception;            
   
   int getCountByOption(Options options) throws Exception;
   List<Board> selectListByOption(SortOption sortOption) throws Exception;
}