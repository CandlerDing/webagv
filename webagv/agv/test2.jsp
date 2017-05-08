<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript"> 

function myClickEvent(obj)
{
	var send1=document.getElementById("One").value+"_"+document.getElementById("Two").value+"_"+document.getElementById("Three").value+"_"+document.getElementById("Four").value+"_"+document.getElementById("Five").value+"_"+document.getElementById("Six").value+"_"+document.getElementById("Seven").value+"_"+document.getElementById("Eight").value+"_"+document.getElementById("Eight1").value+"_"+document.getElementById("Eight2").value+"_"+document.getElementById("Eight3").value+"_"+document.getElementById("Eight4").value+"_"+document.getElementById("Eight5").value+"_"+document.getElementById("Eight6").value+"_"+document.getElementById("Eight7").value+"_"+document.getElementById("Eight8").value+"_"+document.getElementById("Eight9").value+"_"+document.getElementById("Eight10").value+"_"+document.getElementById("Eight11").value+"_"+document.getElementById("Eight12").value+"_"+document.getElementById("Eight13").value+"_"+document.getElementById("Nine").value+"_"+document.getElementById("Ten").value+"_"+document.getElementById("Eleven").value+"_"+document.getElementById("Twelve").value+"_"+document.getElementById("Thirteen").value+"_"+document.getElementById("Fourteen").value+"_"+document.getElementById("Fiveteen").value+"_"+document.getElementById("Sixteen").value+"_"+document.getElementById("Seventeen").value;
	$.ajax({
        type: "POST",
        url: "http://192.168.1.122:8086/agv/server/TestServlet",
        data: {send1:send1,ip:$("#ip").val(),port:$("#port").val()},       
        success: function(data){
        	       alert(data);                 
                 }
    });	
}
function getCrc8(obj)
{
var send1=document.getElementById("One").value+"_"+document.getElementById("Two").value+"_"+document.getElementById("Three").value+"_"+document.getElementById("Four").value+"_"+document.getElementById("Five").value+"_"+document.getElementById("Six").value+"_"+document.getElementById("Seven").value+"_"+document.getElementById("Eight").value+"_"+document.getElementById("Eight1").value+"_"+document.getElementById("Eight2").value+"_"+document.getElementById("Eight3").value+"_"+document.getElementById("Eight4").value+"_"+document.getElementById("Eight5").value+"_"+document.getElementById("Eight6").value+"_"+document.getElementById("Eight7").value+"_"+document.getElementById("Eight8").value+"_"+document.getElementById("Eight9").value+"_"+document.getElementById("Eight10").value+"_"+document.getElementById("Eight11").value+"_"+document.getElementById("Eight12").value+"_"+document.getElementById("Eight13").value+"_"+document.getElementById("Nine").value+"_"+document.getElementById("Ten").value+"_"+document.getElementById("Eleven").value+"_"+document.getElementById("Twelve").value+"_"+document.getElementById("Thirteen").value+"_"+document.getElementById("Fourteen").value+"_"+document.getElementById("Fiveteen").value+"_"+document.getElementById("Sixteen").value+"_"+document.getElementById("Seventeen").value;
$.ajax({
    type: "POST",
    url: "http://192.168.1.122:8086/agv/agv/getCrc8.jsp",
    data: {send1:send1},       
    success: function(data){//alert(data);
                $('#crc8').html(""); 
                $('#crc8').html(data);
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
<td width="100%" colspan="2" height="30" align="center">
<font color="#FF0000" style="font-weight:bold; font-size:18px">命令车辆的任务指令</font>
</td>
</tr>
<tr>
<td align="left"  width="20%">
起始字节:
</td><td align="left"><input name="One" id="One" size="5" maxlength="5" value="A0">
<input name="Two" id="Two" size="5" maxlength="5" value="B0">
</td>
</tr>
<tr>
<td align="left">
数据来源标识:</td><td><input name="Three" id="Three" size="5" maxlength="5" value="00">
</td>
</tr>
<tr>
<td align="left">
该条指令的总字节数:</td><td><input name="Four" id="Four" size="5" maxlength="5" value="00">
<input name="Five" id="Five" size="5" maxlength="5" value="20"></td>
</tr>
<tr>
<td align="left">
命令车辆的任务指令:</td><td><input name="Six" id="Six" size="5" maxlength="5" value="C1">
<input name="Seven" id="Seven" size="5" maxlength="5" value="00">
</td>
</tr>
<tr>
<td align="left">
RFID地标点ID:</td><td><input name="Eight" id="Eight" size="5" maxlength="5" value="00">
<input name="Eight1" id="Eight1" size="5" maxlength="5" value="00">
<input name="Eight2" id="Eight2" size="5" maxlength="5" value="00">
<input name="Eight3" id="Eight3" size="5" maxlength="5" value="00">
<input name="Eight4" id="Eight4" size="5" maxlength="5" value="00">
<input name="Eight5" id="Eight5" size="5" maxlength="5" value="00">
<input name="Eight6" id="Eight6" size="5" maxlength="5" value="00">
<input name="Eight7" id="Eight7" size="5" maxlength="5" value="00">
<input name="Eight8" id="Eight8" size="5" maxlength="5" value="00">
<input name="Eight9" id="Eight9" size="5" maxlength="5" value="00">
<input name="Eight10" id="Eight10" size="5" maxlength="5" value="00">
<input name="Eight11" id="Eight11" size="5" maxlength="5" value="00">
<input name="Eight12" id="Eight12" size="5" maxlength="5" value="00">
<input name="Eight13" id="Eight13" size="5" maxlength="5" value="00">
</td>
</tr>
<tr>
<td align="left">
停止时间:</td><td><input name="Nine" id="Nine" size="5" maxlength="5" value="00">
<input name="Ten" id="Ten" size="5" maxlength="5" value="00"></td>
</tr>
<tr>
<td align="left">
通道A上货次数设定:</td><td><input name="Eleven" id="Eleven" size="5" maxlength="5" value="00">
</td>
</tr>
<tr>
<td align="left">
通道A下货次数设定:</td><td><input name="Twelve" id="Twelve" size="5" maxlength="5" value="00">
</td>
</tr>
<tr>
<td align="left">
通道B上货次数设定:</td><td><input name="Thirteen" id="Thirteen" size="5" maxlength="5" value="00">
</td>
</tr>
<tr>
<td align="left">
通道B下货次数设定:</td><td><input name="Fourteen" id="Fourteen" size="5" maxlength="5" value="00">
</td>
</tr>
<tr>
<td align="left">
方向设定:</td><td><input name="Fiveteen" id="Fiveteen" size="5" maxlength="5" value=""></td>
</tr>
<tr>
<td align="left">
速度设定:</td><td><input name="Sixteen" id="Sixteen" size="5" maxlength="5" value="00">
<input name="Seventeen" id="Seventeen" size="5" maxlength="5" value="20"></td>
</tr>

<tr>
<td align="left">
IP:</td><td><input name="ip" id="ip" size="15" maxlength="20" value="192.168.1.2">
<input name="port" id="port" size="5" maxlength="5" value="4001">
</td>
</tr>
<tr>
<td align="left">
命令:</td><td> <span id="crc8" name="crc8">&nbsp;&nbsp;</span>
</td>
</tr>
<tr>
<td colspan="2" align="center" >
<input type="button"  value="获取命令" onclick="getCrc8(this);"/>
<input type="button"  value="发送" onclick="myClickEvent(this)"/>
</td>
</tr>

</table> </body>
</html>
