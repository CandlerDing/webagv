<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java"%>
<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.software.main.db.*"%>
<%@page import="com.software.main.*"%>
<%@page import="com.software.util.*,com.software.common.*"%>
<%@page import="java.io.*,java.util.*"%>
<%
  UserInfo userInfo = Tool.getUserInfo(request);
   if (userInfo == null) {
    out.print("<meta http-equiv='refresh' content='0;url=logon.jsp'>");
    return;
  } 
   //out.println("userInfo=========="+userInfo);
  List<String> cdt = new ArrayList<String>();
  String userName =  userInfo.getUser().getName();
  int office = userInfo.getUser().getOFFICEID();
  Office officecode = new Office();
  officecode = officecode.getById(office);   
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy��MM��dd��");
  String riqi = sdf.format(new Date());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD id=Head1>
<TITLE>�ޱ���ҳ</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<link href="<%=request.getContextPath() %>/css/style2.css" rel="stylesheet" type="text/css">
<META content="MSHTML 6.00.2900.5848" name=GENERATOR>
<script type="text/javascript">
	function goHome(){
		window.parent.location='/lay/index.jsp';
	}
	function Home(){
		window.parent.location='/lay/index.jsp';
	}
	function zhuxiao(){
		window.parent.location='<%=request.getContextPath()%>/logoffClose.jsp';
	}
</script>
<style>
/*
Template Name:��Ŀ����
Author:����
*/
@charset "utf-8";
body,h1,h2,h3,h4,h5,h6,dl,dt,dd,ul,ol,li,th,td,p,blockquote,pre,form,fieldset,legend,input,button,textarea,hr{margin:0;padding:0;}
h1,h2,h3,h4,h5,h6{font-size:100%;}
li{list-style:none;}
fieldset,img{border:0;}
table{border-collapse:collapse;border-spacing:0;}
button,input,select,textarea{font-size:100%;}
body,button,input,select,textarea{font:12px/1 Arial,Tahoma,Helvetica,SimSun,san-serif;}
address,cite,dfn,em,var{font-style:normal;}
legend{color:#000;}
code,kbd,samp{font-family:"Courier New",monospace;}
hr{border:none;height:1px;}
a{color:#333;text-decoration:none;}
a:hover{ text-decoration:underline;}
.rel{ position:relative}
.clear{ clear:both; font-size:0; height:0; overflow:hidden; margin:0; padding:0}
.fl{ float:left}
.fr{ float:right}
.clearfix:after{content:"."; display:block; clear:both; height:0; font-size:0; visibility:hidden;}
.clearfix{zoom:1;}

.top{ height:100px; border-bottom:1px solid #14376f;}
.logo{ float:left; padding:0 0 0 0;}
.link{ float:right; padding-top:25px;}
.link a{ padding:0 10px 0 0;}
.main{ padding-left:235px; min-height:754px; background:#e5eef8;}
.notice{ background:url(../images/gong.jpg) repeat-x; height:38px; line-height:38px; color:#013b77;}
.notice span{ float:right; padding-left:15px;}
.notice span em{ font-weight:bold; color:#f53f00;}
.left_t{ background:url(../images/yi.jpg) repeat-x; height:38px; line-height:38px; font-family:"΢���ź�"; font-size:18px; color:#FFF; padding-left:15px; font-weight:bold; width:220px; float:left;}
.left{ width:235px; float:left; position:absolute; left:0px; top:120px; min-height:1110px; background:#4276b6;}
.left_m ul li{ width:235px; float:left;}
.left_m ul li a{ font-size:14px;color:#ffffff; background:url(../images/eer.jpg) no-repeat; line-height:38px; display:block; padding-left:25px;width:210px; float:left;}
.left_m ul li a:hover{ background:url(../images/eere.jpg) no-repeat; text-decoration:none; color:#fdefb9;}


.header{ background:url(../images/topp.jpg) repeat-x; height:140px;}
.header_m{ background:url(../images/xieu.jpg) no-repeat bottom; padding-bottom:7px; height:123px; text-align:center; padding-top:10px;}
.content{ width:420px; background:url(../images/zhong.jpg) no-repeat; height:353px; margin:0 auto; padding-left:580px; padding-top:70px; position:relative;}
.bj{ background:#eef3f8;}
.footer{ background:url(../images/xiad.jpg) repeat-x; height:103px; text-align:center; line-height:103px; color:#aec7e1;}
.content table td{ font-family:"΢���ź�"; font-size:16px; color:#2c4156; line-height:70px;}
.content table td input{ height:25px; line-height:25px;}
#confirm{ background:url(../images/dengl.jpg) repeat-x; height:30px; line-height:30px; width:210px; text-align:center; color:#FFF; border:0px; font-family:"΢���ź�"; font-size:14px;}
.content table td table td{ font-family:"����"; font-size:13px;}
.biaozhi{left:-25px; top:-37px; position:absolute;}
.tool_x table td{ font-family:"΢���ź�"; font-size:17px; line-height:35px; color:#3f70ae;}
.cont{ padding:20px 15px; position:relative;}
.survey_t{ background:url(../images/tio_t.png) no-repeat; height:34px; line-height:34px;}
.survey_t span{ font-family:"΢���ź�"; font-size:14px; color:#e1f9ff; padding-left:10px;}
.survey_z{ background:#11669c; border-left:1px solid #05427f;border-right:1px solid #05427f; padding:5px;}
.survey_x{ background:url(../images/xiede.png) no-repeat; height:4px;}
.survey_z table td{ padding:5px; border:0px;}
.survey{ margin-bottom:10px;}
.virtue_t{ background:url(../images/xing_t.png) no-repeat; height:32px; line-height:32px;}
.virtue_t span{font-family:"΢���ź�"; font-size:14px; color:#fff; padding-left:10px;}
.virtue_z{}
.virtue_x{ background:url(../images/tio_x.png) no-repeat; height:4px;}
.virtue_z ul li a{ background:url(../images/xing.png) no-repeat; height:33px; line-height:33px; padding-left:27px; font-family:"΢���ź�"; color:#afd7ea; width:175px; float:left;}
.effect{ border:1px solid #cdd9e6; background:#FFF; margin-bottom:10px; margin-top:2px;}
.effect_l{ float:left;}
.effect_r{padding:10px;}
.effect table td p a{ line-height:40px; font-size:13px; color:#244d7f; font-family:"΢���ź�";}
.effect table td table td{ padding:0 10px;}

.footer_x{ background:#4276b6; height:40px; text-align:center; line-height:40px; color:#FFF;}
.erji{ background:#FFF;}
</style>

</HEAD>
<BODY style="background:#4276b6;" style="overflow:hidden;scroll-y:none">
<div class="top">
	<div class="logo"><img src="<%=request.getContextPath() %>/images/logo1.gif" />
	<img src="<%=request.getContextPath() %>/images/logo06.png" />
	</div>
		<div class="link">
		<%-- <a href="#"><img src="<%=request.getContextPath() %>/images/shouye.png" width="74" height="65" onclick="Home()" /></a> --%>
         <a href="#"><img src="<%=request.getContextPath() %>/images/zhuiao.png" width="74" height="65" onclick="zhuxiao()" /></a>
    </div>
</div>
<div align="right" style="padding-left:15px;background:url(<%=request.getContextPath()%>/images/gong.jpg) repeat-x; height:38px; line-height:38px; color:#013b77;">
<span style="width: 73%"></span>
<span>��ǰ�û�: <%=officecode!=null?officecode.getName():"" %>&nbsp;&nbsp;<%=userName.length()>0?userName:"" %></span> 
<span>���ڣ�<%=riqi %>&nbsp;&nbsp;<%=String.format("%ta", new Date()) %></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</BODY>
</HTML>
