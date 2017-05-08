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
List YesNooptions = (List)request.getAttribute("YesNooptions");
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
            url: 'CarAction.jsp?cmd=json',
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
        queryParams : sy.serializeObject($("#Car_queryForm").form()),
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
    	$("#dadagrid").datagrid("load",sy.serializeObject($("#Car_queryForm").form()));
}
//�����հ�ť�����¼�
function clearSearch() {
    	$("#dadagrid").datagrid("load", {});//���¼������ݣ�����д���ݣ����̨����ֵ��Ϊ��
    	$("#Car_queryForm").find("input").val("");//�ҵ�form���µ�����input��ǩ�����
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
<form id="Car_queryForm" name="Car_queryForm" method="post">
<table border="0" width="100%" cellspacing="0" id="searchTable" class="tableForm datagrid-toolbar">
<input type="hidden" name="cmd" id="cmd" value="listjquery">
<%=Tool.join("\n", forms)%>
<td>
<div align="right">����</div>
</td><td>
<input name="_Name_" id="_Name_"value="<%=ParamUtils.getParameter(request, "_Name_", "")%>">
</td>
<td>
<div align="right">����</div>
</td><td>
<input name="_Jd_" id="_Jd_"value="<%=ParamUtils.getParameter(request, "_Jd_", "")%>">
</td>
<td>
<div align="right">��ص�ѹ</div>
</td><td>
<input name="_Dcdy_" id="_Dcdy_"value="<%=ParamUtils.getParameter(request, "_Dcdy_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">���ֱ���ٶ�</div>
</td><td>
<input name="_Zxsd_" id="_Zxsd_"value="<%=ParamUtils.getParameter(request, "_Zxsd_", "")%>">
</td>
<td>
<div align="right">�������ٶ�</div>
</td><td>
<input name="_Gwsd_" id="_Gwsd_"value="<%=ParamUtils.getParameter(request, "_Gwsd_", "")%>">
</td>
<td>
<div align="right">���ٶ�</div>
</td><td>
<input name="_Jiasd_" id="_Jiasd_"value="<%=ParamUtils.getParameter(request, "_Jiasd_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">���ٶ�</div>
</td><td>
<input name="_Jiansd_" id="_Jiansd_"value="<%=ParamUtils.getParameter(request, "_Jiansd_", "")%>">
</td>
<td>
<div align="right">���Ϸ�ʽ</div>
</td><td>
<input name="_Slfs_" id="_Slfs_"value="<%=ParamUtils.getParameter(request, "_Slfs_", "")%>">
</td>
<td>
<div align="right">�ٶ�</div>
</td><td>
<input name="_Sd_" id="_Sd_"value="<%=ParamUtils.getParameter(request, "_Sd_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">������ʽ</div>
</td><td>
<input name="_Dyfs_" id="_Dyfs_"value="<%=ParamUtils.getParameter(request, "_Dyfs_", "")%>">
</td>
<td>
<div align="right">���γߴ�</div>
</td><td>
<input name="_Wxcc_" id="_Wxcc_"value="<%=ParamUtils.getParameter(request, "_Wxcc_", "")%>">
</td>
<td>
<div align="right">����</div>
</td><td>
<input name="_Fz_" id="_Fz_"value="<%=ParamUtils.getParameter(request, "_Fz_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��λ����</div>
</td><td>
<input name="_Dwjd_" id="_Dwjd_"value="<%=ParamUtils.getParameter(request, "_Dwjd_", "")%>">
</td>
<td>
<div align="right">������ʽ</div>
</td><td>
<input name="_Qdxs_" id="_Qdxs_"value="<%=ParamUtils.getParameter(request, "_Qdxs_", "")%>">
</td>
<td>
<div align="right">��������ʱ��</div>
</td><td>
<input name="_Lxtime_" id="_Lxtime_"value="<%=ParamUtils.getParameter(request, "_Lxtime_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��緽ʽ</div>
</td><td>
<input name="_Cdfs_" id="_Cdfs_"value="<%=ParamUtils.getParameter(request, "_Cdfs_", "")%>">
</td>
<td>
<div align="right">��Сת��뾶</div>
</td><td>
<input name="_Zwlj_" id="_Zwlj_"value="<%=ParamUtils.getParameter(request, "_Zwlj_", "")%>">
</td>
<td>
<div align="right">��ȫ��Ӧ��Χ</div>
</td><td>
<input name="_Aqgyfw_" id="_Aqgyfw_"value="<%=ParamUtils.getParameter(request, "_Aqgyfw_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">·��ʶ��</div>
</td><td>
<input name="_Ljsb_" id="_Ljsb_"value="<%=ParamUtils.getParameter(request, "_Ljsb_", "")%>">
</td>
<td>
<div align="right">������ʾ</div>
</td><td>
<input name="_Xzts_" id="_Xzts_"value="<%=ParamUtils.getParameter(request, "_Xzts_", "")%>">
</td>
<td>
<div align="right">���ϱ���</div>
</td><td>
<input name="_Gzbj_" id="_Gzbj_"value="<%=ParamUtils.getParameter(request, "_Gzbj_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��ȫ����</div>
</td><td>
<input name="_Aqfh_" id="_Aqfh_"value="<%=ParamUtils.getParameter(request, "_Aqfh_", "")%>">
</td>
<td>
<div align="right">�����</div>
</td><td>
<input name="_Zdfz_" id="_Zdfz_"value="<%=ParamUtils.getParameter(request, "_Zdfz_", "")%>">
</td>
<td>
<div align="right">���ֱ���г�</div>
</td><td>
<input name="_Zdzxxc_" id="_Zdzxxc_"value="<%=ParamUtils.getParameter(request, "_Zdzxxc_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��س���ѹ</div>
</td><td>
<input name="_Cddy_" id="_Cddy_"value="<%=ParamUtils.getParameter(request, "_Cddy_", "")%>">
</td>
<td>
<div align="right">��͹�����ѹ</div>
</td><td>
<input name="_Zddy_" id="_Zddy_"value="<%=ParamUtils.getParameter(request, "_Zddy_", "")%>">
</td>
<td>
<div align="right">������</div>
</td><td>
<input name="_Cd_" id="_Cd_"value="<%=ParamUtils.getParameter(request, "_Cd_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">������</div>
</td><td>
<input name="_Kd_" id="_Kd_"value="<%=ParamUtils.getParameter(request, "_Kd_", "")%>">
</td>
<td>
<div align="right">ͨѶ��ʽ </div>
</td><td>
<input name="_Txfs_" id="_Txfs_"value="<%=ParamUtils.getParameter(request, "_Txfs_", "")%>">
</td>
<input type="hidden" name="_Hwsl_" id="_Hwsl_" value="<%=ParamUtils.getParameter(request, "_Hwsl_", "")%>">
<input type="hidden" name="_Hwzl_" id="_Hwzl_" value="<%=ParamUtils.getParameter(request, "_Hwzl_", "")%>">
<td>
<div align="right">IP��ַ</div>
</td><td>
<input name="_Ipaddress_" id="_Ipaddress_"value="<%=ParamUtils.getParameter(request, "_Ipaddress_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��е������</div>
</td><td>
<input name="_Handnum_" id="_Handnum_"value="<%=ParamUtils.getParameter(request, "_Handnum_", "")%>">
</td>
<td>
<div align="right">IOͨ������</div>
</td><td>
<input name="_Ionum_" id="_Ionum_"value="<%=ParamUtils.getParameter(request, "_Ionum_", "")%>">
</td>
<td>
<div align="right">������ַ</div>
</td><td>
<%=HtmlTool.renderSelect(RfidNameoptions, ParamUtils.getParameter(request,"_AddressId_",""), "_AddressId_", "")%>
<%//radio��ʽ%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, ParamUtils.getParameter(request,"_AddressId_",""), "_AddressId_", "")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, ParamUtils.getParameter(request,"_AddressId_",""), "_AddressId_", "")%>
</td>
</tr><tr>
<td>
<div align="right">�Ƿ����</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_Flag_",""), "_Flag_", "")%>
<%//radio��ʽ%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_Flag_",""), "_Flag_", "")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_Flag_",""), "_Flag_", "")%>
</td>
<td>
<div align="right">ͨѶ�Ƿ�����</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_TxFlag_",""), "_TxFlag_", "")%>
<%//radio��ʽ%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_TxFlag_",""), "_TxFlag_", "")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_TxFlag_",""), "_TxFlag_", "")%>
</td>
<td colspan="2">&nbsp;</td>
</tr><tr><td colspan="8" align="center">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px" onclick="searchFun()">��ѯ</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:80px"  onclick="clearSearch()">���</a>
</td></tr></table>
	</form>
</div>
</body>
</html>
