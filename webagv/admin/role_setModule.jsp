<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%!
private List getTreeParameters(javax.servlet.http.HttpServletRequest request)
{
    String filter_ids = ParamUtils.getParameter(request,"filter_ids","0");
    int choice_type = ParamUtils.getIntParameter(request, "choice_type", -1);
    List cdt = new ArrayList();
    if (!filter_ids.equals("0")) {
        String[] ids = Tool.split(",", filter_ids);
        if (choice_type == 1) { //in查询
            for (int i = 0; i < ids.length; i ++) {
                ids[i] = "'" + ids[i] + "'";
            }
            cdt.add("code in(" + Tool.join(",", ids) + ")");
        } else {  //like查询
            List subcdt = new ArrayList();
            for (int i = 0; i < ids.length; i ++) {
                subcdt.add("code like '" + ids[i] + "%'");
            }
            cdt.add("(" + Tool.join(" or ", subcdt) + ")");
        }
    }
    cdt.add("order by code");
    return cdt;
}
private void makeModuleTree(javax.servlet.http.HttpServletRequest request)
{
    int type = ParamUtils.getIntParameter(request, "type", 0);
    String checked_ids = "";
    String Classid = ParamUtils.getParameter(request,"Classid","");

    User_ModuleList userModule = new User_ModuleList();
    List cdt = new ArrayList();
    cdt.add("userid='"+Classid+"'");
    List<User_ModuleList> userModules = userModule.query(cdt);
    List row = new ArrayList();
    for(int i=0;i<userModules.size();i++)
    {
      userModule = userModules.get(i);
      row.add(""+userModule.getModuleId());
    }
    checked_ids = Tool.join(",",row);
    request.setAttribute("checked_ids",checked_ids);

    StringBuffer strTree = new StringBuffer();
    User_Module v = new User_Module();
    cdt = new ArrayList();
    cdt.add("order by code");
    Map<String, List<User_Module>> imap = v.initParentMap(cdt);
    if (imap.get("0") != null) {
        for (User_Module pv : imap.get("0")) {
            TreeItem ti = v.initTree(pv, imap);

                strTree.append(HtmlTool.getCheckBoxTree(ti, "tree", "tree", 1, checked_ids));

        }
    }
    request.setAttribute("TreeName", "系统模块功能");
    request.setAttribute("Tree", strTree.toString());
}
%>
<%
Log log = LogFactory.getLog(Tool.class);
log.debug("role_CodeChoiceTree");
String Classid = ParamUtils.getParameter(request,"Classid","");

//取得需要显示unit_ids列表,默认全部显示
String msg = (String)request.getAttribute("msg");
if ((msg != null)) {
    out.print(HtmlTool.msgBox(msg, "-2", ""));
    return;
}
makeModuleTree(request);
String strTree = (String)request.getAttribute("Tree");


List treess=new ArrayList();
List<String> maps = new ArrayList<String>();

String ids = ParamUtils.getParameter(request,"ids","");
String complex="";

%>
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<link rel="STYLESHEET" type="text/css" href="<%=HeadConst.apache_url%>/images/default/web_oa.css">
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
<script src="<%=request.getContextPath()%>/js/xtreecheckbox.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/js/xtree.css">
</head>
<script>
var currItem = new Array();
var type = "";
var checked_ids = "";
var rtn = {<%=((maps.size() > 0)? Tool.join(",", maps) + ", ": "")%>"name" : "", "item" : [], "items" : []};
var IdsSet=Array();
function ok()
{

    //返回处理
    var complex="<%=complex%>";


        rtn["items"] = tree.getCheckeds();
        if (rtn["items"].length == 0) {
            rtn["items"][0] = [["-1", "", "-1", "", "[无]", 1, 1], 1];
        }



    set_data(rtn);
}


function set_data(rtn)
{
    var items = rtn["items"];
    var item = rtn["item"];
    var name = rtn["name"];
    var ids = [];
    var names = [];
    var j = 0;
    for (var i = 0; i < items.length; i++) {
        if(items[i][1] == 1){ //选中的
            if(items[i][0][0].id>0)
            {
              ids[j]= items[i][0][0].id;
              names[j ++] = items[i][0][0].name ;
            }
        }
    }
    if(ids.length == 0) {
        ids = ['-1'];
        names = ['[无]'];
    }else if(ids[0] == -1) {
        names = ['[无]'];
    }else if(ids[0] == 0) {
        ids = ['0'];
        names = ['[全部]'];
    }

      document.form1.JiaoSeUserList.value = ids.join(",");
      document.form1.UserNameList.value = names.join(",");
document.form1.submit();
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
</script>
<body>

<div style="POSITION: absolute; HEIGHT: 400px; LEFT: 32px;TOP: 20px; WIDTH: 300px; Z-INDEX: 108 ;overflow:auto">
<%if(Classid.equals("0")){
out.print("请选择人员");
out.print("</div>");
return;
}%>
<script>
var type1 = "";
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
</script>
</div>
<INPUT id=button5 name=button5 style="COLOR: navy; HEIGHT: 24px; LEFT: 32px; POSITION: absolute; TOP: 440px; WIDTH: 60px; Z-INDEX: 108" type=button value=选定 LANGUAGE=javascript onclick="return ok()">
<form action="role_doSetModule.jsp" name="form1" id="form1" method="post" target="setModule">
<input type="hidden" name="JiaoSeUserList" value="<%=request.getAttribute("checked_ids")==null?"":request.getAttribute("checked_ids")%>">
<input type="hidden" name="userid" value="<%=Classid%>">
<input type="hidden" name="UserNameList">
</form>
<iframe src="" id="setModule" name="setModule" style="display:none;POSITION: absolute;top:300px;">
</iframe>
</body>
</html>
