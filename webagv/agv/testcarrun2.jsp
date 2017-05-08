<%@ page language="java" %>
<%--任务队列--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%

TaskQuene v = new TaskQuene();

//默认值定义
UserInfo userInfo = null;

List cdt = new ArrayList();
cdt.clear();

cdt.add("length(code)=8");  
cdt.add("ORDER BY CODE"); 
cdt.add("PID=4"); 
List RfidNameoptions = (List)COptionConst.getRfidNameOptions(userInfo,"", cdt);
cdt.clear();
cdt.add("PID=2"); 
List CarNameoptions = (List)COptionConst.getCarNameOptions(userInfo,"", cdt);
%>
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
function addcar() {         
    $.ajax({
        type: "POST",
        url: "testcaradd.jsp",
        data: {carid:$("#Carid").val(),qd:$("#Qd").val(),zd:$("#Zd").val()},       
        success: function(data){
        	    alert("车辆连接成功");      
        }
    });	
}
function run() {         
           $.ajax({
               type: "POST",
               url: "testrun.jsp",
               data: {carid:$("#Carid").val(),qd:$("#Qd").val(),zd:$("#Zd").val()},       
               success: function(data){
               	       alert("发送成功");                 
                 }
           });	
}

</script>
</head>
<body >
<div class="easyui-layout" style="width:100%;height:98%;">
		<div data-options="region:'north',split:false" style="height:50px">
		<div align="center"><font size="6px">AGV智能控制系统</font></div>
		</div>		
		<div data-options="region:'east',split:false,collapsible:false,title:'',iconCls:'icon-save'" title="East" style="width:300px;">
		   <div class="easyui-accordion" data-options="multiple:true" style="width:auto;height: auto;">
		       <div title="任务执行"	data-options="iconCls:'icon-save',collapsed:false,collapsible:true"	style="overflow: auto; width: 100%; height: auto;">
		    	<div class="easyui-panel" title="" style="width:295px" >
	                <table border="0" width="100%" cellspacing="0">
	                <tr><td>
					<div align="right">小车:</div>
					</td><td class="td_value">
					<%=HtmlTool.renderSelect(CarNameoptions, "" + v.getCarid(), "Carid", "1")%>
					</td></tr>
			    	<tr><td>
					<div align="right">起点地址:</div>
					</td><td class="td_value">
					<%=HtmlTool.renderSelect(RfidNameoptions, "" + v.getQd(), "Qd", "")%>				
					</td></tr>
					<tr><td>
					<div align="right">终点地址:</div>
					</td><td>
					<%=HtmlTool.renderSelect(RfidNameoptions, "" + v.getZd(), "Zd", "")%>
					</td></tr>
					</table>
					<div align="center" style="display:">
					 <a href="#" class="easyui-linkbutton"   onClick="addcar();">连接小车</a>
					 <a href="#" class="easyui-linkbutton"   onClick="run();">任务运行</a>
					</div>
				</div>
			</div> 
			</div> 
			<div class="easyui-accordion" data-options="multiple:true" style="width:auto;height: auto;">
		       <div title="故障"	data-options="iconCls:'icon-save',collapsed:false,collapsible:true"	style="overflow: auto; width: 100%; height: auto;">
		    	<p>故障..</p>
			   </div>
			</div>
		</div>
		<div data-options="region:'west',split:false,collapsible:false,title:'任务',iconCls:'icon-save'" title="West" style="width:700px;">
		<table id="dg"  class="easyui-datagrid" data-options="singleSelect:true,rownumbers: true" style="width:695px;height:auto;"> 
				<thead>
					<tr>
						<th data-options="field:'Name'" width="100">任务</th>
						<th data-options="field:'Name'" width="100">子任务</th>
						<th data-options="field:'Qd'" width="70">子任务起点</th>
						<th data-options="field:'Zd'" width="70">子任务终点</th>
						<th data-options="field:'StartTime'" width="100">开始执行时间</th>
						<th data-options="field:'EndTime'" width="100">结束执行时间</th>
						<th data-options="field:'EndFlag'" width="60">是否完成</th>
					</tr>
				</thead>
				<tbody> 
<%
TaskQuene pc = new TaskQuene();
cdt.clear();
cdt.add("Rwzt=3");
List<TaskQuene>pcs = pc.query(cdt);
for(int j=0;j<pcs.size();j++)
{
	pc = pcs.get(j);
	%>	
<tr> 
<td  width="100"><%=pc.getName() %></td> 
<td  width="100"><%=pc.getName() %></td> 
<td  width="70"><%=pc.getQd() %></td> 
<td  width="70"><%=pc.getZd() %></td> 
<td  width="100"><%=pc.getStartTime() %></td> 
<td  width="100"><%=pc.getEndTime() %></td> 
<td  width="60"><%=pc.getEndFlag() %></td> 
</tr> 
<%}%>
             </tbody> 
			</table>
		</div>
		<div data-options="region:'center',title:'',iconCls:'icon-save'" >
		<%
Car c = new Car();
cdt.clear();
cdt.add("PID=2"); 
List<Car>cs = c.query(cdt);
for(int j=0;j<cs.size();j++)
{
	c = cs.get(j);
	%>	
			<div class="easyui-accordion" data-options="multiple:true" style="width:auto;height: auto;">
		       <div title="<%=c.getName() %>"	data-options="iconCls:'icon-save',collapsed:false,collapsible:true"	style="overflow: auto; width: 100%; height: auto;">
		    	<p><%=c.getName() %>...</p>
			   </div>
			</div>
<%} %>

		</div>
	</div>

</body>
</html>
