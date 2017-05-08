<%@ page language="java" %>
<%--��������--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(Car.class);
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
Car v = (Car)request.getAttribute("fromBean");
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
List YesNooptions = (List)request.getAttribute("YesNooptions");
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
    	$("#postForm_Car").attr("target","self");
    	$("#postForm_Car").on("submit", function(event) {
        	$.messager.progress({
            		title : "��ʾ",
            		text : "���Ժ�...."
        	});
    	});
    	$("#postForm_Car").form({
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
    	var isValid = $("#postForm_Car").form("validate");
    	if (!isValid){
        		$.messager.alert("��Ϣ������", "�뽫��Ϣ��д�������ٽ�����һ��");
        		$.messager.progress("close");
    	}else
    	{
        		$("#postForm_Car").submit();
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_Car" id="postForm_Car">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<div class="jqueryform" id="jqueryform">
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="Id" value="<%=v.getId()%>">
</table>
<table border="0" width="100%" cellspacing="0">
<tr id="postForm_Car_Code"><td class="td_label">
<div align="right">����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Code"  id="Code" size="50" maxlength="50" value="<%=v.getCode()%>">
</td></tr>
<tr id="postForm_Car_Name"><td class="td_label">
<div align="right">����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Name"  id="Name" size="50" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<input type="hidden" name="IdP" id="IdP" value="<%=v.getIdP()%>">
<tr id="postForm_Car_Jd"><td class="td_label">
<div align="right">����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Jd"  id="Jd" size="50" maxlength="50" value="<%=v.getJd()%>">
</td></tr>
<tr id="postForm_Car_Dcdy"><td class="td_label">
<div align="right">��ص�ѹ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Dcdy"  id="Dcdy" size="50" maxlength="50" value="<%=v.getDcdy()%>">
</td></tr>
<tr id="postForm_Car_Zxsd"><td class="td_label">
<div align="right">���ֱ���ٶ�:</div>
</td><td class="td_value">
<input name="Zxsd"  id="Zxsd" class="easyui-numberbox" precision="2" size="0" value="<%=v.getZxsd()%>"">
</td></tr>
<tr id="postForm_Car_Gwsd"><td class="td_label">
<div align="right">�������ٶ�:</div>
</td><td class="td_value">
<input name="Gwsd"  id="Gwsd" class="easyui-numberbox" precision="2" size="0" value="<%=v.getGwsd()%>"">
</td></tr>
<tr id="postForm_Car_Jiasd"><td class="td_label">
<div align="right">���ٶ�:</div>
</td><td class="td_value">
<input name="Jiasd"  id="Jiasd" class="easyui-numberbox" precision="2" size="0" value="<%=v.getJiasd()%>"">
</td></tr>
<tr id="postForm_Car_Jiansd"><td class="td_label">
<div align="right">���ٶ�:</div>
</td><td class="td_value">
<input name="Jiansd"  id="Jiansd" class="easyui-numberbox" precision="2" size="0" value="<%=v.getJiansd()%>"">
</td></tr>
<tr id="postForm_Car_Slfs"><td class="td_label">
<div align="right">���Ϸ�ʽ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Slfs"  id="Slfs" size="50" maxlength="50" value="<%=v.getSlfs()%>">
</td></tr>
<tr id="postForm_Car_Sd"><td class="td_label">
<div align="right">�ٶ�:</div>
</td><td class="td_value">
<input name="Sd"  id="Sd" class="easyui-numberbox" precision="2" size="0" value="<%=v.getSd()%>"">
</td></tr>
<tr id="postForm_Car_Dyfs"><td class="td_label">
<div align="right">������ʽ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Dyfs"  id="Dyfs" size="50" maxlength="50" value="<%=v.getDyfs()%>">
</td></tr>
<tr id="postForm_Car_Wxcc"><td class="td_label">
<div align="right">���γߴ�:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Wxcc"  id="Wxcc" size="50" maxlength="50" value="<%=v.getWxcc()%>">
</td></tr>
<tr id="postForm_Car_Fz"><td class="td_label">
<div align="right">����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Fz"  id="Fz" size="50" maxlength="50" value="<%=v.getFz()%>">
</td></tr>
<tr id="postForm_Car_Dwjd"><td class="td_label">
<div align="right">��λ����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Dwjd"  id="Dwjd" size="50" maxlength="50" value="<%=v.getDwjd()%>">
</td></tr>
<tr id="postForm_Car_Qdxs"><td class="td_label">
<div align="right">������ʽ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Qdxs"  id="Qdxs" size="50" maxlength="50" value="<%=v.getQdxs()%>">
</td></tr>
<tr id="postForm_Car_Lxtime"><td class="td_label">
<div align="right">��������ʱ��:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Lxtime"  id="Lxtime" size="50" maxlength="50" value="<%=v.getLxtime()%>">
</td></tr>
<tr id="postForm_Car_Cdfs"><td class="td_label">
<div align="right">��緽ʽ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Cdfs"  id="Cdfs" size="50" maxlength="50" value="<%=v.getCdfs()%>">
</td></tr>
<tr id="postForm_Car_Zwlj"><td class="td_label">
<div align="right">��Сת��뾶:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Zwlj"  id="Zwlj" size="50" maxlength="50" value="<%=v.getZwlj()%>">
</td></tr>
<tr id="postForm_Car_Aqgyfw"><td class="td_label">
<div align="right">��ȫ��Ӧ��Χ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Aqgyfw"  id="Aqgyfw" size="50" maxlength="50" value="<%=v.getAqgyfw()%>">
</td></tr>
<tr id="postForm_Car_Ljsb"><td class="td_label">
<div align="right">·��ʶ��:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Ljsb"  id="Ljsb" size="50" maxlength="50" value="<%=v.getLjsb()%>">
</td></tr>
<tr id="postForm_Car_Xzts"><td class="td_label">
<div align="right">������ʾ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Xzts"  id="Xzts" size="50" maxlength="50" value="<%=v.getXzts()%>">
</td></tr>
<tr id="postForm_Car_Gzbj"><td class="td_label">
<div align="right">���ϱ���:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Gzbj"  id="Gzbj" size="50" maxlength="50" value="<%=v.getGzbj()%>">
</td></tr>
<tr id="postForm_Car_Aqfh"><td class="td_label">
<div align="right">��ȫ����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Aqfh"  id="Aqfh" size="50" maxlength="50" value="<%=v.getAqfh()%>">
</td></tr>
<tr id="postForm_Car_Zdfz"><td class="td_label">
<div align="right">�����:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Zdfz"  id="Zdfz" size="50" maxlength="50" value="<%=v.getZdfz()%>">
</td></tr>
<tr id="postForm_Car_Zdzxxc"><td class="td_label">
<div align="right">���ֱ���г�:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Zdzxxc"  id="Zdzxxc" size="50" maxlength="50" value="<%=v.getZdzxxc()%>">
</td></tr>
<tr id="postForm_Car_Cddy"><td class="td_label">
<div align="right">��س���ѹ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Cddy"  id="Cddy" size="50" maxlength="50" value="<%=v.getCddy()%>">
</td></tr>
<tr id="postForm_Car_Zddy"><td class="td_label">
<div align="right">��͹�����ѹ:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Zddy"  id="Zddy" size="50" maxlength="50" value="<%=v.getZddy()%>">
</td></tr>
<tr id="postForm_Car_Cd"><td class="td_label">
<div align="right">������:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Cd"  id="Cd" size="50" maxlength="50" value="<%=v.getCd()%>">
</td></tr>
<tr id="postForm_Car_Kd"><td class="td_label">
<div align="right">������:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Kd"  id="Kd" size="50" maxlength="50" value="<%=v.getKd()%>">
</td></tr>
<tr id="postForm_Car_Txfs"><td class="td_label">
<div align="right">ͨѶ��ʽ :</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Txfs"  id="Txfs" size="50" maxlength="50" value="<%=v.getTxfs()%>">
</td></tr>
<input type="hidden" name="Hwsl" id="Hwsl" value="<%=v.getHwsl()%>">
<input type="hidden" name="Hwzl" id="Hwzl" value="<%=v.getHwzl()%>">
<tr id="postForm_Car_Ipaddress"><td class="td_label">
<div align="right">IP��ַ:</div>
</td><td class="td_value">
<textarea name="Ipaddress"  id="Ipaddress" class="easyui-textbox"  data-options="multiline:true" style="height:40px;width:200px"><%=v.getIpaddress()%></textarea>
</td></tr>
<tr id="postForm_Car_Handnum"><td class="td_label">
<div align="right">��е������:</div>
</td><td class="td_value">
<input name="Handnum"  id="Handnum" class="easyui-numberbox" size="-1" value="<%=v.getHandnum()%>"">
</td></tr>
<tr id="postForm_Car_Ionum"><td class="td_label">
<div align="right">IOͨ������:</div>
</td><td class="td_value">
<input name="Ionum"  id="Ionum" class="easyui-numberbox" size="-1" value="<%=v.getIonum()%>"">
</td></tr>
<tr id="postForm_Car_AddressId"><td class="td_label">
<div align="right">������ַ:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(RfidNameoptions, "" + v.getAddressId(), "AddressId", "-1")%>
<%//radio��ʽ%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, "" + v.getAddressId(), "AddressId", "-1")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, "" + v.getAddressId(), "AddressId", "-1")%>
</td></tr>
<tr id="postForm_Car_Isuse"><td class="td_label">
<div align="right">�Ƿ�����:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsuse(), "Isuse", "-1")%>
<%//radio��ʽ%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsuse(), "Isuse", "-1")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsuse(), "Isuse", "-1")%>
</td></tr>
<tr id="postForm_Car_Flag"><td class="td_label">
<div align="right">�Ƿ����:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getFlag(), "Flag", "-1")%>
<%//radio��ʽ%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getFlag(), "Flag", "-1")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getFlag(), "Flag", "-1")%>
</td></tr>
<tr id="postForm_Car_TxFlag"><td class="td_label">
<div align="right">ͨѶ�Ƿ�����:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getTxFlag(), "TxFlag", "-1")%>
<%//radio��ʽ%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getTxFlag(), "TxFlag", "-1")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getTxFlag(), "TxFlag", "-1")%>
</td></tr>
</table>
</form>
</div>
</div>
</body>
</html>
