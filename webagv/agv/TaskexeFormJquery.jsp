<%@ page language="java" %>
<%--����ִ�м�¼--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(Taskexe.class);
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
Taskexe v = (Taskexe)request.getAttribute("fromBean");
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
List PathsNameoptions = (List)request.getAttribute("PathsNameoptions");
List TaskNameoptions = (List)request.getAttribute("TaskNameoptions");
List CarNameoptions = (List)request.getAttribute("CarNameoptions");
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
    	$("#postForm_Taskexe").attr("target","self");
    	$("#postForm_Taskexe").on("submit", function(event) {
        	$.messager.progress({
            		title : "��ʾ",
            		text : "���Ժ�...."
        	});
    	});
    	$("#postForm_Taskexe").form({
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
    	var isValid = $("#postForm_Taskexe").form("validate");
    	if (!isValid){
        		$.messager.alert("��Ϣ������", "�뽫��Ϣ��д�������ٽ�����һ��");
        		$.messager.progress("close");
    	}else
    	{
        		$("#postForm_Taskexe").submit();
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_Taskexe" id="postForm_Taskexe">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<div class="jqueryform" id="jqueryform">
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="Id" value="<%=v.getId()%>">
</table>
<table border="0" width="100%" cellspacing="0">
<tr id="postForm_Taskexe_Xh"><td class="td_label">
<div align="right">���:</div>
</td><td class="td_value">
<input name="Xh"  id="Xh" class="easyui-numberbox" size="-1" value="<%=v.getXh()%>"">
</td></tr>
<tr id="postForm_Taskexe_Taskid"><td class="td_label">
<div align="right">����ID:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(TaskNameoptions, "" + v.getTaskid(), "Taskid", "-1")%>
<%//radio��ʽ%>
<%//TaskNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(TaskNameoptions, "" + v.getTaskid(), "Taskid", "-1")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(TaskNameoptions, "" + v.getTaskid(), "Taskid", "-1")%>
</td></tr>
<tr id="postForm_Taskexe_Carid"><td class="td_label">
<div align="right">С��:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(CarNameoptions, "" + v.getCarid(), "Carid", "-1")%>
<%//radio��ʽ%>
<%//CarNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(CarNameoptions, "" + v.getCarid(), "Carid", "-1")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(CarNameoptions, "" + v.getCarid(), "Carid", "-1")%>
</td></tr>
<tr id="postForm_Taskexe_Pathid"><td class="td_label">
<div align="right">·��ID:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(PathsNameoptions, "" + v.getPathid(), "Pathid", "-1")%>
<%//radio��ʽ%>
<%//PathsNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(PathsNameoptions, "" + v.getPathid(), "Pathid", "-1")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(PathsNameoptions, "" + v.getPathid(), "Pathid", "-1")%>
</td></tr>
<tr id="postForm_Taskexe_ComandsCode"><td class="td_label">
<div align="right">�������:</div>
</td><td class="td_value">
<textarea name="ComandsCode"  id="ComandsCode" class="easyui-textbox"  data-options="multiline:true" style="height:40px;width:200px"><%=v.getComandsCode()%></textarea>
</td></tr>
<tr id="postForm_Taskexe_Starttime"><td class="td_label">
<div align="right">��ʼʱ��:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Starttime"  id="Starttime" size="50" maxlength="50" value="<%=v.getStarttime()%>">
</td></tr>
<tr id="postForm_Taskexe_Endtime"><td class="td_label">
<div align="right">����ʱ��:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Endtime"  id="Endtime" size="50" maxlength="50" value="<%=v.getEndtime()%>">
</td></tr>
</table>
</form>
</div>
</div>
</body>
</html>
