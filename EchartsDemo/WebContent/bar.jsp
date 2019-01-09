<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>ECharts</title>
    <!-- 引入 ECharts 文件 -->
    <script type = "text/javascript" src="resource/echarts.min.js"></script>
	<script type = "text/javascript" src="resource/jquery.min.js"></script>
</head>

<body>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width: 600px;height:400px;"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        
        //创建新的数组来存放后端传进来的数据
		var arr = new Array();
		var name = new Array();
		var index = 0;
		var index1 = 0;
		<c:forEach items="${good}" var = "g">
			arr[index++]="${g.sum}"
		</c:forEach>
		<c:forEach items="${good}" var = "g">
			name[index1++]="${g.name}"
		</c:forEach>
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: 'servlet + echarts'
            },
            tooltip: {},
            legend: {
                data:['销量']
            },
            xAxis: {
            	name :'种类',
            	type : 'category',
                data: name
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'bar',
                data: arr
            }]
        }
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
</body>
</html>