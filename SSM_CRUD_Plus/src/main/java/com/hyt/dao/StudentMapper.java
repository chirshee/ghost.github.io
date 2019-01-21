package com.hyt.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hyt.domain.Student;

@Repository
//给dao声明的
public interface StudentMapper {
	//dao接口和mapper中的select标签的id必须相同
	//这样就不用写实现了
	List<Student> selectStudents();
	//删除
    int deleteByPrimaryKey(Integer id);
    //添加
    int insert(Student record);
    //修改
    int updateByPrimaryKey(Student record);
    //根据id查找 
    Student selectByPrimaryKey(Integer id);
    
    int insertSelective(Student record);

    

    int updateByPrimaryKeySelective(Student record);

    
}