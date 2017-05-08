<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(Tool.class);
log.debug("role_CodeChoiceTree");
//取得需要显示unit_ids列表,默认全部显示
String msg = (String)request.getAttribute("msg");
if ((msg != null)) {
    out.print(HtmlTool.msgBox(msg, "-2", ""));
    return;
}
String strTree = (String)request.getAttribute("Tree");
Map<String, String> extparaMap = (Map<String, String>)request.getAttribute("OptionsExt");
Map<String, String> ext = (Map<String, String>)request.getAttribute("Ext");

List treess=new ArrayList();
List<String> maps = new ArrayList<String>();
if (!ext.isEmpty()) {
    for (Map.Entry<String, String> item : ext.entrySet()) {
        maps.add("\"" + item.getKey() + "\":\"" + item.getValue() + "\"");
    }
}
String ids = ParamUtils.getParameter(request,"ids","");
String complex="";
complex=(String)request.getAttribute("complex");
%>
<html>
<head>
<%@ include file="/js/jsheader.jsp"%>
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
<script src="<%=request.getContextPath()%>/js/xtreecheckbox.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/js/xtree.css">
</head>
<script>
var currItem = new Array();
var type = "<%=extparaMap.get("type")%>";
var checked_ids = "<%=extparaMap.get("checked_ids")==null?"":extparaMap.get("checked_ids")%>";
var rtn = {<%=((maps.size() > 0)? Tool.join(",", maps) + ", ": "")%>"name" : "<%=extparaMap.get("cmd")%>", "item" : [], "items" : []};
var IdsSet=Array();
function ok()
{
    //返回处理
    var complex="<%=complex%>";

    if(complex=="1")
    {
        rtn["item"] = currItem;
        if(rtn["name"]=="BankCode"||rtn["name"]=="BankCode1")
          {
           rtn["item"][0]=IdsSet.join(",");
          }
    }
    if (type == 0) {
        rtn["item"] = currItem;
        if(currItem.length==0)
          {
            alert("请选择合适的选项！");
            return;
          }
    } else {
        rtn["items"] = tree.getCheckeds();
        if (rtn["items"].length == 0) {
            rtn["items"][0] = [["-1", "", "-1", "", "[无]", 1, 1], 1];
        }
    }


    window.opener.set_data(rtn);

    self.close();
}
function cancel()
{
    top.close();
}

function treeClick(item)
{
    currItem = item.data;

        nodeSet={};
        getSet(item);
        var k=0;
        for (key in nodeSet)
         {
            IdsSet[k]=key;
            k++;
         }
}
var nodeSet = {};
function getSet(item)
{
    nodeSet[item.data[0]] = "";  //只保留Key
    for (var i = 0; i < item.childNodes.length; i ++) {
        getSet(item.childNodes[i]);
    }
}
function checkAll()
{
	checkAll;
	}
</script>
<body>
<div style="POSITION: absolute; HEIGHT: 400px; LEFT: 32px;TOP: 30px; WIDTH: 300px; Z-INDEX: 108 ;overflow:auto">
<script>
var type1 = "<%=extparaMap.get("type")%>";
var complex0="<%=complex%>";
if (document.getElementById) {
    var tree;
    if (type1 == 0||complex0=="1")
        tree = new WebFXTree("<%=request.getAttribute("TreeName")%>");
    else
        tree = new WebFXTree("全部:<%=request.getAttribute("TreeName")%>", "javascript:void(0)", ['0', '0', '', '', '', '0'], 1, ((checked_ids == '0')? 1: 0));
    tree.setBehavior("classic");
    <%=strTree%>
    document.write(tree);
}
function expanall(){
	if(document.getElementById("button1").checked==true)
		{
			tree.expandAll();
		}else
			{
			tree.collapseChildren();
			}
}
function clearAll()
{
	tree.clearCheckeds();
	}
</script>

</div>
<INPUT id=button5 name=button5 style="COLOR: navy; HEIGHT: 24px; LEFT: 32px; POSITION: absolute; TOP: 460px; WIDTH: 60px; Z-INDEX: 108" type=button value=选定 LANGUAGE=javascript onclick="return ok()">
<INPUT id=button3 name=button3 style=" COLOR: navy; HEIGHT: 24px; LEFT: 200px; POSITION: absolute; TOP: 460px; WIDTH: 60px; Z-INDEX: 108" type=button value=取消 LANGUAGE=javascript onclick="return cancel()">
<div style="LEFT: 32px; POSITION: absolute; TOP: 5px;  Z-INDEX: 108"><INPUT id=button1 name=button1 id="button1"  type=checkbox value="" LANGUAGE=javascript onclick="expanall();">全部展开/收缩</div>
<div style="LEFT: 132px; POSITION: absolute; TOP: 5px;  Z-INDEX: 108"><INPUT id=button2 name=button2 id="button2"  type=checkbox value="" LANGUAGE=javascript onclick="clearAll();">全部取消</div>
</body>
</html>
