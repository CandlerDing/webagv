<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript"> 

function SearchandSend(code1,code2)
{
	$.ajax({
        type: "POST",
        url: "http://192.168.1.122:8086/agv/search/search",
        data: {code1:code1,code2:code2,ip:$("#ip").val(),port:$("#port").val()},       
        success: function(data){
        	       alert(data);                 
                 }
    });	
}
function Search(code1,code2)
	{
	$.ajax({
        type: "POST",
        url: "http://192.168.1.122:8086/agv/agv/getSearch.jsp",
        data: {code1:code1,code2:code2},       
        success: function(data){//alert(data);
                    $('#A1').html(""); 
                    $('#A1').html(data);
                 }
    });
 } 
function SearchB(code1,code2)
{
$.ajax({
    type: "POST",
    url: "http://192.168.1.122:8086/agv/agv/getSearch.jsp",
    data: {code1:code1,code2:code2},       
    success: function(data){//alert(data);
                $('#B1').html(""); 
                $('#B1').html(data);
             }
});
} 
function SearchD(code1,code2,code3)
{
$.ajax({
    type: "POST",
    url: "http://192.168.1.122:8086/agv/agv/getControl.jsp",
    data: {code1:code1,code2:code2,code3:code3},       
    success: function(data){//alert(data);
                $('#D1').html(""); 
                $('#D1').html(data);
             }
});
} 
 </script> 
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
 <base href="<%=basePath%>">

 <title>My JSP 'index.jsp' starting page</title>
 <meta http-equiv="pragma" content="no-cache">
 <meta http-equiv="cache-control" content="no-cache">
 <meta http-equiv="expires" content="0"> 
 <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
 <meta http-equiv="description" content="This is my page">
 <!--
<link rel="stylesheet" type="text/css" href="styles.css">
 -->
 </head>

 <body>
<table align="center" width="100%" border="0">
<tr>
<td>IP:
</td>
<td>
<input name="ip" id="ip" size="15" maxlength="20" value="192.168.1.2">
<input name="port" id="port" size="5" maxlength="5" value="4001">
</td>
</tr>
<tr>
<td width="100%" colspan="2" height="30" align="center">
<font color="#FF0000" style="font-weight:bold; font-size:18px">查询车辆的属性</font>
</td>
</tr>
<tr>
<td align="left"  width="10%">
车辆是否故障:
</td><td align="left">
<input type="button"  value="查询车辆详细故障信息A1.00" onclick="Search('00010003','000100010001');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010001');"/>
<input type="button"  value="查询车辆总故障标识指令A1.01" onclick="Search('00010003','000100010002');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010002');"/>
<input type="button"  value="查询车体驱动板本身故障标识指令A1.02" onclick="Search('00010003','000100010003');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010003');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="查询车体驱动板外围故障标识指令A1.03" onclick="Search('00010003','000100010009');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010009');"/>
<input type="button"  value="查询车体驱动板前侧超声蔽障雷达故障标识指令A1.04" onclick="Search('00010003','000100010004');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010004');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="查询车体后侧超声蔽障雷达故障标识A1.05" onclick="Search('00010003','000100010005');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010005');"/>
<input type="button"  value="查询车体左侧右侧超声蔽障雷达故障标识A1.06" onclick="Search('00010003','000100010006');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010006');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="查询车体外围故障标识A1.07" onclick="Search('00010003','000100010007');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010007');"/>
<input type="button"  value="查询车体外围、货物故障标识A1.08" onclick="Search('00010003','000100010008');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010008');"/>
</td>
</tr>
<tr>
<td align="left"  width="10%">
车辆实时状态:
</td><td align="left">
<input type="button"  value="查询车辆详细实时状态信息指令A2.00" onclick="Search('00010003','000100020001');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020001');"/>
<input type="button"  value="查询车体电池电压指令A2.01" onclick="Search('00010003','000100020002');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020002');"/>
<input type="button"  value="查询车体行驶方向指令A2.02" onclick="Search('00010003','000100020003');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020003');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="查询车体行驶速度指令A2.03" onclick="Search('00010003','000100020004');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020004');"/>
<input type="button"  value="查询车辆位置信息指令A2.04" onclick="Search('00010003','000100020005');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020005');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="查询车体通道载货状态指令 A2.05" onclick="Search('00010003','000100020006');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020006');"/>
<input type="button"  value="查询车辆上下货动作状态指令 A2.06" onclick="Search('00010003','000100020007');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020007');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="查询车辆总体状态指令A2.07" onclick="Search('00010003','000100020008');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100010007');"/>
<input type="button"  value=" 查询车辆控制权指令 A2.08" onclick="Search('00010003','000100020009');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020009');"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="button"  value="查询车辆运行模式指令A2.09" onclick="Search('00010003','000100020010');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020010');"/>
<input type="button"  value="查询车体电池电量指令 A2.10" onclick="Search('00010003','000100020011');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100020011');"/>
</td>
</tr>
<tr>
<td align="left"  width="10%">
车辆当前时间:
</td><td align="left">
<input type="button"  value="查询车辆日历+时间信息指令A3.00" onclick="Search('00010003','000100030001');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100030001');"/>
<input type="button"  value="查询车辆时间信息指令A3.01" onclick="Search('00010003','000100030002');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','000100030002');"/>
</td>
</tr>
<tr>
<td>
查询车辆命令：
</td>
<td>
<div id=A1></div>
</td>
</tr>
<tr>
<td width="100%" colspan="2" height="30" align="center">
<font color="#FF0000" style="font-weight:bold; font-size:18px">查询路径的属性</font>
</td>
</tr>
<tr>
<td align="left"  width="10%">
</td><td align="left">
<input type="button"  value="查询详细路径状态信息指令B1.00" onclick="SearchB('00010003','00020001');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','00020001');"/>
<input type="button"  value="查询路径状态信息总标识指令B1.01" onclick="SearchB('00010003','00020002');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','00020002');"/>
<input type="button"  value="查询路径磁条丢失指令B1.02" onclick="SearchB('00010003','00020003');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','00020003');"/>
<input type="button"  value=" 查询路径地标RFID点丢失指令 B1.03" onclick="SearchB('00010003','00020004');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010003','00020004');"/>
</td>
</tr>
<tr>
<td>
查询路径命令：
</td>
<td>
<div id=B1></div>
</td>
</tr>
<tr>
<td width="100%" colspan="2" height="30" align="center">
<font color="#FF0000" style="font-weight:bold; font-size:18px">强制控制车辆的指令</font>
</td>
</tr>
<tr>
<td align="left"  width="10%">
</td><td align="left">
<input type="button"  value="强制修改释放车辆控制权指令(手机修改为手机)D1.00" onclick="SearchD('00010003','00040001','00040003');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010001','00040001');"/>
<input type="button"  value="强制车辆启停指令D1.01" onclick="SearchD('00010001','00040002');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010001','00040002');"/>
<input type="button"  value="强制取消车辆任务指令D1.02" onclick="SearchD('00010001','00040003');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010001','00040003');"/>
<input type="button"  value="强制修改车辆日历+时间指令D1.03" onclick="SearchD('00010001','000D0004');"/>
<input type="button"  value="发送" onclick="SearchandSend('00010001','000D0004');"/>
</td>
</tr>
<tr>
<td>
强制控制车辆命令：
</td>
<td>
<div id=D1></div>
</td>
</tr>
</table> </body>
</html>
