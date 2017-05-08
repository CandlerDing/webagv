<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%!
private static final String[] allFormNames={"id"};
%>
<%
String cmd = ParamUtils.getParameter(request,"cmd","DeptCode");
HttpTool.saveParameters(request, "Ext", allFormNames);
List paras = HttpTool.getSavedUrlForm(request, "Ext");
List urls = (List)paras.get(0);
List noneCmd = new ArrayList();
//urls去掉cmd
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
var dic = {
    "ArticleCode"       : ["<%=request.getContextPath()%>/article/ArticleAction.jsp?cmd=create&_Classid_=", "AreaCodeAction.jsp?cmd=create&Code=","AreaCodeAction.jsp?cmd=delete&Id="],
    "ArticleCodeModi"   : ["<%=request.getContextPath()%>/article/ArticleAction.jsp?cmd=list&_Classid_=", "AreaCodeAction.jsp?cmd=create&Code=","AreaCodeAction.jsp?cmd=delete&Id="],
    "ChannelCode"       : ["<%=request.getContextPath()%>/Channel/ChannelAction.jsp?cmd=create&Classid=", "AreaCodeAction.jsp?cmd=create&Code=","AreaCodeAction.jsp?cmd=delete&Id="],
    "ChannelSelect"     : ["<%=request.getContextPath()%>/Channel/ChannelAction.jsp?cmd=create&Classid=", "AreaCodeAction.jsp?cmd=create&Code=","AreaCodeAction.jsp?cmd=delete&Id="],
    "DeptUserCode"    : ["<%=request.getContextPath()%>/admin/DeptUserCodeAction.jsp?cmd=list&deptid=", "<%=request.getContextPath()%>/admin/DeptUserCodeAction.jsp?cmd=create&deptid="],
    "DeptUser"    : ["<%=request.getContextPath()%>/admin/DeptUserCodeAction.jsp?cmd=listUser&deptid=", "<%=request.getContextPath()%>/admin/DeptUserCodeAction.jsp?cmd=createUser&deptid="],
    //////////
    "UserModule"       : ["<%=request.getContextPath()%>/admin/User_ModuleAction.jsp?cmd=list&Classid=", "User_ModuleAction.jsp?cmd=modify&Code=","User_ModuleAction.jsp?cmd=delete&Id="],
    "JiaoSe"       : ["<%=request.getContextPath()%>/admin/User_JiaoSeAction.jsp?cmd=list&Classid=", "User_ModuleAction.jsp?cmd=modify&Code=","User_ModuleAction.jsp?cmd=delete&Id="],
    "QuanXian"       : ["<%=request.getContextPath()%>/admin/role_setModule.jsp?cmd=create&Classid=", "role_setModule.jsp?cmd=modify&Code=","role_setModule.jsp?cmd=delete&Id="],
    "CarCode"       : ["<%=request.getContextPath()%>/agv/CarAction.jsp?cmd=list&Classid=", "CarAction.jsp?cmd=modify&Code=","CarAction.jsp?cmd=delete&Id="],
    "TaskCode"       : ["<%=request.getContextPath()%>/agv/TaskAction.jsp?cmd=list&Classid=", "TaskAction.jsp?cmd=modify&Code=","TaskAction.jsp?cmd=delete&Id="],
     "RfidCode"      : ["<%=request.getContextPath()%>/agv/RfidAction.jsp?cmd=list&Classid=", "RfiAction.jsp?cmd=modify&Code=","RfidAction.jsp?cmd=delete&Id="],
    "GoodsTree"      : ["<%=request.getContextPath()%>/agv/GoodsAction.jsp?cmd=list&Classid=", "GoodsAction.jsp?cmd=create&Classid=","GoodsAction.jsp?cmd=modify&Code=","GoodsAction.jsp?cmd=delete&Id="],
    "AddressTree"      : ["<%=request.getContextPath()%>/agv/AddressAction.jsp?cmd=list&Classid=", "AddressAction.jsp?cmd=create&Classid=","AddressAction.jsp?cmd=modify&Code=","AddressAction.jsp?cmd=delete&Id="],
    "CjTree"      : ["<%=request.getContextPath()%>/agv/WorkshopAction.jsp?cmd=list&Classid=", "WorkshopAction.jsp?cmd=create&Classid=","WorkshopAction.jsp?cmd=modify&Code=","WorkshopAction.jsp?cmd=delete&Id="],
    "Opeorder"      : ["<%=request.getContextPath()%>/agv/OpeorderAction.jsp?cmd=list&Classid=", "OpeorderAction.jsp?cmd=create&Classid=","OpeorderAction.jsp?cmd=modify&Code=","OpeorderAction.jsp?cmd=delete&Id="],
    "Controlcar"      : ["<%=request.getContextPath()%>/agv/ControltypeAction.jsp?cmd=list&Classid=", "ControltypeAction.jsp?cmd=create&Classid=","ControltypeAction.jsp?cmd=modify&Code=","ControltypeAction.jsp?cmd=delete&Id="],
    //部门管理
    "OfficeInfo"       : ["<%=request.getContextPath()%>/office/OfficeAction.jsp?cmd=list&Classid=", "OfficeAction.jsp?cmd=modify&Code=","OfficeAction.jsp?cmd=delete&Id="],
    "userBaseInfo"    : ["<%=request.getContextPath()%>/office/UserAction.jsp?cmd=list&Classid=", "UserAction.jsp?cmd=modify&Code=","UserAction.jsp?cmd=delete&Id="]
};
var currItem = ["", "", "", "", "", ""]; // id,code,,name
function query() {
    content1.location = dic[cmd][0] + currItem[0]+"&code="+currItem[1]+"&<%=Tool.jsSpecialChars(urlNoneCmd)%>";
}
function create(){
    content1.location = dic[cmd][1] + currItem[1]+"&<%=Tool.jsSpecialChars(urlNoneCmd)%>";
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
  if(cmd=="AreaCode") //区域编码添加时用code
  {
    content1.location = "admin/"+dic[cmd][1]+currItem[1];
  }else    if(cmd=="CloumnCode")
  {
     content1.location = dic[cmd][1]+currItem[0];
  }else
  {
    content1.location = dic[cmd][1]+currItem[0];
  }

}
function yulan()
{
    content1.yulan();
}
function copy()
{
    content1.copy();
}
function deleteList0()
{
  content1.deleteList0();
}
function save()
{
  content1.save();
}
function winSize(){
				var a=new Array();
				a.st = document.body.scrollTop?document.body.scrollTop:document.documentElement.scrollTop;
				a.sl = document.body.scrollLeft?document.body.scrollLeft:document.documentElement.scrollLeft;
				a.sw = document.documentElement.clientWidth;
				a.sh = document.documentElement.clientHeight;
				a.wp = document.documentElement.scrollWidth || document.body.scrollWidth || 0;
				a.hp =  document.documentElement.scrollHeight || document.body.scrollHeight || 0;
				return a;
			}
</script>


</head>
<body onload="init();">
    <table border=0 cellpadding=0 cellspacing=0 height="100%" width="100%" >
        <tr>
            <td valign="top" height="99%">
                <iframe name="list1" id="list1" style="height:100%;visibility: inherit; width: 209px; z-index: 2" scrolling=auto frameborder=0 src="role_list.jsp?<%=url%>"></iframe>
            </td>
            <td valign="top" width=99% height="99%">
                <iframe name="content1" id="content1" style='height:99%;visibility : inherit; width: 100%;' scrolling=auto frameborder=0 src='role_main.jsp'></iframe>
            </td>
        </tr>
    </table>
</body>
</html>
