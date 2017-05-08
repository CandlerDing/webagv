<%@ page language="java" %>
<%--FLASH设置--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(FlashSet.class);
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
FlashSet v = (FlashSet)request.getAttribute("fromBean");
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
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" language="JavaScript" src="<%=request.getContextPath()%>/js/validation-framework.js"></script>
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
            postForm_FlashSet.submit();
}
function initP() {
             parent.buttonlist = ["reload","save","browse"];;
    					parent.init();
}
$(document).ready(function() {
	
    $("#uploadify").uploadify({  
                   'auto'           : false,  
                   'swf'            : '<%=request.getContextPath()%>/uploadify/uploadify.swf',  
                   'uploader'       : '<%=request.getContextPath()%>/uploadify/uploadifyflash',//后台处理的请求  
                   'queueID'        : 'fileQueue',//与下面的id对应  
                   'queueSizeLimit' : 5,  
                   'progressData'   : 'percentage', 
                   'fileTypeDesc'   : 'jpg文件',  
                   'fileTypeExts'   : '*.jpg', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc 
                   'auto'           : true,
                   'multi'          : true,                    
                   'buttonText'     : '选择jpg文件',
                   'onUploadSuccess' : function(file, data, response) {//alert(data);
                 	  $("#ImgUrl").val(data); 
                 	 $("#showPhoto").val(data);    
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
        <li><img src="<%=request.getContextPath()%>/images/default/s_sx.gif" border=0 onclick="document.postForm_FlashSet.reset();" style="cursor:pointer;"></li>
        <li><a href="FlashSetAction.jsp?cmd=list&page=<%=currpage%><%=((url.length() == 0) ? "" : "&" + url)%>"><img src="<%=request.getContextPath()%>/images/default/s_back.gif"></a></li>
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_FlashSet" id="postForm_FlashSet">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<table border="0" width="100%" cellspacing="0">

<input type="hidden" name="Id" value="<%=v.getId()%>">
<tr id="postForm_FlashSet_ImgUrl"><td class="td_label">
<div align="right">序号:</div>
</td><td class="td_value">
<input name="Xh" id="Xh"   size="20" maxlength="60" value="<%=(v.getXh()>0?v.getXh():"")%>">
</td></tr>

<tr id="postForm_FlashSet_ImgUrl"><td class="td_label">
<div align="right">图片:</div>
</td><td class="td_value">
<div id="fileQueue"></div>
	<input type="file" name="uploadify" id="uploadify" />
	<%-- <%if(v.getImgUrl().length()>0)
	{%>
	<img alt="图片" id="showPhoto" name="showPhoto" src="../flash/<%=v.getImgUrl() %>" width="120" height="68">
	<% 
	}%> --%>
	推荐尺寸600*340像素
<input name="ImgUrl" id="ImgUrl"  type="hidden" value="<%=v.getImgUrl()%>">

</td></tr>
<tr id="postForm_FlashSet_Flag"><td class="td_label">
<div align="right">是否启用:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, v.getFlag(), "Flag", "")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRaio(YesNooptions, v.getFlag(), "Flag", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, v.getFlag(), "Flag", "")%>
</td></tr>
</table>
</form>
</div>
</body>
</html>
