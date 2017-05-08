<%@ page language="java" %>
<%----%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
FlashSet flash = new FlashSet();
List cdt = new ArrayList();
cdt.add("flag='1'");
cdt.add("limit 0,4 ");
List<FlashSet>flashs = flash.query(cdt);
String str ="";
for (int i=0; i<flashs.size();i++)
	{flash = flashs.get(i);
	str = str+"|"+ flash.getImgUrl();
	}
str = str.substring(1);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>JQUERY实现图片自动切换</title>
<style>
body{margin:0px; padding:0px; font-family:Arial}
ul{list-style:none;margin:0px;padding:0px}
.click_out{margin-left:5px; float:left; text-align:center; height:16px; line-height:16px; width:16px; background:#333; color:#FFF; font-weight:bold; font-size:12px; cursor:pointer;_display:inline-block; }
.click_over{margin-left:5px; float:left;text-align:center; height:16px; line-height:16px; width:16px; background:#820000; color:#FFF; font-weight:bold; font-size:12px; cursor:pointer; _display:inline-block; }
</style>
<script language="javascript" src="../js/jquery-1.7.min.js"></script>
</head>
<body>
 	<script>
 	
                        <!--
 
 var focus_width=600;
 var focus_height=340;
 var text_height=0;
 var swf_height = focus_height+text_height;

 
 var pics='<%=str%>';
 var links='|||';
 
 var texts='||';
 document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ focus_width +'" height="'+ swf_height +'">');
 document.write('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="images/pixviewer.swf"><param name="quality" value="high">');
 document.write('<param name="menu" value="false"><param name="wmode" value="transparent"><param name=wmode value="opaque">');
 document.write('<param name="FlashVars" value="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'">');
 document.write('<embed src="images/pixviewer.swf" wmode="opaque" FlashVars="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'" menu="false" bgcolor="#ffffff" quality="high" width="'+ focus_width +'" height="'+ swf_height +'" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); 
 document.write('</object>');
 
 //-->
             </script>
</body>
</html>