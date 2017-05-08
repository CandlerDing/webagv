<%@ page language="java" %>
<%--系统功能模块表--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(User_Module.class);
String msg = (String)request.getAttribute("msg");
String back_msg = (String)request.getAttribute("back_msg");
String  listSrc = ParamUtils.getAttribute(request,"listSrc");
Map extMaps = (Map)request.getAttribute("Ext");
List paras = HttpTool.getSavedUrlForm(request, "Ext");
List urls = (List)paras.get(0);
List forms = (List)paras.get(1);
urls.addAll((List)paras.get(2));
forms.addAll((List)paras.get(3));
String url = Tool.join("&", urls);
int currpage = ParamUtils.getIntParameter(request, "page", 1);
if(listSrc!=null){

  out.print("<script>parent.listReload('"+listSrc+"');</script>");
}
if ((msg != null)) {
  String u = "User_ModuleAction.jsp?cmd=list&page=" + currpage + ((url.length() == 0) ? "" : "&" + url) ;
    out.print(HtmlTool.msgBox(request, msg,u,""));
    return;
}
if ((back_msg != null)) {
    out.print(HtmlTool.alert(request, back_msg));
}
String cmd = ParamUtils.getParameter(request, "cmd", "insert");

User_Module v = (User_Module)request.getAttribute("fromBean");
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
//默认值定义
User_ModuleList userList = new User_ModuleList();
List cdt = new ArrayList();
cdt.add("moduleId="+v.getId());
cdt.add("order by id");
List<User_ModuleList> userLists = userList.query(cdt);
List user = new ArrayList();
List userName = new ArrayList();
if(userLists!=null && userLists.size()>0)
{
  for(int i=0;i<userLists.size();i++)
  {
    userList = userLists.get(i);
    if(userList!=null && userList.getId()>0)
    {
      user.add(""+userList.getUserId());
      User ucuc = new User();
      ucuc = ucuc.getById(Integer.parseInt(userList.getUserId())) ;
      if(ucuc!=null && ucuc.getCode().length()>0)
      {
        userName.add("("+userList.getDeptName()+")"+ucuc.getName());
      }
    }
  }
}
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/prototype.js"></script>

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
            postForm_User_Module.submit();
}
function initP() {
             parent.buttonlist = ["reload","save","browse"];;
    					parent.init();
}

var urls = {
    "Module" : "cmd=Module&type=1",
    "JiaoSeUserList"   : "cmd=JiaoSeUserList&type=1"
};
function select_items(idname, names)
{
    var url = "role_ChoiceAction.jsp?"+urls[idname];
        url += "&moduleid=<%=v.getId()%>";

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
    
    for (var i = 0; i < items.length; i++) {
        if(items[i][1] == 1){ //选中的
            if(items[i][0][0].id.length>0)
            {
            	if(items[i][0][0].type=="user")//只需要用户
        		{
              ids[j]= items[i][0][0].id;
              names[j ++] = items[i][0][0].name ;
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

      document.postForm_User_Module.JiaoSeUserList.value = ids.join(",");
      document.postForm_User_Module.UserNameList.value = names.join(",");

}


//parent调用方法 end
// onkeypress="repeatPhone();" onChange="checkPhone(this);"js，无刷新验证手机号，
</script>
</head>
<body onload="init();">
<div id="nav1" style="display:">
    <ul>
        <li><img src="<%=request.getContextPath()%>/images/default/16_04.gif"  border=0 onclick="save();" style="cursor:pointer;"></li>
        <li><img src="<%=request.getContextPath()%>/images/default/s_sx.gif" border=0 onclick="document.postForm_User_Module.reset();" style="cursor:pointer;"></li>
        <li><a href="User_ModuleAction.jsp?cmd=list&page=<%=currpage%><%=((url.length() == 0) ? "" : "&" + url)%>"><img src="<%=request.getContextPath()%>/images/default/s_back.gif"></a></li>
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_User_Module" id="postForm_User_Module">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<input type="hidden" name="Id" value="<%=v.getId()%>">
<table border="0" width="100%" cellspacing="0">
<tr "">
<td colspan="3" class="title_bgcolor" align=center>--- 系统功能模块信息 ---</td>
</tr>
<%
if(v.getIdP()>0)
{
  User_Module userModule= new User_Module();
  userModule = userModule.getById(v.getIdP());
  if(userModule!=null && userModule.getId()>0)
  {%>
  <tr id="postForm_User_Module_Code"><td class="td_label">
<div align="right">上级模块:</div>
</td><td class="td_value">
   <font style='color:red;font-weight:bold;line-height:30px;'><%=userModule.getName()%></font>
</td></tr>

  <%}
}
%>
<tr id="postForm_User_Module_Remark"><td class="td_label">
<div align="right">模块分类:</div>
</td><td class="td_value">
<select name="ModuleType">
<option value="数据中心" <%if(v.getModuleType().equals("数据中心")){ out.print("selected");} %>>数据中心</option>
</select>
</td></tr>
<tr id="postForm_User_Module_Code"><td class="td_label">
<div align="right">模块编码:</div>
</td><td class="td_value">
<input name="Code" size="50" maxlength="50" value="<%=v.getCode()%>" readonly="readonly">(系统自动生成，不可修改)
</td></tr>
<tr id="postForm_User_Module_Name"><td class="td_label">
<div align="right">模块名称:</div>
</td><td class="td_value">
<input name="Name" size="50" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<input type="hidden" name="IdP" value="<%=v.getIdP()%>">
<tr id="postForm_User_Module_FileName"><td class="td_label">
<div align="right">模块操作文件:</div>
</td><td class="td_value">
<input type="text" name="FileName" value="<%=v.getFileName()%>" size="50">
</td></tr>
<tr id="postForm_User_JiaoSe_Remark"><td class="td_label">
<div align="right">拥有该模块的用户:</div>
</td><td class="td_value">
  <input type="hidden" name="JiaoSeUserList" id="JiaoSeUserList" value="<%=Tool.join(",",user)%>">
<textarea name="UserNameList" id="UserNameList" cols="66" rows="5"><%=Tool.join(",",userName)%></textarea>
<img hidefocus src="<%=request.getContextPath()%>/images/004.gif" onclick="select_items('JiaoSeUserList','UserNameList');" class="button" style="cursor:pointer">
</td></tr>
<tr id="postForm_User_Module_Remark"><td class="td_label">
<div align="right">是否是基本模块:</div>
</td><td class="td_value">
<select name="CanShu">
<option value="" <%if(v.getCanShu().equals("")){ out.print("selected");} %>>否</option>
<option value="*" <%if(v.getCanShu().equals("*")){ out.print("selected");} %>>是</option>
</select>注：选择“是”基本模块，则所有员工都有此权限；
</td></tr>
<tr id="postForm_User_Module_Remark"><td class="td_label">
<div align="right">是否在新窗口打开:</div>
</td><td class="td_value">
<select name="OpenFlag">
<option value="0" <%if(v.getOpenFlag().equals("") || v.getOpenFlag().equals("0")){ out.print("selected");} %>>否</option>
<option value="1" <%if(v.getOpenFlag().equals("1")){ out.print("selected");} %>>是</option>
</select>
</td></tr>
<tr id="postForm_User_Module_Remark"><td class="td_label">
<div align="right">排序:</div>
</td><td class="td_value">
<input type=text name="Remark" id="Remark" value="<%=v.getRemark()%>">
</td></tr>
</table>
</form>
</div>
</body>
</html>