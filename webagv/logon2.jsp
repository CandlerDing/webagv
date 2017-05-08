<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>登录页面</title>
<link href="<%=request.getContextPath() %>/css/stylelogon.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
<script language="JavaScript">
$(document).ready(function(){
    //获取Cookie保存的用户名
      getLoginCookie();
      });
//页面装载时,进行焦点定位
//如果名字有内容同时选中了记住名字
//则焦点转移到密码框
function setFocus()
{
    if (document.logon.txt_username.value != ""){
        document.logon.txt_password.focus();
    }
    else{
        document.logon.txt_username.focus();
    }
    return;
}
//检测到回车就提交
function keyEnter(iKeyCode) 
{
	//仅对于IE有效
	ie = (document.all)? true:false;
	if (ie){
		if(window.event.keyCode==13){
			checkuser();
		}
	}
	
}
function set_flag(flag)
{
	document.getElementById("flag").value=flag;
}
//检测窗口关闭
var timer;
function IfWindowClosed()
{
 if(openwin.closed == true)
  {
    //alert("点确定后将要退出本系统！");
    window.open("logoff.jsp","","width=100,height=100,left=100,top=100");
    window.clearInterval(timer);
  }
}
//检查用户输入，无误后提交
function checkuser()
{
   if(document.getElementById("txt_username").value==""){
      alert("请输入用户名字！");
      document.getElementById("txt_username").focus();
      return;
      //return false;
   }
   if(document.getElementById("txt_password").value==""){
      alert("请输入用户密码！");
      document.getElementById("txt_password").focus();
      return;
      //return false;
   }
   if(document.getElementById("chk_memoryme").checked)
	{
   	setLoginCookie();
	}else{
	 deleteCookie();
	}
   	  openwin=window.open("","beelink_web_oa_main","scrollbars=yes");
        openwin.moveTo(0,0);
	openwin.resizeTo(screen.width,screen.height-25);
	document.getElementById("logon").target="beelink_web_oa_main";
	document.getElementById("logon").method="post";
	document.getElementById("logon").action="enter.jsp";
	document.getElementById("logon").submit();
	document.getElementById("txt_password").value="";
	/* //检测窗口关闭
	timer=window.setInterval("IfWindowClosed()",500); */
   //return true;
}
//填充用户名称密码
function getLoginCookie(){
		var username= getCookie("jnzyName") ; 
		
		if(username!=null && username!=""){ 
		 	document.getElementById("txt_username").value=username;
		 	//document.getElementById("txt_password").value=password;
		 	document.getElementById("chk_memoryme").checked = true;
		  } 
	}

 function getCookie(c_name)      //根据分隔符每个变量的值
 {
     if (document.cookie.length > 0) {
         c_start = document.cookie.indexOf(c_name + "=");
         if (c_start != -1) { 
             c_start = c_start + c_name.length + 1;
             c_end = document.cookie.indexOf("@@@",c_start);
             if (c_end==-1)
                 c_end=document.cookie.length;
             return unescape(document.cookie.substring(c_start,c_end));
     } 
   }
     return "";
 }
 
 function deleteCookie(){
	 
	 var exdate = new Date();
     exdate.setDate(exdate.getDate() - 1000);
     document.cookie = "jnzyName=^;expires=" + exdate.toGMTString();
 }
 function setLoginCookie(){
		
		var username=document.getElementById("txt_username").value;
        setCookie("jnzyName", username,  30);
	}
 
 function setCookie(c_name, n_value, expiredays)        //设置cookie
 {
     var exdate = new Date();
     exdate.setDate(exdate.getDate() + expiredays);
     document.cookie = c_name + "=" + escape(n_value) + ((expiredays == null) ? "" : "@@@;expires=" + exdate.toGMTString());
 }
</script>
</head>
<body class="bj">
<!--[if IE 6]>
<script src="js/png.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('.header_m img');
DD_belatedPNG.fix('.biaozhi img');
</script>
<![endif]-->
<div class="header">
	<div class="header_m"><img src="<%=request.getContextPath() %>/images/logog.png" width="704" height="85" /></div>
</div>
<div class="content">
 <form name="logon" id="logon" action="enter.jsp" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="18%">用户名：</td>
    <td width="82%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="62%"><input type="text" name="txt_username" id="txt_username" size="32" value=""  onfocus="this.select()" onmouseover="this.focus()" title="请在此处输入用户登录名"/></td>
        <td width="6%"><input type="checkbox" name="chk_memoryme" id="chk_memoryme" value="on" checked="checked" /></td>
        <td width="32%">记住名字</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>密码：</td>
    <td><input type="password" name="txt_password" id="txt_password" size="32"  onfocus="this.select()" onmouseover="this.focus()" title="请在此处输入用户密码"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><label>
      <input type="button" name="button" id="confirm" onclick='checkuser();' value="提交" />
    </label></td>
  </tr>
  <tr>
    <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="14%">&nbsp;</td>
        <td width="6%"><input type="hidden" id="flag" name="flag" value="1"/> <input name="rad_gotourl" id="rad_gotourl" type="radio" value="2" checked="checked"  onclick='set_flag(1);'/></td>
        <td width="30%">登录到办公系统</td>
        <td width="6%"><input name="rad_gotourl" id="rad_gotourl" type="radio" value="2" onclick='set_flag(2);'/></td>
        <td width="30%">登录到系统维护 </td>
        <td width="14%">&nbsp;</td>
      </tr>
    </table></td>
    </tr>
</table></form>
<div class="biaozhi"><img src="<%=request.getContextPath() %>/images/guow.png"  /></div>
</div>
<div class="footer">济南索码软件Web_OA系统 版本号2.0 </div>
</body>
</html>