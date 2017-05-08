<%@ page language="java" %>
<%--任务队列--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.agvdirecting.*"%>

<html>
<head>
<title>监控</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/default/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript"  src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/listfunction.js"></script>
<link id="easyuiTheme" rel="stylesheet" href="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/themes/default/easyui.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/themes/icon.css" type="text/css"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/formfunction.js"></script>
<script type="text/JavaScript">

	/**
	*启动后台
	*/
	function qdhtfw(){  
	 $.ajax({
	        type: "POST",
	        url: "qdht.jsp",
	        data: {},       
	        success: function(data){	        	      
	        	    document.getElementById("qd").disabled=true; 
	        	    alert("车辆指挥系统启动成功..."); 
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown) {
	        	 alert("车辆指挥系统启动出现问题，请联系管理员！！！"); 
	        	   },
	       
	    });	
	}
	/**
	*启动后台
	*/
	function tzhtfw(){  
		$.ajax({
	        type: "POST",
	        url: "gbht.jsp",
	        data: {},       
	        success: function(data){

	        	   document.getElementById("qd").disabled=false; 
	        	   document.getElementById("tz").disabled=true; 
		        	alert("车辆指挥系统已停止...");
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown) {
	        	 alert("车辆管理系统停止出现问题，请联系管理员！！！"); 
	       }
	    });	

	}  
</script>
</head>
<body >
<div class="easyui-layout" style="width:100%;height:98%;">
		
		<button type="button" class="btn btn-success" id="qd"  onclick="qdhtfw()" <%
		DirectingSystem directingSystem = DirectingSystem.GetInstance();
		if(directingSystem.getPort()!=null){ %>
			disabled="true"
			<% 
		} %>>启动后台服务</button>
<!-- 	<button type="button" class="btn btn-danger"  id="tz"onclick="tzhtfw()">停止后台服务</button> -->
	</div>
</body>
</html>
