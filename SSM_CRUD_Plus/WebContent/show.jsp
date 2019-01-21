<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>

<div class="container">
  <nav class="navbar navbar-default">
    <div class="container-fluid">
      <!-- Brand and toggle get grouped for better mobile display -->
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
          <span class="sr-only">Toggle navigation</span> <span
          class="icon-bar"></span> <span class="icon-bar"></span> <span
          class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">Brand</a>
      </div>

      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse"
           id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
          <li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>
          <li><a href="#">Link</a></li>
          <li class="dropdown"><a href="#" class="dropdown-toggle"
                                  data-toggle="dropdown" role="button" aria-haspopup="true"
                                  aria-expanded="false">Dropdown <span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li role="separator" class="divider"></li>
              <li><a href="#">Separated link</a></li>
              <li role="separator" class="divider"></li>
              <li><a href="#">One more separated link</a></li>
            </ul></li>
        </ul>
        <form class="navbar-form navbar-left">
          <div class="form-group">
            <input type="text" class="form-control" placeholder="Search">
          </div>
          <button type="submit" class="btn btn-default">Submit</button>
        </form>
        <ul class="nav navbar-nav navbar-right">
          <li><a href="#">Link</a></li>
          <li class="dropdown"><a href="#" class="dropdown-toggle"
                                  data-toggle="dropdown" role="button" aria-haspopup="true"
                                  aria-expanded="false">Dropdown <span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">Action</a></li>
              <li><a href="#">Another action</a></li>
              <li><a href="#">Something else here</a></li>
              <li role="separator" class="divider"></li>
              <li><a href="#">Separated link</a></li>
            </ul></li>
        </ul>
      </div>
      <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
  </nav>
  <!--导航条结束-->
  <table class="table table-hover">
     <thead>
    <tr>
      <td>ID</td>
      <td>姓名</td>
      <td>年龄</td>
      <td>性别</td>
      <td>地址</td>
      <td>操作</td>
    </tr>
    </thead>
     <tbody id="stu_table">
     </tbody>
  </table>
  	<!-- 分页样式 -->
   <nav aria-label="Page navigation">
	  <ul class="pagination">
	    <li id="pre_btn">
	      <a href="#" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a></li>
	    </ul>
    <ul class="pagination" id="page_list">
    </ul>
    <ul class="pagination">
     <li><a href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span></a>
      </li>
   </ul>
</nav>
</div>
  <script>
    $(function () {
        get_Page_Data(1);
    });
    function get_Page_Data(page) {
      $.ajax({
        method : "GET",
        url : "show",
        data : "page="+ page ,
        success : function (data) {
          //生成表格的行
          get_page_list(data);
          //生成分页
          stu_page(data);
        }
      });
    }
    //生成表格数据
    function get_page_list(data) {
      //注意通过id获取元素使用“#”
      //刷新表格内容先清空避免重复
      var stu_table = $("#stu_table");
      //为了避免的表格的重复
      stu_table.empty();
      //each(list,function(index,item))
      //for(Student s:list)
      //item代表的for中的
      $.each(data.list,function (index,item) {
        var stu_table_tr = $("<tr></tr>");
        var sid = $("<td></td>").append(item.id);
        var sname = $("<td></td>").append(item.name);
        var sage = $("<td></td>").append(item.age);
        var ssex = $("<td></td>").append(item.sex);
        var saddress = $("<td></td>").append(item.address);

        var op = $("<td></td>");
        var update_icon =  $("<span></span>").addClass("glyphicon glyphicon-pencil");
        var delete_icon = $("<span></span>").addClass("glyphicon glyphicon-trash");
        var update_btn = $("<button></button>").addClass("btn btn-warning btn-xs");
        var delete_btn = $("<button></button>").addClass("btn btn-danger btn-xs");
        op.append(update_btn.append("修改")).append("&nbsp;&nbsp;").append(delete_btn.append("删除"));
        // 将列加入到行
        stu_table_tr.append(sid);
        stu_table_tr.append(sname);
        stu_table_tr.append(sage);
        stu_table_tr.append(ssex);
        stu_table_tr.append(saddress);
        stu_table_tr.append(op);
        //将行添加到表格
        stu_table.append(stu_table_tr);
      });
    }
    //遍历生成分页页码
    function stu_page(data) {
      var page_list =  $("#page_list");
      //页码刷新前也先清空
      page_list.empty();
      $.each(data.navigatepageNums,function (index,item) {
        var page_li = $("<li></li>").append($("<a></a>").append(item));
        //如果是第一页禁止翻动
        if(data.isFirstPage){
          $("#pre_btn").addClass("disabled");
        }
        if(data.pageNum==item){
        	page_li.addClass("active");
        }
        page_list.append(page_li);

        //为每一页创建点击事件
        page_li.click(function () {
          get_Page_Data(item);
        })
      })
    }
  </script>
</body>
</html>