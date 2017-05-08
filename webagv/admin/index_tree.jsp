<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%!
private static final String[] allFormNames={"id"};
%>
<%String cmd = ParamUtils.getParameter(request,"cmd","DeptCode");
String deptid = ParamUtils.getParameter(request,"deptid","0");
String Classid = ParamUtils.getParameter(request,"Classid","0");
//String cmd = ParamUtils.getParameter(request,"cmd","DeptCode");
HttpTool.saveParameters(request, "Ext", allFormNames);
List paras = HttpTool.getSavedUrlForm(request, "Ext");
List urls = (List)paras.get(0);
List noneCmd = new ArrayList();
//urlsÈ¥µôcmd
if(urls!=null)
{
  for(int i=0 ;i<urls.size();i++)
  {

    if(!((String)urls.get(i)).startsWith("cmd") && !((String)urls.get(i)).startsWith("deptid"))
    noneCmd.add(urls.get(i));
  }
}
List forms = (List)paras.get(1);
urls.addAll((List)paras.get(2));
forms.addAll((List)paras.get(3));
String url = Tool.join("&", urls);
String urlNoneCmd = Tool.join("&",noneCmd);
%>
<html>
<head>
<title><%=HeadConst.product_name%></title>
<meta http-equiv="Content-Type" Content="text/html; charset=gb2312">
<link rel="STYLESHEET" type="text/css" href="<%=request.getContextPath()%>/images/default/web_oa.css">
<style type="text/css">
<!--
body { margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; background-color: #F1F1F7; }
.css { font-size: 12px; color: #FFFFFF; text-decoration: none; word-spacing: 0.1em; letter-spacing: 0.1em; }
.hei { font-size: 12px; color: #000000; letter-spacing: 0.1em; word-spacing: 0.1em; }
-->
</style>
<script>
var cmd = "<%=cmd%>";
var dic = {"DeptUserCode":["<%=request.getContextPath()%>/admin/DeptUserCodeAction.jsp?cmd=list&deptid=", "DeptUserCodeAction.jsp?cmd=create&deptid="],
		   "DictCode"    : ["<%=request.getContextPath()%>/canshu/DictCodeAction.jsp?cmd=list&Classid=", "DictCodeAction.jsp?cmd=create&Classid=","DictCodeAction.jsp?cmd=modify&Code=","DictCodeAction.jsp?cmd=delete&Id="],
		   "PhotoTree"      : ["<%=request.getContextPath()%>/photo/PhototreeAction.jsp?cmd=list&Classid=", "PhototreeAction.jsp?cmd=create&Code=","PhototreeAction.jsp?cmd=modify&Code=","PhototreeAction.jsp?cmd=delete&Id="],
		   "photo"      : ["<%=request.getContextPath()%>/photo/PhotosAction.jsp?cmd=list&Classid=", "PhotosAction.jsp?cmd=create&Code=","PhotosAction.jsp?cmd=modify&Code=","PhotosAction.jsp?cmd=delete&Id="],
		   
		   "CarCode"      : ["<%=request.getContextPath()%>/agv/CarAction.jsp?cmd=list&Classid=", "CarAction.jsp?cmd=create&Classid=","CarAction.jsp?cmd=modify&Code=","CarAction.jsp?cmd=delete&Id="],
		   "TaskTree"      : ["<%=request.getContextPath()%>/agv/TaskAction.jsp?cmd=list&Classid=", "TaskAction.jsp?cmd=create&Classid=","TaskAction.jsp?cmd=modify&Code=","TaskAction.jsp?cmd=delete&Id="],
		   "SxTree"      : ["<%=request.getContextPath()%>/dangan/SxwjAction.jsp?cmd=list&Classid=", "SxwjAction.jsp?cmd=create&Classid=","SxwjAction.jsp?cmd=modify&Code=","SxwjAction.jsp?cmd=delete&Id="],
		   "KjTree"      : ["<%=request.getContextPath()%>/dangan/KjwjAction.jsp?cmd=list&Classid=", "KjwjAction.jsp?cmd=create&Classid=","KjwjAction.jsp?cmd=modify&Code=","KjwjAction.jsp?cmd=delete&Id="],		   
		   "DzTree"      : ["<%=request.getContextPath()%>/dangan/DzwjAction.jsp?cmd=list&Classid=", "DzwjAction.jsp?cmd=create&Classid=","DzwjAction.jsp?cmd=modify&Code=","DzwjAction.jsp?cmd=delete&Id="],
		   "JjTree"      : ["<%=request.getContextPath()%>/dangan/JjwjAction.jsp?cmd=list&Classid=", "JjwjAction.jsp?cmd=create&Classid=","JjwjAction.jsp?cmd=modify&Code=","JjwjAction.jsp?cmd=delete&Id="],
		   "SwTree"      : ["<%=request.getContextPath()%>/dangan/SwwjAction.jsp?cmd=list&Classid=", "SwwjAction.jsp?cmd=create&Classid=","SwwjAction.jsp?cmd=modify&Code=","SwwjAction.jsp?cmd=delete&Id="],
		   "TjTree"      : ["<%=request.getContextPath()%>/dangan/TjwjAction.jsp?cmd=list&Classid=", "TjwjAction.jsp?cmd=create&Classid=","TjwjAction.jsp?cmd=modify&Code=","TjwjAction.jsp?cmd=delete&Id="],
		   "AjTree"      : ["<%=request.getContextPath()%>/dangan/WsajAction.jsp?cmd=list&Classid=", "WsajAction.jsp?cmd=create&Classid=","WsajAction.jsp?cmd=modify&Code=","WsajAction.jsp?cmd=delete&Id="],
	       "Rmsy"        : ["<%=request.getContextPath()%>/dangan/DsrAction.jsp?cmd=list&Classid=", "DsrAction.jsp?cmd=create&Classid=","DsrAction.jsp?cmd=modify&Code=","DsrAction.jsp?cmd=delete&Id="],
		   "Cfwzsy"      : ["<%=request.getContextPath()%>/jiansuo/CfdaAction.jsp?cmd=list&Classid=", "CfdaAction.jsp?cmd=create&Classid=","CfdaAction.jsp?cmd=modify&Code=","CfdaAction.jsp?cmd=delete&Id="],
		   "Rmtree"      : ["<%=request.getContextPath()%>/canshu/RmsyAction.jsp?cmd=list&Classid=", "WsdaAction.jsp?cmd=create&Classid=","SsdaAction.jsp?cmd=modify&Code=","SsdaAction.jsp?cmd=delete&Id="],
		   "Cfwztree"    : ["<%=request.getContextPath()%>/canshu/CfwzAction.jsp?cmd=list&Classid=", "WsdaAction.jsp?cmd=create&Classid=","SsdaAction.jsp?cmd=modify&Code=","SsdaAction.jsp?cmd=delete&Id="],
		   "Qyml"        : ["<%=request.getContextPath()%>/jiansuo/Quanyinml.jsp?Classid=", "","",""],
		   "Whsy"        : ["<%=request.getContextPath()%>/jiansuo/Wenhaosy.jsp?Classid=", "","",""],
		   "Zrzsy"        : ["<%=request.getContextPath()%>/jiansuo/Zrzsy.jsp?Classid=", "","",""],
		   "Jnwjmb"      : ["<%=request.getContextPath()%>/canshu/JnwjmbAction.jsp?cmd=list&Classid=", "JnwjmbAction.jsp?cmd=create&Classid=","JnwjmbAction.jsp?cmd=modify&Code=","JnwjmbAction.jsp?cmd=delete&Id="],
		   "Daibiao"     : ["<%=request.getContextPath()%>/daibiao/DaibiaoAction.jsp?cmd=list&Id=", "<%=request.getContextPath()%>/daibiao/DaibiaoAction.jsp?cmd=create&Id="]
};
var unitIdSet = [0];
var currItem = ["", "", "", "", "", ""]; // id,code,,name
function query() {
   content1.location = dic[cmd][0] + currItem[0]+"&code="+currItem[1]+"&<%=Tool.jsSpecialChars(urlNoneCmd)%>";
  // content1.location = "<%=request.getContextPath()%>/admin/DeptUserCodeAction.jsp?cmd=list&deptid="+currItem[0];
}
function create(){
    content1.location = dic[cmd][1] + currItem[1];
}
function modify(){
    content1.location = dic[cmd][1] + currItem[1];
}
function PageReload(){
    list1.location.reload();
}

function listReload(src){
    list1.location = src;
}

function addNew0() {

    content1.location = "admin/DeptUserCodeAction.jsp?cmd=create&deptid="+currItem[0];

}
function deleteList0()
{
  content1.deleteList0();
}
function save()
{
  content1.save();
}
</script>
<script language="" src="<%=request.getContextPath()%>/js/function.js" type="text/javascript"></script>
<script language="" src="<%=request.getContextPath()%>/js/tree.js" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">
<!--
function init() {
    //parent.init();
}
//-->
</script>
<style>
//body { margin-bottom: 12px; }
</style>
</head>
<body onload="init();" style="overflow-y: hidden">
    <table border=0 cellpadding=0 cellspacing=0 height="100%">
        <tr>
            <td valign="top"  height="99%">
                <iframe name=list1 id="list1" style="height:100%;visibility: inherit; width: 209px; z-index: 2" scrolling=auto frameborder=0 src="list.jsp?cmd=<%=cmd%>&Classid=<%=Classid%>"></iframe>
            </td>
            <td valign="top" width=99%>
                <iframe name="content1" id="content1" style='height:100%;visibility : inherit; width: 100%; z-index: 2'  scrolling=auto frameborder=0 src='main.jsp'></iframe>
            </td>
        </tr>
    </table>
</body>
</html>
