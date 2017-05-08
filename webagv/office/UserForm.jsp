<%@ page language="java" %>
<%--用户管理--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(User.class);
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
User v = (User)request.getAttribute("fromBean");
if (v == null) {
    out.print(HtmlTool.msgBox(request, "请先调用Action.jsp！"));
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
//默认值定义
List Politicsoptions = (List)request.getAttribute("Politicsoptions");
List TechPostCodeoptions = (List)request.getAttribute("TechPostCodeoptions");
List YesNooptions = (List)request.getAttribute("YesNooptions");
List Degree1Codeoptions = (List)request.getAttribute("Degree1Codeoptions");
List NationNameoptions = (List)request.getAttribute("NationNameoptions");
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/formfunction.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/jslib/My97DatePicker4.8b3/My97DatePicker/WdatePicker.js"></script>
<script type="text/JavaScript">
var url_para = "<%=url%>";
var dic = {<%=Tool.join(", ", diclist)%>};
var keyfield = "<%=(String)request.getAttribute("keyfield")%>";
var allfields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("allfields"))%>"];
var fields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("fields"))%>"];
var options= {<%=HtmlTool.getJsOptions(request)%>};
function init() {
}
//parent调用方法 start
function addNew0()
	{
    		addNew('<%=request.getContextPath()%>/目录名/<%=request.getAttribute("classname")%>', url_para);
	}
function deleteList0()
{
    	deleteList('<%=request.getContextPath()%>/目录名/<%=request.getAttribute("classname")%>', url_para);
	}
function save() {
            if (doValidate('postForm_User')) postForm_User.submit();
}
function initP() {
             parent.buttonlist = ["reload","save","browse"];;
    					parent.init();
}
//parent调用方法 end
// onkeypress="repeatPhone();" onChange="checkPhone(this);"js，无刷新验证手机号，
</script>
</head>
<body onLoad="init();">
<div id="nav1" style="display:">
    <ul>
        <li><img src="<%=request.getContextPath()%>/images/default/16_04.gif"  border=0 onClick="save();" style="cursor:pointer;"></li>
        <li><img src="<%=request.getContextPath()%>/images/default/s_sx.gif" border=0 onClick="document.postForm_User.reset();" style="cursor:pointer;"></li>
        <li><a href="UserAction.jsp?cmd=list&page=<%=currpage%><%=((url.length() == 0) ? "" : "&" + url)%>"><img src="<%=request.getContextPath()%>/images/default/s_back.gif"></a></li>
    </ul>
 	 <table border="0" width="100%" cellspacing="0" cellpadding="0">
		   <tr>
			    <td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
		   </tr>
	   </table>
</div>
<div id="errorDiv" style="color:red;font-weight:bold"></div>
<div id="jserrorDiv" style="color:red;font-weight:bold"></div>
<div id="form" style="overflow:auto;height:480px">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_User" id="postForm_User">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<table border="0" width="100%" cellspacing="0">

<input type="hidden" name="Id" value="<%=v.getId()%>">
<input type="hidden" name="OFFICEID" value="<%=v.getOFFICEID()%>">
<tr id="postForm_User_Code"><td class="td_label" width="20%">
<div align="right">用户编码:</div>
</td><td class="td_value"  width="30%">
<input name="Code" size="10" maxlength="50" value="<%=v.getCode()%>">
</td>
<td class="td_value"  width="20%"><div align="right">用户姓名:</div></td>
<td class="td_value"  width="30%"><input name="Name" size="20" maxlength="50" value="<%=v.getName()%>"></td>
</tr>
<tr id="postForm_User_LOGID"><td class="td_label">
<div align="right">登录用户名:</div>
</td><td  class="td_value">
<input name="LOGID" size="20" maxlength="50" value="<%=v.getLOGID()%>">
</td><td class="td_label">
<div align="right">登录密码:</div>
</td><td  class="td_value">
<%if(v.getId()>0){ %>
&nbsp;
<%}else{ %>
<input name="LOGPASS" type=password size="20" maxlength="50" value="">
<%} %>
</td></tr>
<tr id="postForm_User_Phone"><td class="td_label">
<div align="right">手机:</div>
</td><td  class="td_value">
<input name="Phone" size="20" maxlength="50" value="<%=v.getPhone()%>">
</td><td class="td_label">
<div align="right">电子邮件:</div>
</td><td  class="td_value">
<input name="E_MAIL" size="30" maxlength="50" value="<%=v.getE_MAIL()%>">
</td></tr>
<tr id="postForm_User_E_MAIL"><td class="td_label">
<div align="right">开始工作时间:</div>
</td><td  class="td_value">
<input name="WorkStart" size="20" maxlength="20" class="Wdate" onfocus="WdatePicker()" value="<%=v.getWorkStart()%>">
</td>
<td class="td_label">
<div align="right">学历:</div>
</td><td  class="td_value">
<%=HtmlTool.renderSelect(Degree1Codeoptions, "" + v.getDegreeCode(), "DegreeCode", "-1")%>
<%//radio形式%>
<%//Degree1Codeoptions.remove(0);%>
<%//=HtmlTool.renderRadio(Degree1Codeoptions, "" + v.getDegreeCode(), "DegreeCode", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(Degree1Codeoptions, "" + v.getDegreeCode(), "DegreeCode", "-1")%>
</td>
</tr>
<tr id="postForm_User_TechPostCode"><td class="td_label">
<div align="right">职称:</div>
</td><td  class="td_value">
<%=HtmlTool.renderSelect(TechPostCodeoptions, "" + v.getTechPostCode(), "TechPostCode", "-1")%>
<%//radio形式%>
<%//TechPostCodeoptions.remove(0);%>
<%//=HtmlTool.renderRadio(TechPostCodeoptions, "" + v.getTechPostCode(), "TechPostCode", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(TechPostCodeoptions, "" + v.getTechPostCode(), "TechPostCode", "-1")%>
</td><td class="td_label">
<div align="right">职务:</div>
</td><td  class="td_value">
<input name="ZhiWu" size="20" maxlength="50" value="<%=v.getZhiWu()%>">
</td></tr>
<tr id="postForm_User_Sfzhm"><td class="td_label">
<div align="right">身份证号码:</div>
</td><td  class="td_value">
<input name="Sfzhm" size="20" maxlength="50" value="<%=v.getSfzhm()%>">
</td><td class="td_label">
<div align="right">性别:</div>
</td><td  class="td_value">
<input name="XB" size="10" maxlength="50" value="<%=v.getXB()%>">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getXB(), "XB", "0")%>
<select name="Flag">
<option value="男" <%if(v.getXB().equals("0")){ out.print("selected");} %>>男</option>
<option value="女" <%if(v.getXB().equals("1")){ out.print("selected");} %>>女</option>
</select>
</td></tr>
<tr id="postForm_User_Address"><td class="td_label">
<div align="right">家庭地址:</div>
</td><td colspan="3" class="td_value">
<input name="Address" size="80" maxlength="100" value="<%=v.getAddress()%>">
</td></tr>

<tr id="postForm_User_Jguan"><td class="td_label">
<div align="right">民族:</div>
</td><td  class="td_value">
<%=HtmlTool.renderSelect(NationNameoptions, v.getMZ(), "MZ", "")%>
<%//radio形式%>
<%//NationNameoptions.remove(0);%>
<%//=HtmlTool.renderRaio(NationNameoptions, v.getMZ(), "MZ", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(NationNameoptions, v.getMZ(), "MZ", "")%>
</td>
<td class="td_label">
<div align="right">籍贯:</div>
</td><td  class="td_value">
<input name="Jguan" size="30" maxlength="50" value="<%=v.getJguan()%>">
</td>
</tr>

<tr id="postForm_User_Zzmm"><td class="td_label">
<div align="right">政治面貌:</div>
</td><td  class="td_value">
<%=HtmlTool.renderSelect(Politicsoptions, v.getZzmm(), "Zzmm", "")%>
<%//radio形式%>
<%//Politicsoptions.remove(0);%>
<%//=HtmlTool.renderRaio(Politicsoptions, v.getZzmm(), "Zzmm", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(Politicsoptions, v.getZzmm(), "Zzmm", "")%>
</td><td class="td_label">
<div align="right">婚否:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getMarryFlag(), "MarryFlag", "0")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getMarryFlag(), "MarryFlag", "0")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getMarryFlag(), "MarryFlag", "0")%>
</td></tr>

<tr id="postForm_User_OrderNum"><td class="td_label">
<div align="right">是否可用:</div>
</td><td  class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getSTATE(), "STATE", "1")%>
</td><td class="td_label">
<div align="right">是否删除:</div>
</td><td  class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getDelFlag(), "DelFlag", "0")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getDelFlag(), "DelFlag", "0")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getDelFlag(), "DelFlag", "0")%>
</td></tr>
<tr id="postForm_User_Remark"><td class="td_label">
<div align="right">备注:</div>
</td><td colspan="3" class="td_value">
<textarea name="Remark" cols="40" rows="2"><%=v.getRemark()%></textarea>
</td></tr>
<tr id="postForm_User_OrderNum"><td class="td_label">
<div align="right">排序:</div>
</td><td   colspan="3" class="td_value">
<input name="OrderNum"  size="10"  value="<%=v.getOrderNum()%>">
</td>
</tr>
</table>
</form>
</div>
</body>
</html>
