<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<!-- 引入bootstrap样式 -->
<link href="https://cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<!-- 引入bootstrap-table样式 -->
<link href="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.css" rel="stylesheet">

<!-- jquery -->
<script src="https://cdn.bootcss.com/jquery/2.2.3/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<!-- bootstrap-table.min.js -->
<script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
<!-- 引入中文语言包 -->
<script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    $('#table').bootstrapTable({
        url: '@Url.Action("SearchBookInfo", "Home")',
        queryParamsType: '',              //默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
        queryParams: queryParams,
        method: "post",
        pagination: true,
        pageNumber: 1,
        pageSize: 2,
        pageList: [10, 20, 50, 100],
        sidePagination: "server",         //分页方式：client客户端分页，server服务端分页（*）
        striped: true,                    //是否显示行间隔色
        cache: false,
        uniqueId: "BookId",               //每一行的唯一标识，一般为主键列
        height:300,
        paginationPreText: "上一页",
        paginationNextText: "下一页",
        columns: [
            { checkbox: true },
            { title: '序号', width: 50, align: "center", formatter: function (value, row, index) { return index + 1; } },
            { title: '图书名称', field: 'Title' },
            { title: '图书作者', field: 'Author' },
            { title: '销售价格', field: 'Price' },
            { title: '出版社', field: 'Publish' },
            {
                title: '出版时间', field: 'PublishDate', formatter: function (value, row, index) {
                    if (value == null)
                        return "";
                    else {
                        var pa = /.*\((.*)\)/;
                        var unixtime = value.match(pa)[1].substring(0, 10);
                        return getShortTime(unixtime);
                    }
                }
            },
            {
            	title: '操作', field: 'BookId', formatter: function (value, row, index) {
                    var html = '<a href="javascript:EditBook('+ value + ')">编辑</a>';
                    html += '　<a href="javascript:DeleteBook(' + value + ')">删除</a>';
                    return html;
                }
            }
        ]
    });
});
</script>
</head>
<body>
<table id = "table"></table>
</body>
</html>