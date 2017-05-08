<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@page import="com.alibaba.fastjson.JSON" %>
<%!
private static Log log = LogFactory.getLog(Tool.class);
%>
<%
log.debug("ListJquery");
StringBuffer str = new StringBuffer();
String keyfield = (String)request.getAttribute("keyfield");
String[] dickeys = (String[])request.getAttribute("dickeys");
String[][] dicvalues = (String[][])request.getAttribute("dicvalues");
String[] fields = (String[])request.getAttribute("fields");
String OperateField = (String)request.getAttribute("OperateField");
List diclist = new ArrayList();
for (int i = 0; i < dickeys.length; i ++) {
    diclist.add("\"" + dickeys[i] + "\": [\"" + Tool.join("\", \"", dicvalues[i]) + "\"]");
}
int currpage = ParamUtils.getIntParameter(request, "page", 1);
Map extMaps = (Map)request.getAttribute("Ext");
List paras = HttpTool.getSavedUrlForm(request, "Ext");
List urls = (List)paras.get(0);
List forms = (List)paras.get(1);
urls.addAll((List)paras.get(2));
String url = Tool.join("&", urls);
PageControl pc = (PageControl)request.getAttribute("PageControl");
//默认值定义
List RfidNameoptions = (List)request.getAttribute("RfidNameoptions");
%>
<html>
<head>
<title> <%=request.getAttribute("describe")%> </title>
<jsp:include page="/jqueryinc.jsp">
<jsp:param value="metro-blue" name="style"/>
</jsp:include>
<script type="text/javascript">
var keyfield = "<%=keyfield%>";
var OperateField = "<%=OperateField%>";
var datagrid;
var editRow = undefined;
$(function () {
    $("#dlg").dialog("close");
    initData();
});
 function initData(){
    datagrid = $("#dadagrid").datagrid({
            url: 'TaskAction.jsp?cmd=json',
            iconCls: 'icon-save',
            pagination: true,
        	 rownumbers: true,
            pageSize: <%=pc.getShownum()%>,
            pageList: [<%=pc.getShownum()%>, <%=pc.getShownum()*2%>, <%=pc.getShownum()*3%>, <%=pc.getShownum()*4%>],
            fit: true,
            fitColumn: false,
            striped: true,
            nowap: true, 
            border: false,
            idField: keyfield,
            columns: [[ 
        <%
        List rows = new ArrayList();
        for(int i=0;i<fields.length;i++){
            	int listFieldIndex = 0;
            	for(int j=0;j<dickeys.length;j++)
            	{
                		if(dickeys[j]==fields[i])
                		{
                    			listFieldIndex = j;
                    			break;
                		}
            	}
            	Map map = new HashMap();
            	map.put("field",dickeys[listFieldIndex]+"");
            	map.put("title",dicvalues[listFieldIndex][1]+"");
            	map.put("sortable","true");
            	map.put("halign","center");
            	if(dickeys[listFieldIndex].equals(keyfield))
            	{
                		map.put("checkbox","true");
            	}
            	rows.add(JSON.toJSONString(map));
        }
        out.print(Tool.join(",\r\n",rows));%>
        ,{
            title:"操作",
            field:"<%=OperateField%>",
            halign:"center",
            align:"center",
            formatter : function(value, rowData, rowIndex) {
                	var keyid = eval("rowData."+keyfield);
                	return '<input type="button"  value="修改" onclick="modifyFun(\''+ keyid +'\')"></button>';
             		  },
            width:80
        }
        ]],
        queryParams : sy.serializeObject($("#Task_queryForm").form()),
        	toolbar : '#toolbar',
        	onDblClickRow :onClickRow
    })
}
//$('.datagrid-header div').css("textAlign","center");
 function reloadData(){
    	$("#dadagrid").datagrid("load");
}
//查询
function searchFun()
{
    	$("#dadagrid").datagrid("load",sy.serializeObject($("#Task_queryForm").form()));
}
//点击清空按钮出发事件
function clearSearch() {
    	$("#dadagrid").datagrid("load", {});//重新加载数据，无填写数据，向后台传递值则为空
    	$("#Task_queryForm").find("input").val("");//找到form表单下的所有input标签并清空
}
//添加
function addFun() {
    	$("#openDlgIframe")[0].src="<%=request.getAttribute("classname")%>Action.jsp?cmd=jqueryCreate";
    	$("#openDlgDiv").dialog("open");
}
//修改
function modifyFun(id) {
    	$("#openDlgIframe")[0].src="<%=request.getAttribute("classname")%>Action.jsp?cmd=jqueryModify&"+keyfield+"="+id;
    	$("#openDlgDiv").dialog("open");
}
//删除
function delFun() {
    	var rows = $("#dadagrid").datagrid("getChecked");
    	var ids = [];
    	if (rows.length > 0 ) {
        		$.messager.confirm("确认", "您是否要删除当前选中的记录？", function(r) {
            		if (r) {
                			$.messager.progress({
                    			title : "提示",
                    			text : "数据处理中，请稍后...."
                	});
                	for ( var i = 0; i < rows.length; i++) {
                    			ids.push(rows[i].Id);
                	}
                	$.getJSON("<%=request.getAttribute("classname")%>Action.jsp?cmd=jqueryDeletelist", {
                    		idlist : ids.join(",")
                    	}, function(result) {
                    		if (result.success) {
                        			reloadData();
                    		}
                    		if(result.msg && result.msg.length>0)
                    			{
                        				$.messager.alert("提示", result.msg, "info");
                    			}
                    			$.messager.progress("close");
                		});
            	}
        	});
    	}else
    	{
        		$.messager.alert("提示", "请选择记录后再进行删除操作", "info");
    	}
}
</script>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true" title="" style="">
<table id="dadagrid">
</table>
<div id="toolbar" style="display: none;">
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="width:80px" onClick="addFun();">添加</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-no'" style="width:80px" onClick="delFun();">删除</a>
</div>
<div id="menu" class="easyui-menu" style="width:120px;display:none;">
<div onClick="" iconCls="icon-add">增加</div>
<div onClick="" iconCls="icon-remove">删除</div>
<div onClick="" iconCls="icon-edit">修改</div>
</div>
<div id="dlg" class="easyui-dialog" title="添加/修改" data-options="iconCls:'icon-save'" style="width:800px;height:500px;padding:10px">
</div>
<div id="openDlgDiv" class="easyui-window" closed="true" modal="true" title="添加/修改" style="width:800px;height:550px;overflow:hidden">
	<iframe scrolling="auto" id="openDlgIframe" frameborder="0"  src="" style="width:100%;height:99%;"></iframe>
</div>
</div>
<div data-options="region:'north',split:true" title="查询" style="height: 110px; overflow: auto;">
<form id="Task_queryForm" name="Task_queryForm" method="post">
<table border="0" width="100%" cellspacing="0" id="searchTable" class="tableForm datagrid-toolbar">
<input type="hidden" name="cmd" id="cmd" value="listjquery">
<%=Tool.join("\n", forms)%>
<td>
<div align="right">名称</div>
</td><td>
<input name="_Name_" id="_Name_"value="<%=ParamUtils.getParameter(request, "_Name_", "")%>">
</td>
<input type="hidden" name="_Carid_" id="_Carid_" value="<%=ParamUtils.getParameter(request, "_Carid_", "")%>">
<td>
<div align="right">速度</div>
</td><td>
<input name="_Sd_" id="_Sd_"value="<%=ParamUtils.getParameter(request, "_Sd_", "")%>">
</td>
<input type="hidden" name="_Pathid_" id="_Pathid_" value="<%=ParamUtils.getParameter(request, "_Pathid_", "")%>">
<td>
<div align="right">优先级</div>
</td><td>
<input name="_Yxj_" id="_Yxj_"value="<%=ParamUtils.getParameter(request, "_Yxj_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">任务状态</div>
</td><td>
<input name="_Rwzt_" id="_Rwzt_"value="<%=ParamUtils.getParameter(request, "_Rwzt_", "")%>">
</td>
<td>
<div align="right">起点地址</div>
</td><td>
<input name="_Qd_" id="_Qd_"value="<%=ParamUtils.getParameter(request, "_Qd_", "")%>">
</td>
<td>
<div align="right">终点地址</div>
</td><td>
<input name="_Zd_" id="_Zd_"value="<%=ParamUtils.getParameter(request, "_Zd_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">起点RFID</div>
</td><td>
<%=HtmlTool.renderSelect(RfidNameoptions, ParamUtils.getParameter(request,"_QdId_",""), "_QdId_", "")%>
<%//radio形式%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, ParamUtils.getParameter(request,"_QdId_",""), "_QdId_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, ParamUtils.getParameter(request,"_QdId_",""), "_QdId_", "")%>
</td>
<td>
<div align="right">终点RFID</div>
</td><td>
<%=HtmlTool.renderSelect(RfidNameoptions, ParamUtils.getParameter(request,"_ZdId_",""), "_ZdId_", "")%>
<%//radio形式%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, ParamUtils.getParameter(request,"_ZdId_",""), "_ZdId_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, ParamUtils.getParameter(request,"_ZdId_",""), "_ZdId_", "")%>
</td>
<input type="hidden" name="_Commands_" id="_Commands_" value="<%=ParamUtils.getParameter(request, "_Commands_", "")%>">
<td>
<div align="right">命令代码</div>
</td><td>
<input name="_ComandsCode_" id="_ComandsCode_"value="<%=ParamUtils.getParameter(request, "_ComandsCode_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">当前点</div>
</td><td>
<input name="_Currfid_" id="_Currfid_"value="<%=ParamUtils.getParameter(request, "_Currfid_", "")%>">
</td>
<td>
<div align="right">路径长度</div>
</td><td>
<input name="_Length_" id="_Length_"value="<%=ParamUtils.getParameter(request, "_Length_", "")%>">
</td>
<td>
<div align="right">权重</div>
</td><td>
<input name="_Weigh_" id="_Weigh_"value="<%=ParamUtils.getParameter(request, "_Weigh_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">可用标志</div>
</td><td>
<input name="_Kybz_" id="_Kybz_"value="<%=ParamUtils.getParameter(request, "_Kybz_", "")%>">
</td>
<td>
<div align="right">货物种类</div>
</td><td>
<input name="_Hwzl_" id="_Hwzl_"value="<%=ParamUtils.getParameter(request, "_Hwzl_", "")%>">
</td>
<td>
<div align="right">货物编码</div>
</td><td>
<input name="_Hwbm_" id="_Hwbm_"value="<%=ParamUtils.getParameter(request, "_Hwbm_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">货物名称</div>
</td><td>
<input name="_Hwmc_" id="_Hwmc_"value="<%=ParamUtils.getParameter(request, "_Hwmc_", "")%>">
</td>
<td>
<div align="right">货物RFID</div>
</td><td>
<input name="_Hwrfid_" id="_Hwrfid_"value="<%=ParamUtils.getParameter(request, "_Hwrfid_", "")%>">
</td>
<td>
<div align="right">货物数量</div>
</td><td>
<input name="_Hwsl_" id="_Hwsl_"value="<%=ParamUtils.getParameter(request, "_Hwsl_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">单位输送量</div>
</td><td>
<input name="_Dwssl_" id="_Dwssl_"value="<%=ParamUtils.getParameter(request, "_Dwssl_", "")%>">
</td>
<td>
<div align="right">发货量</div>
</td><td>
<input name="_Fhl_" id="_Fhl_"value="<%=ParamUtils.getParameter(request, "_Fhl_", "")%>">
</td>
<td>
<div align="right">创建时间</div>
</td><td>
<input name="_CreateTime_" id="_CreateTime_"value="<%=ParamUtils.getParameter(request, "_CreateTime_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">下发时间</div>
</td><td>
<input name="_XfTime_" id="_XfTime_"value="<%=ParamUtils.getParameter(request, "_XfTime_", "")%>">
</td>
<td>
<div align="right">用户执行时间 </div>
</td><td>
<input name="_StartTime_" id="_StartTime_"value="<%=ParamUtils.getParameter(request, "_StartTime_", "")%>">
</td>
<td>
<div align="right">执行完成时间</div>
</td><td>
<input name="_EndTime_" id="_EndTime_"value="<%=ParamUtils.getParameter(request, "_EndTime_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">任务类型</div>
</td><td>
<input name="_Type_" id="_Type_"value="<%=ParamUtils.getParameter(request, "_Type_", "")%>">
</td>
<td>
<div align="right">是否结束</div>
</td><td>
<input name="_Endflag_" id="_Endflag_"value="<%=ParamUtils.getParameter(request, "_Endflag_", "")%>">
</td>
<td>
<div align="right">用户编号</div>
</td><td>
<input name="_Userid_" id="_Userid_"value="<%=ParamUtils.getParameter(request, "_Userid_", "")%>">
</td>
</tr><tr><td colspan="8" align="center">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px" onclick="searchFun()">查询</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:80px"  onclick="clearSearch()">清空</a>
</td></tr></table>
	</form>
</div>
</body>
</html>
