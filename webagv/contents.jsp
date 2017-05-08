<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.db.*"%>
<%@ page import="com.software.main.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
UserInfo userInfo = Tool.getUserInfo(request);
if (userInfo==null) {
    out.print("<meta http-equiv='refresh' content='0;url=logon.jsp'>");
    return;
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>肥城市人民检察院</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
<link id="easyuiTheme" rel="stylesheet" href="/jslib/jquery-easyui-1.3.3/themes/default/easyui.css" type="text/css">
 <link rel="stylesheet" href="/jslib/jquery-easyui-1.3.3/themes/icon.css" type="text/css"> 
<script type="text/javascript" src="/jslib/jquery-easyui-1.3.3/jquery.easyui.min.js" charset="GBK"></script>
<script type="text/javascript" src="/jslib/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js" charset="GBK"></script>


<style>
	.link_enter{width:101px;height:30px;line-height:26px;padding-left:10px;margin:3px 5px 0 0px;text-decoration:none;display:block;background:url(images/default/t-3.jpg) 0 0 no-repeat;float:left;}
	</style>
	<script>
function show(){
	 $.getJSON("dangan/dbtx.jsp?t="+new Date(), function(json){ 
	 $.each(json,function(i){
		 if(json[i].msg!=""){
	$.messager.show({
		title:'提醒',
		msg: json[i].msg,
        timeout:300000,
		width:220,
		height:120, 
		showType:'show'		
	});}
	});
	});
}
$(document).ready(function(){
//	show();
})
</script>
</head>

<body>

<div id="cc" class="easyui-layout" style="width:;height:450px;overflow:auto">  
    <div data-options="region:'north',href:'maincontent/north.jsp',split:true" style="height:190px;overflow:hidden"></div>  
    <div data-options="region:'center'" style="padding:5px;background:#ffffff;overflow:hidden;">
  
    </div>
    <!-- <div data-options="region:'south',href:'',split:true" title="审务通报及态势分析" style="height:260px;overflow:hidden"></div> -->
    </div>
</body>
</html>

