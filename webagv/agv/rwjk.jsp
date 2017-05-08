<%@ page language="java"%>
<%--�������--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
	TaskQuene v = new TaskQuene();
	//Ĭ��ֵ����
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
<title>���</title>
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
	setTimeout('myrefresh()', 10000); //ָ��10��ˢ��һ��

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
				alert("�������ӳɹ�");
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
				alert("���ͳɹ�");
			}
		});
	}
	/**
	 *����ִ��������Գ��ֹ��ϵĳ�����������ˢ���������������
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
	 * ѡ��С��
	 */
	function xzxc(carid, flag) {
		if (flag == 0) {
			alert("�������������в��ܸ���С��");
		}
	}
	/**
	 * ɾ������
	 */
	function scrw(id) {
		$.ajax({
			type : "POST",
			url : "scrw.jsp",
			data : {
				taskid : id
			},
			success : function(data) {
				alert("ɾ���ɹ�");
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
				<font size="6px">AGV���ܿ���ϵͳ</font>
			</div>
		</div>
		<div
			data-options="region:'west',split:false,collapsible:false,title:'��������'"
			title="West" style="width:920px;">
			<table id="dg" class="easyui-datagrid"
				data-options="singleSelect:true,rownumbers: true"
				style="width:auto;height:auto;">
				<thead>
					<tr class="title_bgcolor">
						<th data-options="field:'id '" hidden="true"></th>
						<th data-options="field:'_taskid'" width="120">��������</th>
						<th data-options="field:'Name'" width="120">����������</th>
						<th data-options="field:'fhl'" width="80">��������T��</th>
						<th data-options="field:'EndTime'" width="110">���г���</th>
						<th data-options="field:'Qd'" width="50">�������</th>
						<th data-options="field:'Zd'" width="50">�����յ�</th>
						<th data-options="field:'StartTime'" width="160">��ʼִ��ʱ��</th>
						<th data-options="field:'EndFlag'" width="60">״̬</th>
						<th data-options="field:'_operate',width:130,align:'center'">����</th>
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
							%>������....<% } else if(pc.getRwzt().equals("3")){
							%>����ֹͣ<%}else if(pc.getRwzt().equals("4")){%>����<%}%></td>
						<td><% if(pc.getRwzt().equals("3")){
							%><a class="easyui-linkbutton l-btn" href="#"
							onclick="cxzx('<%=pc.getCarid()%>','<%=pc.getId()%>')">����</a>
						<%}%>
						
						<% if(pc.getRwzt().equals("4")||pc.getRwzt().equals("3")){
							%><a class="easyui-linkbutton l-btn" href="#"
							onclick="scrw('<%=pc.getId()%>')">ɾ��</a>
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
				<div title="<%=c.getName()%>(״̬��<% if(c.getIsuse()==0){
							%>���ã�<%} else if(c.getIsuse()==2){
							%>���ϣ�<%} %><% else {
							%>���ã�<%} %>������<%=c.getDcdy() %>�ٶȣ�<%=c.getSd() %>cm/s)"
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
						<tr><%=ta.getById(cp.getTaskid()).getName()%>:<%=cp.getYxtime()%> ����<% if(cp.getYxzt()==0){
							%>ʻ��<%=rf.getByUuid(cp.getZd()).getName()%>��<% }else if(cp.getYxzt()==1){%>ʻ��<%=rf.getByUuid(cp.getZd()).getName()%>��<%}else if(cp.getYxzt()==4){ %>��<%=rf.getByUuid(cp.getQd()).getName()%>����ֹ���<%}else {%>���н���<%}%>
								
							
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
