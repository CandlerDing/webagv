<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(Tool.class);
log.debug("ChoiceForm");
String msg = (String)request.getAttribute("msg");
if ((msg != null)) {
    out.print(HtmlTool.msgBox(msg, "-2", ""));
    return;
}
List<OptionBean> options = (List<OptionBean>)request.getAttribute("Options");
Map<String, String> extparaMap = (Map<String, String>)request.getAttribute("OptionsExt");
String checked_ids = (String)extparaMap.get("checked_ids");
if (checked_ids == null)
    checked_ids = "";
UserInfo userInfo = Tool.getUserInfo(request);
StringBuffer str = new StringBuffer();
if (userInfo != null) {
    if (options != null) {
        int i = 0;
        for (OptionBean item : options) {
            if (item.getLabel().length() == 0)
                continue;
            str.append("<input type=\"radio\" name=\"chk\" id=\"radio_"+ item.getValue() +"\" value=\"" + item.getValue() + "\" title=\"" + item.getLabel() + "\"");
            if (StrTool.inList(checked_ids, item.getValue(), ",")) {
                str.append(" checked");
            }
            str.append("><label for=\"radio_"+ item.getValue() +"\">" + item.getLabel() + "(" + item.getValue() +")</label><br>\n");
        }
    }
}
%>
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<link rel="STYLESHEET" type="text/css" href="<%=request.getContextPath()%>/images/default/web_oa.css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #F1F1F7;
}
.hei {
	font-size: 12px;
	color: #000000;
	letter-spacing: 0.1em;
	word-spacing: 0.1em;
}
-->
</style>
<%@ include file="/js/jsheader.jsp"%>
<script src="<%=request.getContextPath()%>/js/xtree.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/js/xtree.css">
</head>
<script>
function ok()
{
    //返回处理
    var chks = document.getElementsByName("chk");
    var checked_ids = new Array();
    var j = 0;
    var rtn = {"name" : "<%=extparaMap.get("cmd")%>", "item" : [], "items" : []};
    for (var i = 0; i < chks.length; i ++) {
        if (chks[i].checked) {
            checked_ids[j ++] = [[chks[i].value, "", chks[i].value, "", chks[i].title, 1, 1], 1];
        } else {
            checked_ids[j ++] = [[chks[i].value, "", chks[i].value, "", chks[i].title, 1, 0], 0];
        }
    }
    if (j == 0) {
        checked_ids[j] = [["-1", "", "-1", "", "[无]", 1, 1], 1];
    }
    rtn["items"] = checked_ids;
    window.opener.set_data(rtn);
    top.close();
}
function cancel()
{
    top.close();
}

</script>
<body>
<div style="POSITION: absolute; HEIGHT: 200px; LEFT: 32px;TOP: 20px; WIDTH: 300px; Z-INDEX: 108 ;overflow:auto">
<%=str%>
</div>
<div align="center">
<INPUT id=button5 name=button5  type=button value=选定 LANGUAGE=javascript onclick="return ok()">
<INPUT id=button3 name=button3 type=button value=取消 LANGUAGE=javascript onclick="return cancel()">
</div>
</body>
</html>

