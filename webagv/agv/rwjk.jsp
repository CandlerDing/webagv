<%@ page language="java"%>
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
	List<Car> CarNameoptions = (List<Car>)COptionConst.getCarNameOptions(userInfo,"", cdt);
%>
<html>
<head>
<title>监控</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/images/default/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript"
	src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
<script type="text/JavaScript"
	src="<%=request.getContextPath()%>/js/listfunction.js"></script>
<link id="easyuiTheme" rel="stylesheet"
	href="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/themes/default/easyui.css"
	type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/themes/icon.css"
	type="text/css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/jquery.easyui.min.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"
	charset="utf-8"></script>
<script type="text/JavaScript"
	src="<%=request.getContextPath()%>/js/formfunction.js"></script>
<script type="text/JavaScript">
 	function myrefresh() {
		window.location.reload();
	}
	setTimeout('myrefresh()', 10000); //指定10秒刷新一次

	function addcar() {
		$.ajax({
			type : "POST",
			url : "testcaradd.jsp",
			data : {
				carid : $("#Carid").val(),
				qd : $("#Qd").val(),
				zd : $("#Zd").val()
			},
			success : function(data) {
				alert("车辆连接成功");
			}
		});
	}
	function run() {
		$.ajax({
			type : "POST",
			url : "testrun.jsp",
			data : {
				carid : $("#Carid").val(),
				qd : $("#Qd").val(),
				zd : $("#Zd").val()
			},
			success : function(data) {
				alert("发送成功");
			}
		});
	}
	/**
	 *重新执行任务：针对出现故障的车辆；或者是刷错卡的情况进行重新
	 */
	function cxzx(car, taskid) {
		$.ajax({
			type : "POST",
			url : "cxzx.jsp",
			data : {
				carid : car,
				taskid : taskid
			},
			success : function(data) {
				alert(data);
			}
		});
	}
	/**
	 * 选择小车
	 */
	function xzxc(carid, flag) {
		if (flag == 0) {
			alert("车辆正常运行中不能跟换小车");
		}
	}
	/**
	 * 删除任务
	 */
	function scrw(id) {
		$.ajax({
			type : "POST",
			url : "scrw.jsp",
			data : {
				taskid : id
			},
			success : function(data) {
				alert("删除成功");
				location.reload();
			}
		});
	}
</script>
</head>
<body>
	<div class="easyui-layout" style="width:100%;height:98%;">
		<div data-options="region:'north',split:false" style="height:50px">
			<div align="center">
				<font size="6px">AGV智能控制系统</font>
			</div>
		</div>
		<div
			data-options="region:'west',split:false,collapsible:false,title:'运行任务'"
			title="West" style="width:920px;">
			<table id="dg" class="easyui-datagrid"
				data-options="singleSelect:true,rownumbers: true"
				style="width:auto;height:auto;">
				<thead>
					<tr class="title_bgcolor">
						<th data-options="field:'id '" hidden="true"></th>
						<th data-options="field:'_taskid'" width="120">任务名称</th>
						<th data-options="field:'Name'" width="120">子任务名称</th>
						<th data-options="field:'fhl'" width="80">发货量（T）</th>
						<th data-options="field:'EndTime'" width="110">运行车辆</th>
						<th data-options="field:'Qd'" width="50">任务起点</th>
						<th data-options="field:'Zd'" width="50">任务终点</th>
						<th data-options="field:'StartTime'" width="160">开始执行时间</th>
						<th data-options="field:'EndFlag'" width="60">状态</th>
						<th data-options="field:'_operate',width:130,align:'center'">操作</th>
					</tr>
				</thead>
				<tbody>
					<%
						TaskQuene pc = new TaskQuene();
						cdt.clear();
						cdt.add("Rwzt!=0");
						List<TaskQuene> pcs = pc.query(cdt);

						for (int j = 0; j < pcs.size(); j++) {
							pc = pcs.get(j);
							Task t = new Task();
							t.getById(pc.getTaskId());
							Car car = new Car();
							Rfid r = new Rfid();
							Car p = new Car();
					%>
					<tr class="data_bgcolor_even">
						<td hidden="true"><%=pc.getId()%></td>
						<td width="120"><%=t.getById(pc.getTaskId()).getName()%></td>
						<td width="120"><%=pc.getName()%></td>
						<td width="80"><%=pc.getFhl()%></td>

						<td width="110"><%=p.getById(pc.getCarid()).getName()%></td>
						<td width="50"><%=pc.getQd()%></td>
						<td width="50"><%=pc.getZd()%></td>
						<td width="160"><%=pc.getStartTime()%></td>
						<td width="90"><% if(pc.getRwzt().equals("1")){
							%>运行中....<% } else if(pc.getRwzt().equals("3")){
							%>故障停止<%}else if(pc.getRwzt().equals("4")){%>结束<%}%></td>
						<td><% if(pc.getRwzt().equals("3")){
							%><a class="easyui-linkbutton l-btn" href="#"
							onclick="cxzx('<%=pc.getCarid()%>','<%=pc.getId()%>')">重启</a>
						<%}%>
						
						<% if(pc.getRwzt().equals("4")||pc.getRwzt().equals("3")){
							%><a class="easyui-linkbutton l-btn" href="#"
							onclick="scrw('<%=pc.getId()%>')">删除</a>
						<%}%>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<div data-options="region:'center',title:'',iconCls:'icon-save'">
			<%
				Car c = new Car();
				cdt.clear();
				cdt.add("PID=2");
				List<Car> cs = c.query(cdt);
				for (int j = 0; j < cs.size(); j++) {
					c = cs.get(j);
			%>
			<div class="easyui-accordion" data-options="multiple:true"
				style="width:auto;height: auto;">
				<div title="<%=c.getName()%>(状态：<% if(c.getIsuse()==0){
							%>空置；<%} else if(c.getIsuse()==2){
							%>故障；<%} %><% else {
							%>在用；<%} %>电量：<%=c.getDcdy() %>速度：<%=c.getSd() %>cm/s)"
					data-options="collapsed:false,collapsible:true"
					style="overflow: auto; width: 100%; height: auto;">
					<table>
						<%
							List cdts = new ArrayList();
								CarPath cp = new CarPath();
								cdts.clear();
								cdts.add("Carid=" + c.getId());
								cdts.add("order by id desc");
								List<CarPath> cps = cp.query(cdts);
								for (int k = 0; k < cps.size(); k++) {
									cp = cps.get(k);
									TaskQuene ta = new TaskQuene();
									Rfid rf=new Rfid();
									
						%>
						<tr><%=ta.getById(cp.getTaskid()).getName()%>:<%=cp.getYxtime()%> 车辆<% if(cp.getYxzt()==0){
							%>驶入<%=rf.getByUuid(cp.getZd()).getName()%>点<% }else if(cp.getYxzt()==1){%>驶出<%=rf.getByUuid(cp.getZd()).getName()%>点<%}else if(cp.getYxzt()==4){ %>在<%=rf.getByUuid(cp.getQd()).getName()%>点出现故障<%}else {%>运行结束<%}%>
								
							
						</tr>
						</br>
						<%
							}
						%>
					</table>
				</div>
			</div>
			<%
				}
			%>

		</div>
	</div>
</body>
</html>
