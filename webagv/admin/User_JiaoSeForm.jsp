<%@ page language="java" %>
<%--角色表--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(User_JiaoSe.class);
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
User_JiaoSe v = (User_JiaoSe)request.getAttribute("fromBean");
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

String[] ids = Tool.split(",", v.getModule());
List<String> rolenames = new ArrayList<String>();
for (int i = 0; i < ids.length; i ++) {
    User_Module userModule = new User_Module();
    userModule = userModule.getById(Integer.parseInt(ids[i]));
    if(userModule!=null && userModule.getId()>0)
    {
      rolenames.add(userModule.getName());
    }
}

User_JiaoSeList userList = new User_JiaoSeList();
List cdt = new ArrayList();
cdt.add("JiaoSeId="+v.getId());
cdt.add("order by id");

List<User_JiaoSeList> userLists = userList.query(cdt);
List user = new ArrayList();
List userName = new ArrayList();
if(userLists!=null && userLists.size()>0)
{
  for(int i=0;i<userLists.size();i++)
  {
    userList = userLists.get(i);
    user.add(""+userList.getUserId());
      User ucuc = new User();
      ucuc = ucuc.getById(Integer.parseInt(userList.getUserId())) ;
      if(ucuc!=null && ucuc.getCode().length()>0)
      {
       userName.add("("+userList.getDeptName()+")"+ucuc.getName());
      }
  }
}
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" language="JavaScript" src="<%=request.getContextPath()%>/js/validation-framework.js"></script>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/prototype.js"></script>
<script type="text/JavaScript">
ValidationFramework.init("<%=request.getAttribute("classname")%>_validation.xml");
</script>
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
           postForm_User_JiaoSe.submit();
}
function initP() {
             parent.buttonlist = ["reload","save","browse"];;
    					parent.init();
}
//parent调用方法 end
var urls = {
    "Module" : "cmd=Module&type=1",
    "JiaoSeUserList"   : "cmd=JiaoSeUserList&type=1"
};
function select_items(idname, names)
{
    var url = "role_ChoiceAction.jsp?"+urls[idname];
    var ids = eval("document.postForm_User_JiaoSe."+ idname +".value");
    if (ids !=  "") {
        url += "&checked_ids=" + ids;
    }
    openwin=window.open(url,"new_choice","top=58,left=140,width=400,height=600,status=no,toolbar=no,menubar=no,scrollbars=no, resizable=no");
}

function select_itemsUser(idname, names)
{
  var url = "role_ChoiceAction.jsp?"+urls[idname];


    url += "&Classid=<%=v.getId()%>";

   openwin=window.open(url,"new_choice","top=58,left=140,width=400,height=600,status=no,toolbar=no,menubar=no,scrollbars=no, resizable=no");
}
function set_data(rtn)
{
    var items = rtn["items"];
    var item = rtn["item"];
    var name = rtn["name"];
    var ids = [];
    var names = [];
    var j = 0;
   // alert(items.length);
    for (var i = 0; i < items.length; i++) {
      
        if(items[i][1] == 1){ //选中的

        if(rtn.name=="Module")//模块
    {
      if(items[i][0][0].id>0)
      {
        ids[j]= items[i][0][0].id;
        names[j ++] = items[i][0][0].name ;
      }
    }else if(rtn.name=="JiaoSeUserList")
    {
    	if(items[i][0][0].type=="user")//只需要用户
		{
	      if(items[i][0][0].id.length>0)
	      {
	        ids[j]= items[i][0][0].id;
	        names[j ++] = items[i][0][0].name ;
	      }
	      }
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
    if(rtn.name=="Module")//模块
    {
      document.postForm_User_JiaoSe.Module.value = ids.join(",");
      document.postForm_User_JiaoSe.ModuleNames.value = names.join(",");
    }else if(rtn.name=="JiaoSeUserList")//拥有该角色的用户列表
    {
      document.postForm_User_JiaoSe.JiaoSeUserList.value = ids.join(",");
      document.postForm_User_JiaoSe.UserNameList.value = names.join(",");
    }
}

function changehref(strurl)
{
    location.href=strurl;
}
function autoChang()
{
    document.postForm_User_JiaoSe.ModuleNames.style.height = document.postForm_User_JiaoSe.ModuleNames.scrollHeight;
}

function select_users()
{
    var url = "getUserCenterUserCode.jsp?jiaoseid=<%=v.getId()%>";
    openwin=window.open(url,"setUser","top=58,left=140,width=400,height=300,status=no,toolbar=no,menubar=no,scrollbars=no, resizable=no");
}


</script>
</head>
<body onload="init();">
<div id="nav1" style="display:">
    <ul>
        <li><img src="<%=request.getContextPath()%>/images/default/16_04.gif"  border=0 onclick="save();" style="cursor:pointer;"></li>
        <li><img src="<%=request.getContextPath()%>/images/default/s_sx.gif" border=0 onclick="document.postForm_User_JiaoSe.reset();" style="cursor:pointer;"></li>
        <li><a href="User_JiaoSeAction.jsp?cmd=list&page=<%=currpage%><%=((url.length() == 0) ? "" : "&" + url)%>"><img src="<%=request.getContextPath()%>/images/default/s_back.gif"></a></li>
        <!--拥有该角色的用户-->
        <li>拥有该角色的用户</li>

    </ul>
 	 <table border="0" width="100%" cellspacing="0" cellpadding="0">
		   <tr>
			    <td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
		   </tr>
	   </table>
</div>
<div id="errorDiv" style="color:red;font-weight:bold"></div>
<div id="jserrorDiv" style="color:red;font-weight:bold"></div>
<div id="form">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_User_JiaoSe" id="postForm_User_JiaoSe">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>

<input type="hidden" name="Id" value="<%=v.getId()%>">
<table border="0" width="100%" cellspacing="0">
<tr "">
<td colspan="3" class="title_bgcolor" align=center>--- 设置系统角色 ---</td>
</tr>
<%
if(v.getIdP()>0)
{
  User_JiaoSe userModule= new User_JiaoSe();
  userModule = userModule.getById(v.getIdP());
  if(userModule!=null && userModule.getId()>0)
  {%>
  <tr id="postForm_User_Module_Code"><td class="td_label">
<div align="right">上级角色:</div>
</td><td class="td_value">
   <font style='color:red;font-weight:bold;line-height:30px;'><%=userModule.getName()%></font>
</td></tr>

  <%}
}
%>
<tr id="postForm_User_JiaoSe_Code"><td class="td_label">
<div align="right">角色编码:</div>
</td><td class="td_value">
<input name="Code" size="50" maxlength="50" value="<%=v.getCode()%>" readonly="readonly">(系统自动生成，不可修改)
</td></tr>
<tr id="postForm_User_JiaoSe_Name"><td class="td_label">
<div align="right">角色名称:</div>
</td><td class="td_value">
<input name="Name" size="50" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<input type="hidden" name="IdP" value="<%=v.getIdP()%>">
<tr id="postForm_User_JiaoSe_Module"><td class="td_label">
<div align="right">对应模块列表:</div>
</td><td class="td_value">
  <input type="hidden" name="Module" value="<%=v.getModule()%>">
  <textarea name="ModuleNames" cols="66" rows="5" readonly  ><%=Tool.join(",", rolenames)%></textarea>
  <img hidefocus src="<%=request.getContextPath()%>/images/004.gif" onclick="select_items('Module','ModuleNames');" class="button" style="cursor:pointer">
</td></tr>

<tr id="postForm_User_JiaoSe_Remark"><td class="td_label">
<div align="right">拥有该角色的用户:</div>
</td><td class="td_value">
  <input type="hidden" name="JiaoSeUserList" id="JiaoSeUserList" value="<%=Tool.join(",",user)%>">
<textarea name="UserNameList" id="UserNameList" cols="66" rows="5"><%=Tool.join(",",userName)%></textarea>
<img hidefocus src="<%=request.getContextPath()%>/images/004.gif" onclick="select_itemsUser('JiaoSeUserList','UserNameList');" class="button" style="cursor:pointer">
</td></tr>
<tr id="postForm_User_JiaoSe_Remark"><td class="td_label">
<div align="right">备注:</div>
</td><td class="td_value">
<textarea name="Remark" cols="40" rows="2"><%=v.getRemark()%></textarea>
</td></tr>
</table>
</form>
</div>
</body>
</html>
