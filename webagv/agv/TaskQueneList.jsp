<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%!
private static Log log = LogFactory.getLog(com.software.common.PageControl.class);
%>
<%
log.debug("List");
String msg = (String)request.getAttribute("msg");
String back_msg = (String)request.getAttribute("back_msg");
if ((msg != null)) {
    out.print(HtmlTool.msgBox(request, msg));
    return;
}
if ((back_msg != null)) {
    out.print(HtmlTool.alert(request, back_msg));
}
String cmd = ParamUtils.getParameter(request, "cmd", "list");
StringBuffer str = new StringBuffer();
List rows = (List)request.getAttribute("List");
if (rows == null) {
    out.print(HtmlTool.msgBox(request, "请先调用Action.jsp！"));
    return;
}
int currpage = ParamUtils.getIntParameter(request, "page", 1);
Map extMaps = (Map)request.getAttribute("Ext");
List paras = HttpTool.getSavedUrlForm(request, "Ext");
List urls = (List)paras.get(0);
List forms = (List)paras.get(1);
urls.addAll((List)paras.get(2));
String url = Tool.join("&", urls);
com.software.common.PageControl pagecontrol = (com.software.common.PageControl)request.getAttribute("PageControl");
if (pagecontrol == null) {
    pagecontrol = new com.software.common.PageControl(0, 1, 1);
}
String[] dickeys = (String[])request.getAttribute("dickeys");
String[][] dicvalues = (String[][])request.getAttribute("dicvalues");
List diclist = new ArrayList();
for (int i = 0; i < dickeys.length; i ++) {
    diclist.add("\"" + dickeys[i] + "\": [\"" + Tool.join("\", \"", dicvalues[i]) + "\"]");
}
//默认值定义
%>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<title> <%=request.getAttribute("describe")%> </title>
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/listfunction.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-1.7.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/listfunction.js"></script>
<link id="easyuiTheme" rel="stylesheet" href="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/themes/default/easyui.css" type="text/css">
 <link rel="stylesheet" href="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/themes/icon.css" type="text/css"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/JavaScript">
var curr_orderby = ["<%=HttpTool.getString(extMaps, "orderfield", "")%>", "<%=HttpTool.getString(extMaps, "ordertype", "")%>"];
var url_para = "<%=url%>";
var dic = {<%=Tool.join(",\r\n", diclist)%>};
var keyfield = "<%=(String)request.getAttribute("keyfield")%>";
var allfields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("allfields"))%>"];
var fields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("fields"))%>"];
var queryfields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("queryfields"))%>"];
var queryvalues = ["<%=Tool.join("\", \"", (List)request.getAttribute("queryvalues"))%>"];
var rows = [<%=Tool.join(",\r\n", rows)%>];
function init() {
    showList("<%=request.getAttribute("classname")%>", <%=pagecontrol.getCurrPage()%>, url_para);
    //showListReport("<%=request.getAttribute("classname")%>", <%=pagecontrol.getCurrPage()%>, url_para);
}
function showList(className, currpage, url_para) {
    var getRow = function (str, dalign) {
        if (str == "" || str == "null") str = "&nbsp;";
        if (dalign == "" || dalign == "null") dalign = "control";
        return "<td align='" + data_align[dalign] + "'>" + str + "</td>\n";
    };
    var showfields = new Array();
    var keyindex = getFieldIndex(keyfield);
    var str = "<table border=\"0\" width=\"100%\" cellspacing=\"0\">\n<tr class=title_bgcolor>\n";
    str = str + "<td align='center' width=\"16\"><input type=\"checkbox\" onclick=\"selectAll(this);\" onchange=\"selectAll(this);\"></td>\n";
    for (var i = 0; i < fields.length; i ++) {
        if (dic[fields[i]][1] == "") dic[fields[i]][1] = "&nbsp;";
        str = str + "<td align='center' onclick=\"javascript:setOrderBy('" + fields[i] + "')\" class=\"button\">" + dic[fields[i]][1];
        if (curr_orderby != undefined) {
            if (curr_orderby[0] == fields[i]) {
                str = str + "<img src=\"" + order_image[curr_orderby[1]] + "\">";
            }
        }
        str = str + "</td>\n";
        showfields[i] = getFieldIndex(fields[i]);
    }
    str = str + "<td align='center' width=\"230\">操作</td>\n";
    str = str + "</tr>\n";
    if (rows.length == 0) {
        str = str + "<tr><td colspan=" + (showfields.length + 2) + " align=center class=data_bgcolor_even>没有记录！</td></tr>\n";
    } else {
        for (i = 0; i < rows.length; i ++) {
            var color = (i % 2 != 0) ? "data_bgcolor_odd" : "data_bgcolor_even";
            str = str + "<tr class=" + color + ">\n";
            str = str + getRow("<input type=checkbox name=chk1 value=" + rows[i][keyindex] + " />");
            for (var j = 0; j < fields.length; j ++) {
                var k = showfields[j];
                str = str + getRow(rows[i][k], dic[fields[j]][0]);
            }
          //  str = str + getRow("<a  class='easyui-linkbutton l-btn' href=\"TaskQueneAction.jsp?cmd=modify&Id=" + rows[i][keyindex]+ "\"><span class='l-btn-left'>修改</span></a><a  class='easyui-linkbutton l-btn' href=\"#\" onclick=\"modifyFun("+rows[i][keyindex]+")\"><span class='l-btn-left'>选择小车</span></a><a  class='easyui-linkbutton l-btn' href=\"#\" onclick=\"runtask("+rows[i][keyindex]+")\"><span class='l-btn-left'>启动</span></a>", color);
            str = str + getRow("<a  class='easyui-linkbutton l-btn' href=\"#\" onclick=\"runtask("+rows[i][keyindex]+")\"><span class='l-btn-left'>启动</span></a>", color);
            str = str + "</tr>\n";
        }
    }
    str = str + '</table>';
    document.getElementById("list").innerHTML = str;
}
function modifyFun(id) {
	$("#openDlgIframe")[0].src="cars.jsp?&taskid="+id;
	$("#openDlgDiv").dialog("open");
	}
function runtask(id) {
	/**
	*重新执行任务：针对出现故障的车辆；或者是刷错卡的情况进行重新
	*/

		 $.ajax({
		        type: "POST",
		        url: "zxrw.jsp",
		        data: {taskid:id},       
		        success: function(data){
		        	    alert(data);      
		        	    location.reload();刷新页面 
		        }
		    });	
	//$("#openDlgIframe")[0].src="TaskQueneAction.jsp?cmd=runtask&taskid="+id;
	//$("#openDlgDiv").dialog("open");
	}
function closet(){	
	self.location.reload(); 
	//alert("排产成功！");
	$("#openDlgDiv").dialog('close');
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
            if (doValidate('postForm_TaskQuene')) postForm_TaskQuene.submit();
}
function initP() {
             parent.buttonlist = ["reload","addNew","deleteList"];
    					parent.init();
}
//parent调用方法 end
</script>
</head>
<body onload="init();">
<div id="nav1" style="display:">
    <ul>
        <li><a href="javascript:addNew('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/16_038.gif" alt="增加记录"></a></li>
        <li><a href="javascript:deleteList('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/button4.gif" alt="删除记录"></a></li>
        <li><a href="javascript:document.queryForm_TaskQuene.cmd.value = 'list' ;document.queryForm_TaskQuene.submit();"><img src="<%=request.getContextPath()%>/images/default/button_cx.gif" alt="查询"></a></li>
        <li><a href="javascript:document.queryForm_TaskQuene.cmd.value = 'excel'; document.queryForm_TaskQuene.submit();"><img src="<%=request.getContextPath()%>/images/default/button_dc.gif" alt="导出Excel文件"></a></li>
        <li><b>[任务队列]</b></li>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
				</tr>
				</table>
    </ul>
</div>
<div id="queryform">
<table border="0" width="100%" cellspacing="0" onclick="showhidden('searchTable')" style="cursor:pointer">
<tr><td colspan="8" align="center" class=title_bgcolor>查询条件</td></tr></table>
<table border="0" width="100%" cellspacing="0" id="searchTable" style="display:none" >
<form action="<%=request.getAttribute("classname")%>Action.jsp" name="queryForm_TaskQuene" id="queryForm_TaskQuene">
<input type="hidden" name="cmd" value="list">
<%=Tool.join("\n", forms)%>
<tr>
<td>
<div align="right">名称</div>
</td><td>
<input name="_Name_" id="_Name_" value="<%=ParamUtils.getParameter(request, "_Name_", "")%>">
</td>
<input type="hidden" name="_Carid_" id="_Carid_" value="<%=ParamUtils.getParameter(request, "_Carid_", "")%>">
<td>
<div align="right">优先级</div>
</td><td>
<input name="_Yxj_" id="_Yxj_" value="<%=ParamUtils.getParameter(request, "_Yxj_", "")%>">
</td>
<td>
<div align="right">任务状态0未定义1待命区2执行区</div>
</td><td>
<input name="_Rwzt_" id="_Rwzt_" value="<%=ParamUtils.getParameter(request, "_Rwzt_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">起点地址</div>
</td><td>
<input name="_Qd_" id="_Qd_" value="<%=ParamUtils.getParameter(request, "_Qd_", "")%>">
</td>
<td>
<div align="right">终点地址</div>
</td><td>
<input name="_Zd_" id="_Zd_" value="<%=ParamUtils.getParameter(request, "_Zd_", "")%>">
</td>
<input type="hidden" name="_QdId_" id="_QdId_" value="<%=ParamUtils.getParameter(request, "_QdId_", "")%>">
<input type="hidden" name="_ZdId_" id="_ZdId_" value="<%=ParamUtils.getParameter(request, "_ZdId_", "")%>">
<td>
<div align="right">是否结束1待命区2缓冲区3执行区</div>
</td><td>
<input name="_EndFlag_" id="_EndFlag_" value="<%=ParamUtils.getParameter(request, "_EndFlag_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">可用标志</div>
</td><td>
<input name="_Kybz_" id="_Kybz_" value="<%=ParamUtils.getParameter(request, "_Kybz_", "")%>">
</td>
<td>
<div align="right">货物种类</div>
</td><td>
<input name="_Hwzl_" id="_Hwzl_" value="<%=ParamUtils.getParameter(request, "_Hwzl_", "")%>">
</td>
<td>
<div align="right">货物编码</div>
</td><td>
<input name="_Hwbm_" id="_Hwbm_" value="<%=ParamUtils.getParameter(request, "_Hwbm_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">货物名称</div>
</td><td>
<input name="_Hwmc_" id="_Hwmc_" value="<%=ParamUtils.getParameter(request, "_Hwmc_", "")%>">
</td>
<td>
<div align="right">货物RFID</div>
</td><td>
<input name="_Hwrfid_" id="_Hwrfid_" value="<%=ParamUtils.getParameter(request, "_Hwrfid_", "")%>">
</td>
<td>
<div align="right">发货量</div>
</td><td>
<input name="_Fhl_" id="_Fhl_" value="<%=ParamUtils.getParameter(request, "_Fhl_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">创建时间</div>
</td><td>
<input name="_CreateTime_" id="_CreateTime_" value="<%=ParamUtils.getParameter(request, "_CreateTime_", "")%>">
</td>
<td>
<div align="right">下发时间</div>
</td><td>
<input name="_XfTime_" id="_XfTime_" value="<%=ParamUtils.getParameter(request, "_XfTime_", "")%>">
</td>
<td>
<div align="right">执行时间 </div>
</td><td>
<input name="_StartTime_" id="_StartTime_" value="<%=ParamUtils.getParameter(request, "_StartTime_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">执行完成时间</div>
</td><td>
<input name="_EndTime_" id="_EndTime_" value="<%=ParamUtils.getParameter(request, "_EndTime_", "")%>">
</td>
<td>
<div align="right">任务类型0无效1运货2充电3维修</div>
</td><td>
<input name="_Type_" id="_Type_" value="<%=ParamUtils.getParameter(request, "_Type_", "")%>">
</td>
<td>
<div align="right">用户编号</div>
</td><td>
<input name="_Userid_" id="_Userid_" value="<%=ParamUtils.getParameter(request, "_Userid_", "")%>">
</td>
</tr><tr><td colspan="8" align="center">
<input type="button" value="Reset" onClick="clearForm('queryForm_TaskQuene')" />
</td></tr></form></table>
</div>
<div>每页显示条数：<%=Tool.getUserInfo(request).getDispNum()%></div>
<div id="list">
</div>
<%=(("listall".equals(cmd)))? "": pagecontrol.getControl((String)request.getAttribute("classname") + "Action.jsp?cmd=list" + ((url.length() == 0) ? "" : "&" + url), "")%>
<div id="openDlgDiv" class="easyui-window" closed="true" modal="true" title="agv" style="width:400px;height:300px;overflow:hidden">
	<iframe scrolling="auto" id="openDlgIframe" frameborder="0"  src="" style="width:100%;height:99%;"></iframe>
</div>
</body>
</html>
