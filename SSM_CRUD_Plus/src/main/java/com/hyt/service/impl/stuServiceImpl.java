package com.hyt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyt.dao.StudentMapper;
import com.hyt.domain.Student;
import com.hyt.service.stuService;

@Service("stuSerive")
public class stuServiceImpl implements stuService {
	@Autowired
	//自动的创建对象
	private StudentMapper studentmapper;
	@Override
	public List<Student> selectStudents() {	
		return studentmapper.selectStudents();
	}
	@Override
	public int deleteByPrimaryKey(Integer id) {
		return studentmapper.deleteByPrimaryKey(id);
	}
	@Override
	public int insert(Student record) {
		return studentmapper.insert(record);
	}
	@Override
	public int updateByPrimaryKey(Student record) {
		
		return studentmapper.updateByPrimaryKey(record);
	}
	@Override
	public Student selectByPrimaryKey(Integer id) {
		return studentmapper.selectByPrimaryKey(id);
	}
	
	
}
