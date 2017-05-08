<%@ page language="java" %>
<%--����--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(Task.class);
String msg = (String)request.getAttribute("msg");
String back_msg = (String)request.getAttribute("back_msg");
if ((msg != null)) {
    out.print(HtmlTool.msgBox(request, msg));
    return;
}
if ((back_msg != null)) {
    out.print(HtmlTool.alert(request, back_msg));
}
String cmd = ParamUtils.getParameter(request, "cmd", "insert");
int currpage = ParamUtils.getIntParameter(request, "page", 1);
Task v = (Task)request.getAttribute("fromBean");
if (v == null) {
    out.print(HtmlTool.msgBox(request, "���ȵ���Action.jsp��"));
    return;
}
log.debug(request.getAttribute("classname") + "Form");
String[] dickeys = (String[])request.getAttribute("dickeys");
String[][] dicvalues = (String[][])request.getAttribute("dicvalues");
List diclist = new ArrayList();
for (int i = 0; i < dickeys.length; i ++) {
    diclist.add("\"" + dickeys[i] + "\": [\"" + Tool.join("\", \"", dicvalues[i]) + "\"]");
}
Map extMaps = (Map)request.getAttribute("Ext");
List paras = HttpTool.getSavedUrlForm(request, "Ext");
List urls = (List)paras.get(0);
List forms = (List)paras.get(1);
urls.addAll((List)paras.get(2));
forms.addAll((List)paras.get(3));
String url = Tool.join("&", urls);
//Ĭ��ֵ����
List RfidNameoptions = (List)request.getAttribute("RfidNameoptions");
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<jsp:include page="/jqueryinc.jsp">
<jsp:param value="metro-blue" name="style"/>
</jsp:include>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/formfunction.js"></script>
<script type="text/JavaScript">
var url_para = "<%=url%>";
var dic = {<%=Tool.join(", ", diclist)%>};
var keyfield = "<%=(String)request.getAttribute("keyfield")%>";
var allfields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("allfields"))%>"];
var fields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("fields"))%>"];
var options= {<%=HtmlTool.getJsOptions(request)%>};
function init() {
}
//parent���÷��� start
function addNew0()
	{
    		addNew('<%=request.getContextPath()%>/Ŀ¼��/<%=request.getAttribute("classname")%>', url_para);
	}
function deleteList0()
{
    	deleteList('<%=request.getContextPath()%>/Ŀ¼��/<%=request.getAttribute("classname")%>', url_para);
	}
function save() {
    	$("#postForm_Task").attr("target","self");
    	$("#postForm_Task").on("submit", function(event) {
        	$.messager.progress({
            		title : "��ʾ",
            		text : "���Ժ�...."
        	});
    	});
    	$("#postForm_Task").form({
        		success:function(data){
            			$.messager.progress("close");
            			var obj = eval("("+data+")");
            			if(obj.success)
            			{
                			if(obj.success=="true")
                			{
                    				$.messager.progress({
                        					title : "��ʾ",
                        					text : "�����ɹ�"
                    				});
                    				//�ر�
                    				parent.reloadData();
                    				parent.$("#openDlgDiv").dialog("close");
                			}else
                			{
                    				$.messager.alert("Info", "����ʧ�ܣ�����ϵ������Ա(success=false)");
                			}
            			}else
            			{
                				$.messager.alert("Info", "����ʧ�ܣ�����ϵ������Ա(success is null)");
            			}
        		}
    	});
    	var isValid = $("#postForm_Task").form("validate");
    	if (!isValid){
        		$.messager.alert("��Ϣ������", "�뽫��Ϣ��д�������ٽ�����һ��");
        		$.messager.progress("close");
    	}else
    	{
        		$("#postForm_Task").submit();
    	}
}
function initP() {
             parent.buttonlist = ["reload","save","browse"];;
    					parent.init();
}
//parent���÷��� end
// onkeypress="repeatPhone();" onChange="checkPhone(this);"js����ˢ����֤�ֻ��ţ�
</script>
</head>
<body onload="init();">
<div id="footer" style="padding:5px;">
<div style="text-align:right;padding:5px">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="width:80px" onclick="save()">����</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:80px"  onclick="document.postForm_User_Module.reset()">ˢ��</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" style="width:80px" onclick="parent.$('#openDlgDiv').dialog('close');">�ر�</a>
</div>
</div>
<div id="errorDiv" style="color:red;font-weight:bold"></div>
<div id="jserrorDiv" style="color:red;font-weight:bold"></div>
<div class="easyui-panel" title="" style="width:100%" data-options="footer:'#footer'">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_Task" id="postForm_Task">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<div class="jqueryform" id="jqueryform">
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="Id" value="<%=v.getId()%>">
</table>
<table border="0" width="100%" cellspacing="0">
<tr id="postForm_Task_Code"><td class="td_label">
<div align="right">����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Code"  id="Code" size="50" maxlength="50" value="<%=v.getCode()%>">
</td></tr>
<tr id="postForm_Task_Name"><td class="td_label">
<div align="right">����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Name"  id="Name" size="50" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<input type="hidden" name="IdP" id="IdP" value="<%=v.getIdP()%>">
<input type="hidden" name="Carid" id="Carid" value="<%=v.getCarid()%>">
<tr id="postForm_Task_Sd"><td class="td_label">
<div align="right">�ٶ�:</div>
</td><td class="td_value">
<input name="Sd"  id="Sd" class="easyui-numberbox" precision="2" size="0" value="<%=v.getSd()%>"">
</td></tr>
<input type="hidden" name="Pathid" id="Pathid" value="<%=v.getPathid()%>">
<tr id="postForm_Task_Yxj"><td class="td_label">
<div align="right">���ȼ�:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Yxj"  id="Yxj" size="50" maxlength="50" value="<%=v.getYxj()%>">
</td></tr>
<tr id="postForm_Task_Rwzt"><td class="td_label">
<div align="right">����״̬:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Rwzt"  id="Rwzt" size="50" maxlength="50" value="<%=v.getRwzt()%>">
</td></tr>
<tr id="postForm_Task_Qd"><td class="td_label">
<div align="right">����ַ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Qd"  id="Qd" size="50" maxlength="50" value="<%=v.getQd()%>">
</td></tr>
<tr id="postForm_Task_Zd"><td class="td_label">
<div align="right">�յ��ַ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Zd"  id="Zd" size="50" maxlength="50" value="<%=v.getZd()%>">
</td></tr>
<tr id="postForm_Task_QdId"><td class="td_label">
<div align="right">���RFID:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(RfidNameoptions, "" + v.getQdId(), "QdId", "-1")%>
<%//radio��ʽ%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, "" + v.getQdId(), "QdId", "-1")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, "" + v.getQdId(), "QdId", "-1")%>
</td></tr>
<tr id="postForm_Task_ZdId"><td class="td_label">
<div align="right">�յ�RFID:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(RfidNameoptions, "" + v.getZdId(), "ZdId", "-1")%>
<%//radio��ʽ%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, "" + v.getZdId(), "ZdId", "-1")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, "" + v.getZdId(), "ZdId", "-1")%>
</td></tr>
<input type="hidden" name="Commands" id="Commands" value="<%=v.getCommands()%>">
<tr id="postForm_Task_ComandsCode"><td class="td_label">
<div align="right">�������:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="ComandsCode"  id="ComandsCode" size="50" maxlength="50" value="<%=v.getComandsCode()%>">
</td></tr>
<tr id="postForm_Task_Currfid"><td class="td_label">
<div align="right">��ǰ��:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Currfid"  id="Currfid" size="50" maxlength="50" value="<%=v.getCurrfid()%>">
</td></tr>
<tr id="postForm_Task_Length"><td class="td_label">
<div align="right">·������:</div>
</td><td class="td_value">
<input name="Length"  id="Length" class="easyui-numberbox" precision="2" size="0" value="<%=v.getLength()%>"">
</td></tr>
<tr id="postForm_Task_Weigh"><td class="td_label">
<div align="right">Ȩ��:</div>
</td><td class="td_value">
<input name="Weigh"  id="Weigh" class="easyui-numberbox" precision="2" size="0" value="<%=v.getWeigh()%>"">
</td></tr>
<tr id="postForm_Task_Kybz"><td class="td_label">
<div align="right">���ñ�־:</div>
</td><td class="td_value">
<input name="Kybz"  id="Kybz" class="easyui-numberbox" size="-1" value="<%=v.getKybz()%>"">
</td></tr>
<tr id="postForm_Task_Hwzl"><td class="td_label">
<div align="right">��������:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Hwzl"  id="Hwzl" size="50" maxlength="50" value="<%=v.getHwzl()%>">
</td></tr>
<tr id="postForm_Task_Hwbm"><td class="td_label">
<div align="right">�������:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Hwbm"  id="Hwbm" size="50" maxlength="50" value="<%=v.getHwbm()%>">
</td></tr>
<tr id="postForm_Task_Hwmc"><td class="td_label">
<div align="right">��������:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Hwmc"  id="Hwmc" size="50" maxlength="50" value="<%=v.getHwmc()%>">
</td></tr>
<tr id="postForm_Task_Hwrfid"><td class="td_label">
<div align="right">����RFID:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Hwrfid"  id="Hwrfid" size="50" maxlength="50" value="<%=v.getHwrfid()%>">
</td></tr>
<tr id="postForm_Task_Hwsl"><td class="td_label">
<div align="right">��������:</div>
</td><td class="td_value">
<input name="Hwsl"  id="Hwsl" class="easyui-numberbox" size="-1" value="<%=v.getHwsl()%>"">
</td></tr>
<tr id="postForm_Task_Dwssl"><td class="td_label">
<div align="right">��λ������:</div>
</td><td class="td_value">
<input name="Dwssl"  id="Dwssl" class="easyui-numberbox" precision="2" size="0" value="<%=v.getDwssl()%>"">
</td></tr>
<tr id="postForm_Task_Fhl"><td class="td_label">
<div align="right">������:</div>
</td><td class="td_value">
<input name="Fhl"  id="Fhl" class="easyui-numberbox" precision="2" size="0" value="<%=v.getFhl()%>"">
</td></tr>
<tr id="postForm_Task_CreateTime"><td class="td_label">
<div align="right">����ʱ��:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="CreateTime"  id="CreateTime" size="50" maxlength="50" value="<%=v.getCreateTime()%>">
</td></tr>
<tr id="postForm_Task_XfTime"><td class="td_label">
<div align="right">�·�ʱ��:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="XfTime"  id="XfTime" size="50" maxlength="50" value="<%=v.getXfTime()%>">
</td></tr>
<tr id="postForm_Task_StartTime"><td class="td_label">
<div align="right">�û�ִ��ʱ�� :</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="StartTime"  id="StartTime" size="50" maxlength="50" value="<%=v.getStartTime()%>">
</td></tr>
<tr id="postForm_Task_EndTime"><td class="td_label">
<div align="right">ִ�����ʱ��:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="EndTime"  id="EndTime" size="50" maxlength="50" value="<%=v.getEndTime()%>">
</td></tr>
<tr id="postForm_Task_Type"><td class="td_label">
<div align="right">��������:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Type"  id="Type" size="50" maxlength="50" value="<%=v.getType()%>">
</td></tr>
<tr id="postForm_Task_Endflag"><td class="td_label">
<div align="right">�Ƿ����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Endflag"  id="Endflag" size="50" maxlength="50" value="<%=v.getEndflag()%>">
</td></tr>
<tr id="postForm_Task_Userid"><td class="td_label">
<div align="right">�û����:</div>
</td><td class="td_value">
<input name="Userid"  id="Userid" class="easyui-numberbox" size="-1" value="<%=v.getUserid()%>"">
</td></tr>
</table>
</form>
</div>
</div>
</body>
</html>
