<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
String taskid = ParamUtils.getParameter(request, "taskid", "");
%>
<html>
<head>
<title>车列表</title>
 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/default/web_oa.css"> 

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.4/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.4/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/demo/demo.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.4/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/syUtil.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>

<script type="text/javascript">
function selectAll(cbx)
{
	 var chks = document.getElementsByName("chk1");
    for (var i = 0; i < chks.length; i ++) {   //当前页面上有多条记录时
        chks[i].checked = cbx.checked;
    }
}
var taskid = <%=taskid%>;
function selectok(){
	var chks = document.getElementsByName("chk1");    
    var chkeds = new Array();
    for (var i = 0; i < chks.length; i ++) {  //当前页面上有多条记录时
    if (chks[i].checked == true) {
      chkeds.push(chks[i].value);
    }
  }
    if(chkeds.length==1){ 
	     document.getElementById("idlist").value = chkeds.join(','); 
	     document.getElementById("taskid").value =  <%=taskid%>; 
		 tijiaoform.method="post";
         tijiaoform.target="_self";
         tijiaoform.url="TaskQueneAction.jsp?cmd=updatecar";
         
		 tijiaoform.submit();
		 parent.closet();	  
	  }else if(chkeds.length>1){
			alert("只能选择一台小车！");
			return;
		}else{
			alert("请选择一台小车！");
			return;
		}
}
</script>
</head>
<body>
<div id="toolbar" style="padding:1px;">
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'"  onClick="selectok();">选择</a>
</div>
<form method="post" name="form" id="form">
<table border="0" width="100%" cellspacing="0" >
<tr class="title_bgcolor">
<td  align="center" width="10px"><input type="checkbox" onclick="selectAll(this);" /></td>
<td align="center" width="40px">序号</td>
<td align="center" width="140px">名称</td>
<td align="center" width="140px">位置</td>
<td align="center" width="140px">距离</td>
</tr>
<%Car p = new Car();
List cdt = new ArrayList();
cdt.clear();
cdt.add("pid=2");
List<Car>ps = p.query(cdt);
for(int i=0;i<ps.size();i++)
{p = ps.get(i);
%>

	<tr >
	<td  align="center"><input type="checkbox" name="chk1" value="<%=p.getId() %>" /></td>
	<td  align="center"><%=(i+1) %></td>
	<td  align="center"><%=p.getName() %></td>
	<td  align="center"><%=p.getName() %></td>
	<td  align="center"><%=p.getName() %></td>
	</tr>
<%} %>
</table>
</form>

<form action="TaskQueneAction.jsp?cmd=updatecar" method="post" name="tijiaoform" id="tijiaoform" >
<input name="idlist" id="idlist"  size="15" type="hidden" value="">
<input name="taskid" id="taskid"  size="15" type="hidden" value="">
</form>
</body>
</html>
