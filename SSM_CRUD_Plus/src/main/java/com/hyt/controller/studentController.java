package com.hyt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hyt.domain.Student;
import com.hyt.service.stuService;
import com.hyt.util.getUtil;

@Controller
public class studentController {
	@Autowired
	private stuService stuSerive;
	
	
	@RequestMapping("show")
	@ResponseBody
	public PageInfo<Student> show(@RequestParam(value="page",defaultValue="1") Integer page) {
		PageHelper.startPage(page,getUtil.PageSize);
		List<Student> list = stuSerive.selectStudents();
		PageInfo<Student> pageinfo = new PageInfo<>(list,getUtil.navigatePages);
		return pageinfo;
	}
	@RequestMapping("delete")
	@ResponseBody
	public void delete(Integer id) {
		stuSerive.deleteByPrimaryKey(id);
	}
	
	@RequestMapping("getStus")
	@ResponseBody
	public ModelAndView getStus(@RequestParam(value="page",defaultValue="1") Integer page) {
		//PageHelper.startPage(page,getUtil.PageSize);
		List<Student> list = stuSerive.selectStudents();
		Map map = new HashMap();
		map.put("list",list);
		ModelAndView mav = new ModelAndView("/Query",map);
		return mav;
	}
	
	@RequestMapping("deleStus")
	public String deleStus(@RequestParam Integer id,@RequestParam(value="page",defaultValue="1") Integer page){
		int flag = stuSerive.deleteByPrimaryKey(id);
		if(flag>0) {
			System.out.println("删除成功");
		}
		//跳过视图解析器的方法
		return "forward:/getStus";
	}
	@RequestMapping("insertStus")
	public String insertStus(String name,Integer age,Integer sex,String address) {
		Student s = new Student();
		s.setName(name);
		s.setAge(age);
		if(sex==1) {
			s.setSex("男");
		}else {
			s.setSex("女");
		}
		s.setAddress(address);
		int flag =stuSerive.insert(s);
		if(flag>0) {
			System.out.println("添加成功");
		}
		return "forward:/getStus";
	}
	@RequestMapping("updateStus")
	public String UpdateStus(Integer id,String name,Integer age,String sex,String address) {
		Student record = new Student();
		record.setId(id);
		record.setName(name);
		record.setAge(age);
		record.setSex(sex);
		record.setAddress(address);
		int flag = stuSerive.updateByPrimaryKey(record);
		if(flag>0) {
			System.out.println("修改成功");
		}
		return "forward:/getStus";
	}
	
	@RequestMapping("selectByPrimaryKey")
	public ModelAndView selectByPrimaryKey(Integer id) {
		System.out.println(id);
		Student stu = stuSerive.selectByPrimaryKey(id);
		Map map = new HashMap();
		map.put("stu", stu);
		ModelAndView mav = new ModelAndView("/Update",map);
		return mav;
	}
}
