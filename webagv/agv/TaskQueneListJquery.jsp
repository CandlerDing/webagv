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
//Ĭ��ֵ����
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
            url: 'TaskQueneAction.jsp?cmd=json',
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
            title:"����",
            field:"<%=OperateField%>",
            halign:"center",
            align:"center",
            formatter : function(value, rowData, rowIndex) {
                	var keyid = eval("rowData."+keyfield);
                	return '<input type="button"  value="�޸�" onclick="modifyFun(\''+ keyid +'\')"></button>';
             		  },
            width:80
        }
        ]],
        queryParams : sy.serializeObject($("#TaskQuene_queryForm").form()),
        	toolbar : '#toolbar',
        	onDblClickRow :onClickRow
    })
}
//$('.datagrid-header div').css("textAlign","center");
 function reloadData(){
    	$("#dadagrid").datagrid("load");
}
//��ѯ
function searchFun()
{
    	$("#dadagrid").datagrid("load",sy.serializeObject($("#TaskQuene_queryForm").form()));
}
//�����հ�ť�����¼�
function clearSearch() {
    	$("#dadagrid").datagrid("load", {});//���¼������ݣ�����д���ݣ����̨����ֵ��Ϊ��
    	$("#TaskQuene_queryForm").find("input").val("");//�ҵ�form���µ�����input��ǩ�����
}
//���
function addFun() {
    	$("#openDlgIframe")[0].src="<%=request.getAttribute("classname")%>Action.jsp?cmd=jqueryCreate";
    	$("#openDlgDiv").dialog("open");
}
//�޸�
function modifyFun(id) {
    	$("#openDlgIframe")[0].src="<%=request.getAttribute("classname")%>Action.jsp?cmd=jqueryModify&"+keyfield+"="+id;
    	$("#openDlgDiv").dialog("open");
}
//ɾ��
function delFun() {
    	var rows = $("#dadagrid").datagrid("getChecked");
    	var ids = [];
    	if (rows.length > 0 ) {
        		$.messager.confirm("ȷ��", "���Ƿ�Ҫɾ����ǰѡ�еļ�¼��", function(r) {
            		if (r) {
                			$.messager.progress({
                    			title : "��ʾ",
                    			text : "���ݴ����У����Ժ�...."
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
                        				$.messager.alert("��ʾ", result.msg, "info");
                    			}
                    			$.messager.progress("close");
                		});
            	}
        	});
    	}else
    	{
        		$.messager.alert("��ʾ", "��ѡ���¼���ٽ���ɾ������", "info");
    	}
}
</script>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true" title="" style="">
<table id="dadagrid">
</table>
<div id="toolbar" style="display: none;">
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="width:80px" onClick="addFun();">���</a>
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-no'" style="width:80px" onClick="delFun();">ɾ��</a>
</div>
<div id="menu" class="easyui-menu" style="width:120px;display:none;">
<div onClick="" iconCls="icon-add">����</div>
<div onClick="" iconCls="icon-remove">ɾ��</div>
<div onClick="" iconCls="icon-edit">�޸�</div>
</div>
<div id="dlg" class="easyui-dialog" title="���/�޸�" data-options="iconCls:'icon-save'" style="width:800px;height:500px;padding:10px">
</div>
<div id="openDlgDiv" class="easyui-window" closed="true" modal="true" title="���/�޸�" style="width:800px;height:550px;overflow:hidden">
	<iframe scrolling="auto" id="openDlgIframe" frameborder="0"  src="" style="width:100%;height:99%;"></iframe>
</div>
</div>
<div data-options="region:'north',split:true" title="��ѯ" style="height: 110px; overflow: auto;">
<form id="TaskQuene_queryForm" name="TaskQuene_queryForm" method="post">
<table border="0" width="100%" cellspacing="0" id="searchTable" class="tableForm datagrid-toolbar">
<input type="hidden" name="cmd" id="cmd" value="listjquery">
<%=Tool.join("\n", forms)%>
<td>
<div align="right">����</div>
</td><td>
<input name="_Name_" id="_Name_"value="<%=ParamUtils.getParameter(request, "_Name_", "")%>">
</td>
<input type="hidden" name="_Carid_" id="_Carid_" value="<%=ParamUtils.getParameter(request, "_Carid_", "")%>">
<td>
<div align="right">���ȼ�</div>
</td><td>
<input name="_Yxj_" id="_Yxj_"value="<%=ParamUtils.getParameter(request, "_Yxj_", "")%>">
</td>
<td>
<div align="right">����״̬0δ����1������2ִ����</div>
</td><td>
<input name="_Rwzt_" id="_Rwzt_"value="<%=ParamUtils.getParameter(request, "_Rwzt_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">����ַ</div>
</td><td>
<input name="_Qd_" id="_Qd_"value="<%=ParamUtils.getParameter(request, "_Qd_", "")%>">
</td>
<td>
<div align="right">�յ��ַ</div>
</td><td>
<input name="_Zd_" id="_Zd_"value="<%=ParamUtils.getParameter(request, "_Zd_", "")%>">
</td>
<input type="hidden" name="_QdId_" id="_QdId_" value="<%=ParamUtils.getParameter(request, "_QdId_", "")%>">
<input type="hidden" name="_ZdId_" id="_ZdId_" value="<%=ParamUtils.getParameter(request, "_ZdId_", "")%>">
<td>
<div align="right">�Ƿ����1������2������3ִ����</div>
</td><td>
<input name="_EndFlag_" id="_EndFlag_"value="<%=ParamUtils.getParameter(request, "_EndFlag_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">���ñ�־</div>
</td><td>
<input name="_Kybz_" id="_Kybz_"value="<%=ParamUtils.getParameter(request, "_Kybz_", "")%>">
</td>
<td>
<div align="right">��������</div>
</td><td>
<input name="_Hwzl_" id="_Hwzl_"value="<%=ParamUtils.getParameter(request, "_Hwzl_", "")%>">
</td>
<td>
<div align="right">�������</div>
</td><td>
<input name="_Hwbm_" id="_Hwbm_"value="<%=ParamUtils.getParameter(request, "_Hwbm_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��������</div>
</td><td>
<input name="_Hwmc_" id="_Hwmc_"value="<%=ParamUtils.getParameter(request, "_Hwmc_", "")%>">
</td>
<td>
<div align="right">����RFID</div>
</td><td>
<input name="_Hwrfid_" id="_Hwrfid_"value="<%=ParamUtils.getParameter(request, "_Hwrfid_", "")%>">
</td>
<td>
<div align="right">������</div>
</td><td>
<input name="_Fhl_" id="_Fhl_"value="<%=ParamUtils.getParameter(request, "_Fhl_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">����ʱ��</div>
</td><td>
<input name="_CreateTime_" id="_CreateTime_"value="<%=ParamUtils.getParameter(request, "_CreateTime_", "")%>">
</td>
<td>
<div align="right">�·�ʱ��</div>
</td><td>
<input name="_XfTime_" id="_XfTime_"value="<%=ParamUtils.getParameter(request, "_XfTime_", "")%>">
</td>
<td>
<div align="right">ִ��ʱ�� </div>
</td><td>
<input name="_StartTime_" id="_StartTime_"value="<%=ParamUtils.getParameter(request, "_StartTime_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">ִ�����ʱ��</div>
</td><td>
<input name="_EndTime_" id="_EndTime_"value="<%=ParamUtils.getParameter(request, "_EndTime_", "")%>">
</td>
<td>
<div align="right">��������0��Ч1�˻�2���3ά��</div>
</td><td>
<input name="_Type_" id="_Type_"value="<%=ParamUtils.getParameter(request, "_Type_", "")%>">
</td>
<td>
<div align="right">�û����</div>
</td><td>
<input name="_Userid_" id="_Userid_"value="<%=ParamUtils.getParameter(request, "_Userid_", "")%>">
</td>
</tr><tr><td colspan="8" align="center">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px" onclick="searchFun()">��ѯ</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:80px"  onclick="clearSearch()">���</a>
</td></tr></table>
	</form>
</div>
</body>
</html>
