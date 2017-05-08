<%@ page language="java"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>

<%
int id = ParamUtils.getIntParameter(request, "id", 0);
Task task = new Task();
task = task.getById(id);
%>
<html>
<head>
<title>划分子任务</title>
<link rel="stylesheet" type="text/css"	href="<%=request.getContextPath()%>/images/default/web_oa.css">
<jsp:include page="/jqueryinc.jsp">
<jsp:param value="metro-blue" name="style" />
</jsp:include>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/My97DatePicker/WdatePicker.js"></script>
<script>
function save() {
	$("#form1").attr("target","self");
	$("#form1").on("submit", function(event) {
    	$.messager.progress({
        		title : "提示",
        		text : "请稍后...."
    	});
	});

	$("#form1").form({
			success : function(data) {
				$.messager.progress("close");
				var obj = eval("(" + data + ")");
				if (obj.success) {
					if (obj.success == "true") {
						$.messager.show({
							title : "提示",
							msg : "划分子任务成功！"
						});
						parent.$("#openDlgDiv").dialog("close");
					} else {
						$.messager.alert("Info", "划分子任务失败，任务出错！");
					}
				} else {
					$.messager.alert("Info", "划分子任务失败，请联系技术人员");
				}
			}
		});
		var isValid = $("#form1").form("validate");
		if (!isValid) {
			$.messager.alert("信息不完整", "请将信息填写完整后，再进行下一步");
			$.messager.progress("close");
		} else {
			$("#form1").submit();
			 parent.closet();	
		}
	}
</script>
<body>
<div id="form">
<form action="TaskAction.jsp?cmd=subtask" method="post" name="form1" id="form1">
<input type="hidden" name="cmd" value="subtask">
<input type="hidden" name="id" value="<%=id%>">
<table border="0" width="100%" cellspacing="0" >
<tr><td >
执行周期：</td>
<td >
<input name="Zxmonth" id="Zxmonth" size="3" style='height:20px;' maxlength="20"  value="">月
<input name="Zxday" id="Zxday" size="3" style='height:20px;' maxlength="20"  value="">天
<input name="Zxhour" id="Zxhour" size="3" style='height:20px;' maxlength="20"  value="">小时
</td>
</tr>
<tr><td >
执行频率：</td>
<td >
<input name="Zxpl" id="Zxpl" size="10" style='height:20px;' maxlength="20"  value="1">次
</td>
</tr>
<tr><td >
执行时间：</td>
<td >
<input name="Zxtime" id="Zxtime" size="20" style='height:20px;' maxlength="20" class="easyui-datetimebox" name="birthday"     
        data-options="required:true,showSeconds:false" value="<%=task.getStartTime()%>">
</td>
</tr>
<tr ><td  width="44%">
发货量：</td>
<td >
<input  class="easyui-textbox" id="Fhl"  name="Fhl"  value="<%=task.getFhl() %>"  data-options="required:true">
</td>
</tr>
<tr ><td  width="44%">
单位输送量：</td>
<td >
<input  class="easyui-textbox" id="dwssl"  name="dwssl"  value="<%=task.getDwssl() %>"   data-options="required:true">
</td>
</tr>
</table>
</form>
</div>
<div id="toolbar" >
<div style="text-align:center;padding:10px">
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="width:80px" onClick="save();">确定</a>
</div>
</div>
</body>
</html>