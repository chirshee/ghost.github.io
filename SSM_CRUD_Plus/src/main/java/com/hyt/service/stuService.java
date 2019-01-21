package com.hyt.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hyt.domain.Student;

@Service("stuSerive")
public interface stuService {
	
	List<Student> selectStudents();
	
	int deleteByPrimaryKey(Integer id);
	
	int insert(Student record);
	
	int updateByPrimaryKey(Student record);
	
	Student selectByPrimaryKey(Integer id);
}
