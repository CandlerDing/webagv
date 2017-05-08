<%@ page language="java" %>
<%--栏目分类表--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
String url = ParamUtils.getParameter(request,"url","");
String[] urls = Tool.split(".",url);
String swfUrl = urls[0]+".swf";
String basePath = getServletConfig().getServletContext().getRealPath("").replaceAll("\\\\", "/");
String savePath = basePath + url;
String[] fileStrings = Tool.split(".",savePath);
String swfFile = fileStrings[0]+".swf";
String pdfFile = fileStrings[0]+".pdf";

File swf = new File(swfFile);
if(!swf.exists())
{
String toSwf = "C://SWFTools//pdf2swf.exe "+pdfFile+" -o "+ swfFile +" -f -T 9 -t -s storeallcharacters";
execComm execcomm = new execComm();
execcomm.exec(toSwf);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<!-- FlexPaperViewer flash version debug template --> 
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">	
    <head> 
        <title>肥城市人民检察院</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
        <style type="text/css" media="screen"> 
			html, body	{ height:100%; }
			body { margin:0; padding:0; overflow:auto; }   
			#flashContent { display:none; }
        </style> 
		
		<script type="text/javascript" src="<%=request.getContextPath() %>/flexpaper/js/flexpaper_flash_debug.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/flexpaper/js/jquery.js"></script>
		<script>
		var w_max = window.screen.availWidth-350;
			var h_max = window.screen.availHeight-200;
		$(document).ready(function(){
			$("#viewerPlaceHolder").css("width",w_max);
			$("#viewerPlaceHolder").css("height",h_max);
				var index_layout = $('#index_layoutRead').layout({
					fit : true
				});
		}) 
		</script>
    </head> 
    <body> 
    <div id="index_layoutRead" style="top:0px;border:0px;"  >
    	<div style="position:absolute;left:10px;top:10px;">
	    <div data-options="region:'left',fit:true,split:true" title="" style=" overflow: hidden;">
    	<div id="installinfo"></div>
	        <a id="viewerPlaceHolder" style="width:380px;height:590px;display:block"></a>

	        <script type="text/javascript"> 
	  
				var fp = new FlexPaperViewer(	
						 'FlexPaperViewer',
						 'viewerPlaceHolder', { config : {
						 SwfFile : '..<%=swfUrl%>',
						 Scale : 1.3, 
						 ZoomTransition : 'easeOut',
						 ZoomTime : 0.5,
						 ZoomInterval : 0.2,
						 FitPageOnLoad : false,
						 FitWidthOnLoad : true,
						 FullScreenAsMaxWindow : false,
						 ProgressiveLoading : false,
						 MinZoomSize : 0.2,
						 MaxZoomSize : 5,
						 SearchMatchAll : false,
						 InitViewMode : 'Portrait',
						 
						 ViewModeToolsVisible : true,
						 ZoomToolsVisible : true,
						 NavToolsVisible : true,
						 CursorToolsVisible : true,
						 SearchToolsVisible : true,
  						
  						 localeChain: 'en_US'
						 }});
	        </script>  
        </div>
        </div>
   </body> 
</html> 