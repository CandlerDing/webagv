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
String IsCheck = ParamUtils.getParameter(request, "_IsCheck_", "1");
UserInfo userInfo = Tool.getUserInfo(request);
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
List YesNooptions = (List)request.getAttribute("YesNooptions");
List ChannelNameoptions = (List)request.getAttribute("ChannelNameoptions");
%>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<title> <%=request.getAttribute("describe")%> </title>
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/listfunction.js"></script>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/prototype.js"></script>
<style>
.title_bgcolor1{
	background:#BDDFFF;
	color:#00080;
	font-size:10pt;
	height:15px;
	font-weight:bold;
	}
</style>
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
	<%if(cmd.equals("list")&&!userInfo.isAdmin()&&!userInfo.isDagly()){%>
	 showListReport("<%=request.getAttribute("classname")%>", <%=pagecontrol.getCurrPage()%>, url_para);	 
	  <%}else{%>
	  showList("<%=request.getAttribute("classname")%>", <%=pagecontrol.getCurrPage()%>, url_para);
      <%}%>
}
function showListReport(className, currpage, url_para) {
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
    str = str + "</tr>\n";
    if (rows.length == 0) {
        str = str + "<tr><td colspan=" + (showfields.length + 2) + " align=center class=data_bgcolor_even>没有记录！</td></tr>\n";
    } else {
        for (i = 0; i < rows.length; i ++) {
            var color = (i % 2 != 0) ? "data_bgcolor_odd" : "data_bgcolor_even";
            //str = str + "<tr class=" + color + ">\n";
            str = str + "<a href = \"readgg.jsp?id="+ rows[i][keyindex] +"\" target=\"_blank\"><tr class=" + color + " onMouseOver=\"$(this).removeClass('"+ color +"');$(this).addClass('title_bgcolor');\" onMouseOut=\"$(this).removeClass('title_bgcolor');$(this).addClass('"+ color +"')\">\n";
            str = str + getRow("<input type=checkbox name=chk1 value=" + rows[i][keyindex] + " />");
            for (var j = 0; j < fields.length; j ++) {
                var k = showfields[j];
                if(j>4){
                str = str + getRow(rows[i][k], 'control');
                }
                else{
                str = str + getRow(rows[i][k], dic[fields[j]][0]);
                 }
            }
            str = str + "</tr></a>\n";
        }
    }
    str = str + '</table>';
    document.getElementById("list").innerHTML = str;
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
    str = str + "<td align='left' width=\"16\"><img src=\""+GBasePath+"/images/default/edit.gif\" id=\"icon_edit\"></td>\n";
    str = str + "</tr>\n";
    if (rows.length == 0) {
        str = str + "<tr><td colspan=" + (showfields.length + 2) + " align=center class=data_bgcolor_even>没有记录！</td></tr>\n";
    } else {
        for (i = 0; i < rows.length; i ++) {
            var color = (i % 2 != 0) ? "data_bgcolor_odd" : "data_bgcolor_even";
           // str = str + "<tr class=" + color + ">\n";
            str = str + "<a href = \"readgg.jsp?id="+ rows[i][keyindex] +"\"  target=\"_blank\"><tr class=" + color + " onMouseOver=\"$(this).removeClass('"+ color +"');$(this).addClass('title_bgcolor');\" onMouseOut=\"$(this).removeClass('title_bgcolor');$(this).addClass('"+ color +"')\">\n";
            str = str + getRow("<input type=checkbox name=chk1 value=" + rows[i][keyindex] + " />");
            for (var j = 0; j < fields.length; j ++) {
                var k = showfields[j];
                str = str + getRow(rows[i][k], dic[fields[j]][0]);
            }
            str = str + getRow("<img class=\"button\" src=\""+GBasePath+"/images/default/edit.gif\" onclick=\"javascript:window.location='" + className + "Action.jsp?cmd=modify&Id=" + rows[i][keyindex] + "&page=" + currpage + ((url_para.length == 0) ? "" : "&" + url_para) + "'\">", color);
            str = str + "</tr></a>\n";
        }
    }
    str = str + '</table>';
    document.getElementById("list").innerHTML = str;
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
            if (doValidate('postForm_Article')) postForm_Article.submit();
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
    <%if(userInfo.isAdmin()||userInfo.isDagly()){ 
    if(IsCheck.equals("3")){}else{
    %>
    
        <li><a href="javascript:addNew('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/16_038.gif" alt="增加记录"></a></li>
        <li><a href="javascript:deleteList('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/button4.gif" alt="删除记录"></a></li>
        <%}} %>
        <li><a href="javascript:document.queryForm_Article.cmd.value = 'list' ;document.queryForm_Article.submit();"><img src="<%=request.getContextPath()%>/images/default/button_cx.gif" alt="查询"></a></li>
        <li><a href="javascript:document.queryForm_Article.cmd.value = 'excel'; document.queryForm_Article.submit();"><img src="<%=request.getContextPath()%>/images/default/button_dc.gif" alt="导出Excel文件"></a></li>
        <li><b>[文章信息]</b></li>
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" name="queryForm_Article" id="queryForm_Article">
<input type="hidden" name="cmd" value="list">
<%=Tool.join("\n", forms)%>
<tr>
<td>
<div align="right">主栏目</div>
</td><td>
<%=HtmlTool.renderSelect(ChannelNameoptions, ParamUtils.getParameter(request,"_Classid_",""), "_Classid_", "")%>
<%//radio形式%>
<%//ChannelNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(ChannelNameoptions, ParamUtils.getParameter(request,"_Classid_",""), "_Classid_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(ChannelNameoptions, ParamUtils.getParameter(request,"_Classid_",""), "_Classid_", "")%>
</td>
<td>
<div align="right">标题</div>
</td><td>
<input name="_Title_" value="<%=ParamUtils.getParameter(request, "_Title_", "")%>">
</td>
<td>
<div align="right">副标题</div>
</td><td>
<input name="_SubTitle_" value="<%=ParamUtils.getParameter(request, "_SubTitle_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">摘要</div>
</td><td>
<input name="_Summary_" value="<%=ParamUtils.getParameter(request, "_Summary_", "")%>">
</td>
<td>
<div align="right">点击次数</div>
</td><td>
<input name="_Hits_" value="<%=ParamUtils.getParameter(request, "_Hits_", "")%>">
</td>
<td>
<div align="right">是否置顶</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_IsTop_",""), "_IsTop_", "")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_IsTop_",""), "_IsTop_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_IsTop_",""), "_IsTop_", "")%>
</td>
</tr><tr>
<td>
<div align="right">热点文章</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_IsHot_",""), "_IsHot_", "")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_IsHot_",""), "_IsHot_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_IsHot_",""), "_IsHot_", "")%>
</td>
<td>
<div align="right">推荐文章</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_IsRecommend_",""), "_IsRecommend_", "")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_IsRecommend_",""), "_IsRecommend_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_IsRecommend_",""), "_IsRecommend_", "")%>
</td>
<td>
<div align="right">回收站</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_IsDel_",""), "_IsDel_", "")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_IsDel_",""), "_IsDel_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_IsDel_",""), "_IsDel_", "")%>
</td>
</tr><tr>
<td>
<div align="right">是否审核发布</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_IsCheck_",""), "_IsCheck_", "")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_IsCheck_",""), "_IsCheck_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_IsCheck_",""), "_IsCheck_", "")%>
</td>
<td colspan="4">&nbsp;</td>
</tr><tr><td colspan="8" align="center">
<input type="button" value="Reset" onClick="clearForm('queryForm_Article')" />
</td></tr></form></table>
</div>
<div>每页显示条数：<%=Tool.getUserInfo(request).getDispNum()%></div>
<div id="list">
</div>
<%=(("listall".equals(cmd)))? "": pagecontrol.getControl((String)request.getAttribute("classname") + "Action.jsp?cmd=list" + ((url.length() == 0) ? "" : "&" + url), "")%>
</body>
</html>
