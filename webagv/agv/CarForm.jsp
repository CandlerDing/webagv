<%@ page language="java" %>
<%--车辆管理--%>
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
List YesNooptions = (List)request.getAttribute("YesNooptions");
List RfidNameoptions = (List)request.getAttribute("RfidNameoptions");
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
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
           postForm_Car.submit();
}
function initP() {
             parent.buttonlist = ["reload","save","browse"];;
    					parent.init();
}
//parent调用方法 end
// onkeypress="repeatPhone();" onChange="checkPhone(this);"js，无刷新验证手机号，
</script>
</head>
<body onload="init();">
<div id="nav1" style="display:">
    <ul>
        <li><img src="<%=request.getContextPath()%>/images/default/16_04.gif"  border=0 onclick="save();" style="cursor:pointer;"></li>
        <li><img src="<%=request.getContextPath()%>/images/default/s_sx.gif" border=0 onclick="document.postForm_Car.reset();" style="cursor:pointer;"></li>
        <li><a href="CarAction.jsp?cmd=list&page=<%=currpage%><%=((url.length() == 0) ? "" : "&" + url)%>"><img src="<%=request.getContextPath()%>/images/default/s_back.gif"></a></li>
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_Car" id="postForm_Car">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="_Id_" value="<%=v.getId()%>">
</table>
<table border="0" width="100%" cellspacing="0">
<tr id="postForm_Car_Code"><td class="td_label">
<div align="right">编码:</div>
</td><td class="td_value">
<input name="Code" id="_Code_" size="50" maxlength="50" value="<%=v.getCode()%>">
</td></tr>
<tr id="postForm_Car_Name"><td class="td_label">
<div align="right">名称:</div>
</td><td class="td_value">
<input name="Name" id="_Name_" size="50" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<input type="hidden" name="IdP" value="<%=v.getIdP()%>">
<tr id="postForm_Car_Jd"><td class="td_label">
<div align="right">精度:</div>
</td><td class="td_value">
<input name="Jd" id="_Jd_" size="50" maxlength="50" value="<%=v.getJd()%>">
</td></tr>
<tr id="postForm_Car_Dcdy"><td class="td_label">
<div align="right">电池电压:</div>
</td><td class="td_value">
<input name="Dcdy" id="_Dcdy_" size="50" maxlength="50" value="<%=v.getDcdy()%>">
</td></tr>
<tr id="postForm_Car_Zxsd"><td class="td_label">
<div align="right">最大直线速度:</div>
</td><td class="td_value">
<input name="Zxsd" id="_Zxsd_" value="<%=v.getZxsd()%>">
</td></tr>
<tr id="postForm_Car_Gwsd"><td class="td_label">
<div align="right">最大拐弯速度:</div>
</td><td class="td_value">
<input name="Gwsd" id="_Gwsd_" value="<%=v.getGwsd()%>">
</td></tr>
<tr id="postForm_Car_Jiasd"><td class="td_label">
<div align="right">加速度:</div>
</td><td class="td_value">
<input name="Jiasd" id="_Jiasd_" value="<%=v.getJiasd()%>">
</td></tr>
<tr id="postForm_Car_Jiansd"><td class="td_label">
<div align="right">减速度:</div>
</td><td class="td_value">
<input name="Jiansd" id="_Jiansd_" value="<%=v.getJiansd()%>">
</td></tr>
<tr id="postForm_Car_Slfs"><td class="td_label">
<div align="right">上料方式:</div>
</td><td class="td_value">
<input name="Slfs" id="_Slfs_" size="50" maxlength="50" value="<%=v.getSlfs()%>">
</td></tr>
<tr id="postForm_Car_Sd"><td class="td_label">
<div align="right">速度:</div>
</td><td class="td_value">
<input name="Sd" id="_Sd_" value="<%=v.getSd()%>">
</td></tr>
<tr id="postForm_Car_Dyfs"><td class="td_label">
<div align="right">导引方式:</div>
</td><td class="td_value">
<input name="Dyfs" id="_Dyfs_" size="50" maxlength="50" value="<%=v.getDyfs()%>">
</td></tr>
<tr id="postForm_Car_Wxcc"><td class="td_label">
<div align="right">外形尺寸:</div>
</td><td class="td_value">
<input name="Wxcc" id="_Wxcc_" size="50" maxlength="50" value="<%=v.getWxcc()%>">
</td></tr>
<tr id="postForm_Car_Fz"><td class="td_label">
<div align="right">负载:</div>
</td><td class="td_value">
<input name="Fz" id="_Fz_" size="50" maxlength="50" value="<%=v.getFz()%>">
</td></tr>
<tr id="postForm_Car_Dwjd"><td class="td_label">
<div align="right">定位精度:</div>
</td><td class="td_value">
<input name="Dwjd" id="_Dwjd_" size="50" maxlength="50" value="<%=v.getDwjd()%>">
</td></tr>
<tr id="postForm_Car_Qdxs"><td class="td_label">
<div align="right">驱动形式:</div>
</td><td class="td_value">
<input name="Qdxs" id="_Qdxs_" size="50" maxlength="50" value="<%=v.getQdxs()%>">
</td></tr>
<tr id="postForm_Car_Lxtime"><td class="td_label">
<div align="right">连续工作时间:</div>
</td><td class="td_value">
<input name="Lxtime" id="_Lxtime_" size="50" maxlength="50" value="<%=v.getLxtime()%>">
</td></tr>
<tr id="postForm_Car_Cdfs"><td class="td_label">
<div align="right">充电方式:</div>
</td><td class="td_value">
<input name="Cdfs" id="_Cdfs_" size="50" maxlength="50" value="<%=v.getCdfs()%>">
</td></tr>
<tr id="postForm_Car_Zwlj"><td class="td_label">
<div align="right">最小转弯半径:</div>
</td><td class="td_value">
<input name="Zwlj" id="_Zwlj_" size="50" maxlength="50" value="<%=v.getZwlj()%>">
</td></tr>
<tr id="postForm_Car_Aqgyfw"><td class="td_label">
<div align="right">安全感应范围:</div>
</td><td class="td_value">
<input name="Aqgyfw" id="_Aqgyfw_" size="50" maxlength="50" value="<%=v.getAqgyfw()%>">
</td></tr>
<tr id="postForm_Car_Ljsb"><td class="td_label">
<div align="right">路径识别:</div>
</td><td class="td_value">
<input name="Ljsb" id="_Ljsb_" size="50" maxlength="50" value="<%=v.getLjsb()%>">
</td></tr>
<tr id="postForm_Car_Xzts"><td class="td_label">
<div align="right">行走提示:</div>
</td><td class="td_value">
<input name="Xzts" id="_Xzts_" size="50" maxlength="50" value="<%=v.getXzts()%>">
</td></tr>
<tr id="postForm_Car_Gzbj"><td class="td_label">
<div align="right">故障报警:</div>
</td><td class="td_value">
<input name="Gzbj" id="_Gzbj_" size="50" maxlength="50" value="<%=v.getGzbj()%>">
</td></tr>
<tr id="postForm_Car_Aqfh"><td class="td_label">
<div align="right">安全防护:</div>
</td><td class="td_value">
<input name="Aqfh" id="_Aqfh_" size="50" maxlength="50" value="<%=v.getAqfh()%>">
</td></tr>
<tr id="postForm_Car_Zdfz"><td class="td_label">
<div align="right">最大负重:</div>
</td><td class="td_value">
<input name="Zdfz" id="_Zdfz_" size="50" maxlength="50" value="<%=v.getZdfz()%>">
</td></tr>
<tr id="postForm_Car_Zdzxxc"><td class="td_label">
<div align="right">最大直线行程:</div>
</td><td class="td_value">
<input name="Zdzxxc" id="_Zdzxxc_" size="50" maxlength="50" value="<%=v.getZdzxxc()%>">
</td></tr>
<tr id="postForm_Car_Cddy"><td class="td_label">
<div align="right">电池充电电压:</div>
</td><td class="td_value">
<input name="Cddy" id="_Cddy_" size="50" maxlength="50" value="<%=v.getCddy()%>">
</td></tr>
<tr id="postForm_Car_Zddy"><td class="td_label">
<div align="right">最低工作电压:</div>
</td><td class="td_value">
<input name="Zddy" id="_Zddy_" size="50" maxlength="50" value="<%=v.getZddy()%>">
</td></tr>
<tr id="postForm_Car_Cd"><td class="td_label">
<div align="right">车身长度:</div>
</td><td class="td_value">
<input name="Cd" id="_Cd_" size="50" maxlength="50" value="<%=v.getCd()%>">
</td></tr>
<tr id="postForm_Car_Kd"><td class="td_label">
<div align="right">车身宽度:</div>
</td><td class="td_value">
<input name="Kd" id="_Kd_" size="50" maxlength="50" value="<%=v.getKd()%>">
</td></tr>
<tr id="postForm_Car_Txfs"><td class="td_label">
<div align="right">通讯方式 :</div>
</td><td class="td_value">
<input name="Txfs" id="_Txfs_" size="50" maxlength="50" value="<%=v.getTxfs()%>">
</td></tr>
<input type="hidden" name="Hwsl" value="<%=v.getHwsl()%>">
<input type="hidden" name="Hwzl" value="<%=v.getHwzl()%>">
<tr id="postForm_Car_Ipaddress"><td class="td_label">
<div align="right">串口IP地址:</div>
</td><td class="td_value">
<textarea name="Ipaddress" id="_Ipaddress_" cols="40" rows="2"><%=v.getIpaddress()%></textarea>
</td></tr>
<tr id="postForm_Car_Port"><td class="td_label">
<div align="right">串口端口:</div>
</td><td class="td_value">
<input name="Port" id="_Port_" size="20" maxlength="20" value="<%=v.getPort()%>">
</td></tr>
<tr id="postForm_Car_WifiIpaddress"><td class="td_label">
<div align="right">无线IP地址:</div>
</td><td class="td_value">
<textarea name="WifiIpaddress" id="_WifiIpaddress_" cols="40" rows="2"><%=v.getWifiIpaddress()%></textarea>
</td></tr>
<tr id="postForm_Car_WifiPort"><td class="td_label">
<div align="right">无线端口:</div>
</td><td class="td_value">
<input name="WifiPort" id="_WifiPort_" size="20" maxlength="20" value="<%=v.getWifiPort()%>">
</td></tr>
<tr id="postForm_Car_Handnum"><td class="td_label">
<div align="right">机械手数量:</div>
</td><td class="td_value">
<input name="Handnum" id="_Handnum_" value="<%=v.getHandnum()%>">
</td></tr>
<tr id="postForm_Car_Ionum"><td class="td_label">
<div align="right">IO通道数量:</div>
</td><td class="td_value">
<input name="Ionum" id="_Ionum_" value="<%=v.getIonum()%>">
</td></tr>
<tr id="postForm_Car_AddressId"><td class="td_label">
<div align="right">车辆地址:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(RfidNameoptions, "" + v.getAddressId(), "AddressId", "-1")%>
<%//radio形式%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, "" + v.getAddressId(), "AddressId", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, "" + v.getAddressId(), "AddressId", "-1")%>
</td></tr>
<tr id="postForm_Car_Isuse"><td class="td_label">
<div align="right">是否在用:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsuse(), "Isuse", "-1")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsuse(), "Isuse", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsuse(), "Isuse", "-1")%>
</td></tr>
<tr id="postForm_Car_Flag"><td class="td_label">
<div align="right">是否故障:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getFlag(), "Flag", "-1")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getFlag(), "Flag", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getFlag(), "Flag", "-1")%>
</td></tr>
<tr id="postForm_Car_TxFlag"><td class="td_label">
<div align="right">通讯是否正常:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getTxFlag(), "TxFlag", "-1")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getTxFlag(), "TxFlag", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getTxFlag(), "TxFlag", "-1")%>
</td></tr>
</table>
</form>
</div>
</body>
</html>
