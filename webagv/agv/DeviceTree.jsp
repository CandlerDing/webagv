<%@ page language="java" %>
<%--设备--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(Device.class);
log.debug("DeviceTree");
String msg = (String)request.getAttribute("msg");
if ((msg != null)) {
    out.print(HtmlTool.msgBox(request, msg));
    return;
}
//以下代码将产生树
UserInfo userInfo = Tool.getUserInfo(request);
if (userInfo==null) {
    out.print(HtmlTool.msgBox("请输入正确的用户名和密码! ", request.getContextPath()+"/logon",""));
    return;
}
Device v = new Device();
List cdt = new ArrayList();
cdt.add("limit 0, 300");
cdt.add("order by id");
Map imap = v.initParentMap(cdt);
String treeRootKey = v.findRootKey(imap);
log.debug("rootkey=" + treeRootKey);
List tree = new ArrayList();
if (imap.get(treeRootKey) == null) {
    out.print(HtmlTool.msgBox(request, "没有树结点！"));
    return;
}
StringBuffer strTree = new StringBuffer();
for (Iterator it = ((List)imap.get(treeRootKey)).iterator(); it.hasNext();) {
    Device pv = (Device)it.next();
    TreeItem ti = v.initTree(pv, imap);
    strTree.append(HtmlTool.getTreeView(ti, "tree", "tree", "treeClick", 1, true));
    //strTree.append(HtmlTool.getCheckBoxTree(ti, "tree", "tree", 1));
}
%>
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<link rel="STYLESHEET" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/xtree.js"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/js/xtree.css">
</head>
<body>
<script type="text/JavaScript">
function treeClick(item) {
    alert(item.data);
}
if (document.getElementById) {
    var tree = new WebFXTree("设备");
    //var tree = new WebFXTree("设备", "javascript:void(0);", "[]", 1, 0);
    tree.setBehavior("classic");
    <%=strTree%>
    document.write(tree);
}
</script>
</body>
</html>
