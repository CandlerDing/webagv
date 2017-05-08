<%@ page language="java" %>
<%--文章信息--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
String IsCheck = ParamUtils.getParameter(request, "_IsCheck_", "1");
Log log = LogFactory.getLog(Article.class);
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
Article v = (Article)request.getAttribute("fromBean");
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
List YesNooptions = (List)request.getAttribute("YesNooptions");
List ChannelNameoptions = (List)request.getAttribute("ChannelNameoptions");
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/default/web_oa.css">
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/formfunction.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath()%>/uploadify/jquery.uploadify.min.js"></script>
<link href="<%=request.getContextPath()%>/uploadify/uploadify.css"  rel="stylesheet" type="text/css">
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
            postForm_Article.submit();
}
function initP() {
             parent.buttonlist = ["reload","save","browse"];;
    					parent.init();
}
$(document).ready(function() {
	
    $("#uploadify").uploadify({  
                   'auto'           : false,  
                   'swf'            : '<%=request.getContextPath()%>/uploadify/uploadify.swf',  
                   'uploader'       : '<%=request.getContextPath()%>/uploadify/uploadifywszd',//后台处理的请求  
                   'queueID'        : 'fileQueue',//与下面的id对应  
                   'queueSizeLimit' : 5,  
                   'progressData'   : 'percentage', 
                   'fileTypeDesc'   : 'Word文件',  
                   'fileTypeExts'   : '*.doc;*.docx', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc 
                   'auto'           : true,
                   'multi'          : true,                    
                   'buttonText'     : '选择Word文件',
                   'onUploadSuccess' : function(file, data, response) {//alert(data);
                 	  $("#Siteurl").val(data);       
             	   } 
    }); 
})
//parent调用方法 end
// onkeypress="repeatPhone();" onChange="checkPhone(this);"js，无刷新验证手机号，
</script>
</head>
<body onload="init();">
<div id="nav1" style="display:">
    <ul>
        <li><img src="<%=request.getContextPath()%>/images/default/16_04.gif"  border=0 onclick="save();" style="cursor:pointer;"></li>
        <li><img src="<%=request.getContextPath()%>/images/default/s_sx.gif" border=0 onclick="document.postForm_Article.reset();" style="cursor:pointer;"></li>
        <li><a href="ArticleAction.jsp?cmd=list&page=<%=currpage%><%=((url.length() == 0) ? "" : "&" + url)%>"><img src="<%=request.getContextPath()%>/images/default/s_back.gif"></a></li>
    </ul>
 	 <table border="0" width="100%" cellspacing="0" cellpadding="0">
		   <tr>
			    <td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
		   </tr>
	   </table>
</div>
<div id="errorDiv" style="color:red;font-weight:bold"></div>
<div id="jserrorDiv" style="color:red;font-weight:bold"></div>
<div id="form" style="overflow:auto;height:480px">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_Article" id="postForm_Article">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="IsCheck" id="IsCheck" value="<%=(v.getIsCheck()>0?v.getIsCheck():IsCheck)%>">
<input type="hidden" name="Id" value="<%=v.getId()%>">
<%if(IsCheck.equals("1")){ %>
<tr id="postForm_Article_SubTitle"><td class="td_label">
<div align="right">目录:</div>
</td><td class="td_value">
<input name="SubTitle" id="SubTitle" size="50" maxlength="50" value="<%=v.getSubTitle()%>">
</td></tr>
<%} %>
<tr id="postForm_Article_Title"><td class="td_label">
<div align="right">标题(<span class="mastInput">*</span>):</div>
</td><td class="td_value">
<input name="Title" id="Title" size="50" maxlength="50" value="<%=v.getTitle()%>">
</td></tr>

<input name="Siteurl" id="Siteurl" type="hidden" size="50" maxlength="50" value="<%=v.getSiteurl()%>">
<tr id="postForm_Article_Classid"><td class="td_label">
<div align="right">内容:</div>
</td><td class="td_value">
<div id="fileQueue"></div>
	<input type="file" name="uploadify" id="uploadify" />
	<%if(v.getSiteurl().length()>0)
	{%>
	<a  href="readgg.jsp?id=<%=v.getId()%>" target="_blank" class="easyui-linkbutton" data-options="iconCls:'icon-tip'">查看</a>
	<% 
	}%>
</td></tr>
<%--
<tr id="postForm_Article_Summary"><td class="td_label">
<div align="right">摘要:</div>
</td><td class="td_value">
<textarea name="Summary" cols="40" rows="2"><%=v.getSummary()</textarea>
</td></tr>
<tr id="postForm_Article_Img"><td class="td_label">
<div align="right">主图片:</div>
</td><td class="td_value">
<textarea name="Img" cols="40" rows="2"><%=v.getImg()%></textarea>
</td></tr>
<tr id="postForm_Article_Author"><td class="td_label">
<div align="right">作者:</div>
</td><td class="td_value">
<input name="Author" size="50" maxlength="50" value="<%=v.getAuthor()%>">
</td></tr>
<tr id="postForm_Article_FromWhere"><td class="td_label">
<div align="right">来源:</div>
</td><td class="td_value">
<input name="FromWhere" size="50" maxlength="50" value="<%=v.getFromWhere()%>">
</td></tr>
<tr id="postForm_Article_KeyWords"><td class="td_label">
<div align="right">关键词:</div>
</td><td class="td_value">
<textarea name="KeyWords" cols="40" rows="2"><%=v.getKeyWords()%></textarea>
</td></tr>
<tr id="postForm_Article_ReadLevel"><td class="td_label">
<div align="right">阅读权限:</div>
</td><td class="td_value">
<textarea name="ReadLevel" cols="40" rows="2"><%=v.getReadLevel()%></textarea>
</td></tr>
<tr id="postForm_Article_PubDate"><td class="td_label">
<div align="right">发布日期(1999-01-01):</div>
</td><td class="td_value">
<input name="PubDate" size="50" maxlength="50" value="<%=v.getPubDate()%>">
</td></tr>
<tr id="postForm_Article_Pagenum"><td class="td_label">
<div align="right">页数:</div>
</td><td class="td_value">
<input name="Pagenum" value="<%=v.getPagenum()%>">
</td></tr>
<tr id="postForm_Article_Hits"><td class="td_label">
<div align="right">点击次数:</div>
</td><td class="td_value">
<input name="Hits" value="<%=v.getHits()%>">
</td></tr>
<tr id="postForm_Article_IsTop"><td class="td_label">
<div align="right">是否置顶:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsTop(), "IsTop", "0")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsTop(), "IsTop", "0")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsTop(), "IsTop", "0")%>
</td></tr>
<tr id="postForm_Article_IsHot"><td class="td_label">
<div align="right">热点文章:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsHot(), "IsHot", "0")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsHot(), "IsHot", "0")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsHot(), "IsHot", "0")%>
</td></tr>
<tr id="postForm_Article_IsRecommend"><td class="td_label">
<div align="right">推荐文章:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsRecommend(), "IsRecommend", "0")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsRecommend(), "IsRecommend", "0")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsRecommend(), "IsRecommend", "0")%>
</td></tr>
<tr id="postForm_Article_IsDel"><td class="td_label">
<div align="right">回收站:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsDel(), "IsDel", "0")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsDel(), "IsDel", "0")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsDel(), "IsDel", "0")%>
</td></tr>
<tr id="postForm_Article_IsCheck"><td class="td_label">
<div align="right">是否审核发布:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsCheck(), "IsCheck", "0")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsCheck(), "IsCheck", "0")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsCheck(), "IsCheck", "0")%>
</td></tr>
<tr id="postForm_Article_DoTime"><td class="td_label">
<div align="right">:</div>
</td><td class="td_value">
<input name="DoTime" size="-1" value="<%=Tool.stringOfDateTime(v.getDoTime())%>">
</td></tr>
<tr id="postForm_Article_UserId"><td class="td_label">
<div align="right">发布人id:</div>
</td><td class="td_value">
<input name="UserId" size="50" maxlength="50" value="<%=v.getUserId()%>">
</td></tr>
<tr id="postForm_Article_UserName"><td class="td_label">
<div align="right">发布人:</div>
</td><td class="td_value">
<input name="UserName" size="50" maxlength="50" value="<%=v.getUserName()%>">
</td></tr>
<tr id="postForm_Article_Siteurl"><td class="td_label">
<div align="right">静态文章位置:</div>
</td><td class="td_value">
<input name="Siteurl" size="50" maxlength="50" value="<%=v.getSiteurl()%>">
</td></tr> --%>
</table>
</form>
</div>
</body>
</html>
